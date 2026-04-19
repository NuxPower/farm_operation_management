<?php

namespace App\Http\Controllers\Farm;

use App\Http\Controllers\Controller;
use App\Models\Harvest;
use App\Models\Planting;
use App\Models\InventoryItem;
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

            // Add to inventory automatically
            $this->addHarvestToInventory($harvest, $user);

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
        ]);

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

        $harvest->update($updateData);

        return response()->json([
            'message' => 'Harvest updated successfully',
            'harvest' => $harvest->load(['planting.field', 'planting.riceVariety'])
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

        $harvest->delete();

        return response()->json([
            'message' => 'Harvest deleted successfully'
        ]);
    }

    /**
     * Add harvest to inventory automatically
     */
    private function addHarvestToInventory(Harvest $harvest, $user): void
    {
        $planting = $harvest->planting;
        if (!$planting) {
            return;
        }

        // Reload planting with relationships if needed
        if (!$planting->relationLoaded('riceVariety') || !$planting->relationLoaded('field')) {
            $planting->load(['riceVariety', 'field']);
        }

        // Determine the product name from rice variety or crop type
        $productName = $planting->riceVariety?->name ?? $planting->crop_type ?? 'Rice';

        // Find or create inventory item for this product
        $inventoryItem = InventoryItem::firstOrCreate(
            [
                'user_id' => $user->id,
                'name' => $productName,
                'category' => InventoryItem::CATEGORY_PRODUCE,
                'unit' => $harvest->unit,
            ],
            [
                'description' => 'Harvested from ' . ($planting->field?->name ?? 'field'),
                'current_stock' => 0,
                'minimum_stock' => 0,
                'unit_price' => $harvest->price_per_unit ?? 0,
                'notes' => 'Auto-created from harvest',
            ]
        );

        // Add the FULL GROSS quantity to inventory.
        // The harvester's share is tracked as a separate financial expense below,
        // not as a physical inventory deduction.
        if ($harvest->quantity > 0) {
            $inventoryItem->addStock($harvest->quantity);
        }

        // Update unit price if provided and different
        if ($harvest->price_per_unit && $harvest->price_per_unit != $inventoryItem->unit_price) {
            $inventoryItem->unit_price = $harvest->price_per_unit;
            $inventoryItem->save();
        }

        // --- Record harvester share as a proper peso expense ---
        $harvesterShare = (float) ($harvest->harvester_share ?? 0);
        if ($harvesterShare > 0) {
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

            \App\Models\Expense::create([
                'description' => $shareDescription,
                'amount' => $shareValue,
                'category' => \App\Models\Expense::CATEGORY_LABOR,
                'date' => $harvest->harvest_date ?? now(),
                'user_id' => $user->id,
                'payment_method' => 'crop_share',
                'notes' => $notes,
                'related_entity_type' => \App\Models\Expense::ENTITY_TYPE_HARVEST,
                'related_entity_id' => $harvest->id,
                'planting_id' => $harvest->planting_id,
            ]);
        }
    }
}