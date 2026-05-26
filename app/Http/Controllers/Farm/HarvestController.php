<?php

namespace App\Http\Controllers\Farm;

use App\Http\Controllers\Controller;
use App\Models\Expense;
use App\Models\Harvest;
use App\Models\InventoryItem;
use App\Models\InventoryTransaction;
use App\Models\Planting;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;

class HarvestController extends Controller
{
    /**
     * Display a listing of harvests
     */
    public function index(Request $request): JsonResponse
    {
        $user = $request->user();

        $query = Harvest::whereHas('planting.field', function ($q) use ($user) {
            $q->where('user_id', $user->id);
        });

        // Apply date range filters
        if ($request->has('date_from')) {
            $query->whereDate('harvest_date', '>=', $request->date_from);
        }

        if ($request->has('date_to')) {
            $query->whereDate('harvest_date', '<=', $request->date_to);
        }

        $harvests = $query->with(['planting.field', 'planting.riceVariety', 'postHarvestProcesses'])
            ->orderBy('harvest_date', 'desc')
            ->get();

        return response()->json([
            'harvests' => $harvests
        ]);
    }

    /**
     * Store a newly created harvest
     */
    public function store(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'planting_id' => 'required|exists:plantings,id',
            'harvest_date' => 'required|date',
            'quantity' => 'required|numeric|min:0',
            'unit' => 'required|string|in:bushels',
            'price_per_unit' => 'nullable|numeric|min:0',
            'total_value' => 'nullable|numeric|min:0',
            'notes' => 'nullable|string',
            'harvester_share' => 'nullable|numeric|min:0',
            'harvester_share_percentage' => 'nullable|numeric|min:0|max:100',
        ]);

        $validator->after(function ($validator) use ($request) {
            $quantity = (float) $request->input('quantity', 0);
            $harvesterShare = (float) $request->input('harvester_share', 0);

            if ($harvesterShare > $quantity) {
                $validator->errors()->add('harvester_share', 'The harvester share cannot exceed the harvest quantity.');
            }
        });

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }

        // Check if user owns the planting's field
        $planting = Planting::with(['field', 'riceVariety'])->findOrFail($request->planting_id);
        $user = $request->user();

        if ($planting->field->user_id !== $user->id) {
            return response()->json([
                'message' => 'Unauthorized access to planting'
            ], 403);
        }

        DB::beginTransaction();
        try {
            $harvest = Harvest::create([
                'planting_id' => $request->planting_id,
                'harvest_date' => $request->harvest_date,
                'quantity' => $request->quantity,
                'yield' => $request->quantity, // Also set yield for backward compatibility
                'unit' => $request->unit,
                'quality' => 'average', // Default quality for backward compatibility
                'price_per_unit' => $request->price_per_unit,
                'total_value' => $request->total_value,
                'notes' => $request->notes,
                'harvester_share' => $request->harvester_share,
                'harvester_share_percentage' => $request->harvester_share_percentage,
            ]);

            // Reload harvest with planting relationship for inventory
            $harvest->load('planting.riceVariety', 'planting.field');

            $this->syncHarvestInventory($harvest, $user, 0, null);
            $this->syncHarvesterShareExpense($harvest, $user);

            // Update planting status to harvested
            $planting->update([
                'status' => Planting::STATUS_HARVESTED,
                'actual_harvest_date' => $request->harvest_date,
            ]);

            DB::commit();

            return response()->json([
                'message' => 'Harvest created successfully',
                'harvest' => $harvest->load(['planting.field', 'planting.riceVariety'])
            ], 201);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    /**
     * Display the specified harvest
     */
    public function show(Request $request, Harvest $harvest): JsonResponse
    {
        $user = $request->user();

        if ($harvest->planting->field->user_id !== $user->id) {
            return response()->json([
                'message' => 'Unauthorized access'
            ], 403);
        }

        $harvest->load(['planting.field', 'planting.riceVariety']);

        return response()->json([
            'harvest' => $harvest
        ]);
    }

    /**
     * Update the specified harvest
     */
    public function update(Request $request, Harvest $harvest): JsonResponse
    {
        $user = $request->user();

        if ($harvest->planting->field->user_id !== $user->id) {
            return response()->json([
                'message' => 'Unauthorized access'
            ], 403);
        }

        $validator = Validator::make($request->all(), [
            'harvest_date' => 'sometimes|required|date',
            'quantity' => 'sometimes|required|numeric|min:0',
            'unit' => 'sometimes|required|string|in:bushels',
            'price_per_unit' => 'nullable|numeric|min:0',
            'total_value' => 'nullable|numeric|min:0',
            'notes' => 'nullable|string',
            'harvester_share' => 'nullable|numeric|min:0',
            'harvester_share_percentage' => 'nullable|numeric|min:0|max:100',
        ]);

        $validator->after(function ($validator) use ($request, $harvest) {
            $quantity = (float) $request->input('quantity', $harvest->quantity);
            $harvesterShare = (float) $request->input('harvester_share', $harvest->harvester_share ?? 0);

            if ($harvesterShare > $quantity) {
                $validator->errors()->add('harvester_share', 'The harvester share cannot exceed the harvest quantity.');
            }
        });

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }

        $updateData = $request->only([
            'harvest_date',
            'quantity',
            'unit',
            'price_per_unit',
            'total_value',
            'notes',
            'harvester_share',
            'harvester_share_percentage',
        ]);

        // Map quantity to yield if provided for backward compatibility
        if (isset($updateData['quantity'])) {
            $updateData['yield'] = $updateData['quantity'];
        }

        DB::beginTransaction();
        try {
            $originalQuantity = (float) $harvest->quantity;
            $originalInventoryItem = $this->resolveHarvestInventoryItem($harvest, $user, false);

            $harvest->update($updateData);

            if (isset($updateData['harvest_date'])) {
                $harvest->planting->update([
                    'actual_harvest_date' => $updateData['harvest_date'],
                ]);
            }

            $harvest->load('planting.riceVariety', 'planting.field');
            $this->syncHarvestInventory($harvest, $user, $originalQuantity, $originalInventoryItem);
            $this->syncHarvesterShareExpense($harvest, $user);

            DB::commit();
        } catch (\RuntimeException $e) {
            DB::rollBack();

            return response()->json([
                'message' => $e->getMessage(),
            ], 422);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }

        return response()->json([
            'message' => 'Harvest updated successfully',
            'harvest' => $harvest->load(['planting.field', 'planting.riceVariety', 'postHarvestProcesses'])
        ]);
    }

    /**
     * Remove the specified harvest
     */
    public function destroy(Request $request, Harvest $harvest): JsonResponse
    {
        $user = $request->user();

        if ($harvest->planting->field->user_id !== $user->id) {
            return response()->json([
                'message' => 'Unauthorized access'
            ], 403);
        }

        if ($harvest->postHarvestProcesses()->exists()) {
            return response()->json([
                'message' => 'This harvest already has post-harvest processing records. Delete those records before deleting the harvest.'
            ], 422);
        }

        DB::beginTransaction();
        try {
            $inventoryItem = $this->resolveHarvestInventoryItem($harvest, $user, false);
            $quantity = (float) $harvest->quantity;

            if ($inventoryItem && $quantity > 0) {
                if (!$inventoryItem->removeStock($quantity)) {
                    DB::rollBack();

                    return response()->json([
                        'message' => 'Unable to delete harvest because the related produce inventory no longer has enough stock to reverse this harvest.'
                    ], 422);
                }

                $this->recordHarvestInventoryTransaction($inventoryItem, $harvest, $user, 'out', $quantity, 'Harvest deleted: reversed produce stock');
            }

            $this->deleteHarvesterShareExpense($harvest);
            $harvest->delete();

            DB::commit();
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }

        return response()->json([
            'message' => 'Harvest deleted successfully'
        ]);
    }

    /**
     * Keep produce inventory aligned with the harvest's current gross quantity.
     */
    private function syncHarvestInventory(Harvest $harvest, $user, float $previousQuantity, ?InventoryItem $previousInventoryItem): void
    {
        $inventoryItem = $this->resolveHarvestInventoryItem($harvest, $user, true);
        $currentQuantity = (float) $harvest->quantity;

        // Update unit price before writing movement history so the transaction uses the latest harvest price.
        if ($harvest->price_per_unit && $harvest->price_per_unit != $inventoryItem->unit_price) {
            $inventoryItem->unit_price = $harvest->price_per_unit;
            $inventoryItem->save();
        }

        if ($previousInventoryItem && $previousInventoryItem->id !== $inventoryItem->id && $previousQuantity > 0) {
            if (!$previousInventoryItem->removeStock($previousQuantity)) {
                throw new \RuntimeException('Unable to reverse previous harvest inventory stock.');
            }

            $this->recordHarvestInventoryTransaction($previousInventoryItem, $harvest, $user, 'out', $previousQuantity, 'Harvest updated: reversed previous produce stock');
            $previousQuantity = 0;
        }

        $delta = $currentQuantity - $previousQuantity;

        if ($delta > 0) {
            $inventoryItem->addStock($delta);
            $this->recordHarvestInventoryTransaction($inventoryItem, $harvest, $user, 'in', $delta, 'Harvest recorded: added produce stock');
        } elseif ($delta < 0) {
            $quantityToRemove = abs($delta);
            if (!$inventoryItem->removeStock($quantityToRemove)) {
                throw new \RuntimeException('Unable to reduce harvest inventory because the related produce stock is insufficient.');
            }

            $this->recordHarvestInventoryTransaction($inventoryItem, $harvest, $user, 'out', $quantityToRemove, 'Harvest updated: reduced produce stock');
        }
    }

    private function resolveHarvestInventoryItem(Harvest $harvest, $user, bool $create): ?InventoryItem
    {
        $planting = $harvest->planting;
        if (!$planting) {
            return null;
        }

        if (!$planting->relationLoaded('riceVariety') || !$planting->relationLoaded('field')) {
            $planting->load(['riceVariety', 'field']);
        }

        $productName = $planting->riceVariety?->name ?? $planting->crop_type ?? 'Rice';
        $attributes = [
            'user_id' => $user->id,
            'name' => $productName,
            'category' => InventoryItem::CATEGORY_PRODUCE,
            'unit' => $harvest->unit,
        ];

        if (!$create) {
            return InventoryItem::where($attributes)->first();
        }

        return InventoryItem::firstOrCreate($attributes, [
            'description' => 'Harvested from ' . ($planting->field?->name ?? 'field'),
            'current_stock' => 0,
            'minimum_stock' => 0,
            'unit_price' => $harvest->price_per_unit ?? 0,
            'notes' => 'Auto-created from harvest',
        ]);
    }

    private function recordHarvestInventoryTransaction(InventoryItem $inventoryItem, Harvest $harvest, $user, string $type, float $quantity, string $notes): void
    {
        InventoryTransaction::create([
            'inventory_item_id' => $inventoryItem->id,
            'user_id' => $user->id,
            'transaction_type' => $type,
            'quantity' => $quantity,
            'unit_cost' => $inventoryItem->unit_price ?? 0,
            'total_cost' => $quantity * (float) ($inventoryItem->unit_price ?? 0),
            'reference_type' => 'Harvest',
            'reference_id' => $harvest->id,
            'notes' => $notes,
            'transaction_date' => now(),
        ]);
    }

    private function syncHarvesterShareExpense(Harvest $harvest, $user): void
    {
        $this->deleteHarvesterShareExpense($harvest);

        // --- Record harvester share as a proper peso expense ---
        $harvesterShare = (float) ($harvest->harvester_share ?? 0);
        if ($harvesterShare <= 0) {
            return;
        }

        $pricePerUnit = (float) ($harvest->price_per_unit ?? 0);
        $shareValue = $harvesterShare * $pricePerUnit;

        $shareDescription = "Harvester crop share: {$harvesterShare} {$harvest->unit}";
        if ($pricePerUnit > 0) {
            $shareDescription .= " at ₱" . number_format($pricePerUnit, 2) . "/{$harvest->unit}";
        }

        $notes = "Auto-generated from harvest #{$harvest->id}. "
            . "Gross: {$harvest->quantity} {$harvest->unit}, "
            . "Share: {$harvesterShare} {$harvest->unit} "
            . "({$harvest->harvester_share_percentage}%).";

        if ($pricePerUnit <= 0) {
            $notes .= " WARNING: price_per_unit was not set — expense amount is ₱0. "
                . "Update the harvest price to correct this.";
        }

        Expense::create([
            'description' => $shareDescription,
            'amount' => $shareValue,
            'category' => Expense::CATEGORY_LABOR,
            'date' => $harvest->harvest_date ?? now(),
            'user_id' => $user->id,
            'payment_method' => 'crop_share',
            'notes' => $notes,
            'related_entity_type' => Expense::ENTITY_TYPE_HARVEST,
            'related_entity_id' => $harvest->id,
            'planting_id' => $harvest->planting_id,
        ]);
    }

    private function deleteHarvesterShareExpense(Harvest $harvest): void
    {
        Expense::where('related_entity_type', Expense::ENTITY_TYPE_HARVEST)
            ->where('related_entity_id', $harvest->id)
            ->where('payment_method', 'crop_share')
            ->delete();
    }
}
