<?php

namespace App\Http\Controllers\Farm;

use App\Http\Controllers\Controller;
use App\Models\Expense;
use App\Models\Field;
use App\Models\InventoryTransaction;
use App\Models\Planting;
use App\Models\RiceVariety;
use App\Models\SeedPlanting;
use App\Notifications\PlantingFailedNotification;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class PlantingController extends Controller
{
    /**
     * Display a listing of plantings
     */
    public function index(Request $request): JsonResponse
    {
        $user = $request->user();

        $query = Planting::whereHas('field', function ($q) use ($user) {
            $q->where('user_id', $user->id);
        });

        // Filter out harvested/failed plantings by default unless status is specified
        if ($request->has('status')) {
            $query->where('status', $request->status);
        } else {
            $query->whereNotIn('status', [Planting::STATUS_HARVESTED, Planting::STATUS_FAILED]);
        }

        $plantings = $query->with(['field', 'riceVariety'])->get();

        return response()->json([
            'plantings' => $plantings
        ]);
    }

    /**
     * Store a newly created planting
     */
    public function store(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'field_id' => 'required|exists:fields,id',
            'inventory_item_id' => 'nullable|exists:inventory_items,id',
            'seed_planting_id' => 'nullable|exists:seed_plantings,id',
            'rice_variety_id' => 'required|exists:rice_varieties,id',
            'crop_name' => 'nullable|string|max:255',
            'crop_type' => 'nullable|string|max:255',
            'planting_date' => 'required|date',
            'expected_harvest_date' => 'nullable|date|after_or_equal:planting_date',
            'growth_duration' => 'nullable|integer|min:30|max:240',
            'planting_method' => 'nullable|string|in:direct_seeding,transplanting,broadcasting,broadcast',
            'seed_rate' => 'nullable|numeric|min:0',
            'seed_unit' => 'nullable|string|max:50',
            'seed_quantity' => 'nullable|numeric|min:0',
            'area_planted' => 'nullable|numeric|min:0',
            'season' => 'nullable|string|in:wet,dry',
            'status' => 'nullable|string|in:planned,planted,growing,ready,harvested,failed',
            'notes' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }

        // Check if user owns the field
        $field = Field::findOrFail($request->field_id);
        $user = $request->user();

        if ($field->user_id !== $user->id) {
            return response()->json([
                'message' => 'Unauthorized access to field'
            ], 403);
        }

        $plantingDate = Carbon::parse($request->planting_date);

        $expectedHarvest = $request->expected_harvest_date
            ? Carbon::parse($request->expected_harvest_date)
            : (clone $plantingDate)->addDays((int) $request->input('growth_duration', 120));

        $varietyId = $request->input('rice_variety_id');
        if (!$varietyId && $request->filled('variety')) {
            $variety = RiceVariety::where('name', $request->input('variety'))->first();
            if ($variety) {
                $varietyId = $variety->id;
            }
        }
        if (!$varietyId) {
            return response()->json([
                'message' => 'No rice varieties available. Please add rice varieties first.'
            ], 422);
        }

        $areaPlanted = $request->input('area_planted');
        if (!$areaPlanted || $areaPlanted <= 0) {
            $areaPlanted = $field->size ?? 1;
        }

        $seedRate = $request->input('seed_rate') ?? $request->input('seed_quantity');

        // Validate inventory stock if item is selected
        $inventoryItem = null;
        if ($request->filled('inventory_item_id')) {
            $inventoryItem = \App\Models\InventoryItem::find($request->inventory_item_id);
            if ($inventoryItem && $seedRate > 0) {
                if ($inventoryItem->current_stock < $seedRate) {
                    return response()->json([
                        'message' => "Insufficient stock. Available: {$inventoryItem->current_stock} {$inventoryItem->unit}"
                    ], 422);
                }
            }
        }

        // Validate nursery seedling if selected as source
        if ($request->filled('seed_planting_id')) {
            $seedPlanting = SeedPlanting::find($request->seed_planting_id);

            if (!$seedPlanting) {
                return response()->json(['message' => 'Selected seedling batch not found.'], 422);
            }

            if ($seedPlanting->user_id !== $user->id) {
                return response()->json(['message' => 'Unauthorized access to seedling batch.'], 403);
            }

            if ($seedPlanting->status !== SeedPlanting::STATUS_READY) {
                return response()->json([
                    'message' => 'The selected seedling batch is not ready for transplanting. Current status: ' . $seedPlanting->status
                ], 422);
            }

            if ($seedRate > 0 && $seedPlanting->quantity < $seedRate) {
                return response()->json([
                    'message' => "Insufficient seedlings. Available: {$seedPlanting->quantity} {$seedPlanting->unit}"
                ], 422);
            }
        }

        $seedPlantingId = $request->input('seed_planting_id');

        $season = $request->input('season') ?? $this->determineSeasonFromDate($plantingDate);

        $status = $request->input('status', Planting::STATUS_PLANTED);
        if ($plantingDate->isFuture() && $status === Planting::STATUS_PLANTED) {
            $status = Planting::STATUS_PLANNED;
        }

        $planting = Planting::create([
            'field_id' => $request->field_id,
            'seed_planting_id' => $seedPlantingId,
            'rice_variety_id' => $varietyId,
            'crop_type' => $request->input('crop_name') ?? $request->input('crop_type') ?? 'Rice',
            'planting_date' => $plantingDate,
            'expected_harvest_date' => $expectedHarvest,
            'status' => $status,
            'planting_method' => $this->normalizePlantingMethod($request->input('planting_method')),
            'seed_rate' => $seedRate,
            'seed_unit' => $request->seed_unit,
            'area_planted' => $areaPlanted,
            'season' => $season,
            'notes' => $request->notes,
        ]);

        if ($seedPlantingId) {
            $seedPlanting = \App\Models\SeedPlanting::find($seedPlantingId);
            if ($seedPlanting) {
                $seedPlanting->update(['status' => \App\Models\SeedPlanting::STATUS_TRANSPLANTED]);
            }
        }

        // Deduct from inventory and log transaction
        if ($inventoryItem && $seedRate > 0) {
            $inventoryItem->removeStock($seedRate);

            \App\Models\InventoryTransaction::create([
                'inventory_item_id' => $inventoryItem->id,
                'user_id' => $user->id,
                'transaction_type' => 'out',
                'quantity' => $seedRate,
                'unit_cost' => $inventoryItem->unit_price,
                'total_cost' => $seedRate * ($inventoryItem->unit_price ?? 0),
                'reference_type' => 'Planting',
                'reference_id' => $planting->id,
                'notes' => 'Used for direct planting: ' . ($request->notes ?? ''),
                'transaction_date' => now(),
            ]);
        }

        // Initialize planting stages for lifecycle tracking
        $planting->initializePlantingStages();

        // Start the appropriate stage based on planting method
        if ($status !== Planting::STATUS_PLANNED) {
            $plantingMethod = $this->normalizePlantingMethod($request->input('planting_method'));

            if ($plantingMethod === 'transplanting') {
                $planting->startTransplantingStage();
            } else {
                // Direct seeding / Broadcasting starts at Stage 1
                $firstStage = $planting->plantingStages()
                    ->join('rice_growth_stages', 'planting_stages.rice_growth_stage_id', '=', 'rice_growth_stages.id')
                    ->orderBy('rice_growth_stages.order_sequence')
                    ->select('planting_stages.*')
                    ->first();

                // Cast to model if it's returning as stdClass due to join
                if ($firstStage && !($firstStage instanceof \App\Models\PlantingStage)) {
                    $firstStage = \App\Models\PlantingStage::find($firstStage->id);
                }

                if ($firstStage) {
                    if ($firstStage->status !== 'in_progress') {
                        $firstStage->markAsStarted();
                    }
                }
            }
        }

        return response()->json([
            'message' => 'Planting created successfully',
            'planting' => $planting->load(['field', 'riceVariety', 'plantingStages.riceGrowthStage'])
        ], 201);
    }

    /**
     * Display the specified planting
     */
    public function show(Request $request, Planting $planting): JsonResponse
    {
        $user = $request->user();

        if ($planting->field->user_id !== $user->id) {
            return response()->json([
                'message' => 'Unauthorized access'
            ], 403);
        }

        $planting->load([
            'field',
            'riceVariety',
            'plantingStages.riceGrowthStage',
            'harvests',
            'tasks',
        ]);

        return response()->json([
            'planting' => $planting
        ]);
    }

    /**
     * Update the specified planting
     */
    public function update(Request $request, Planting $planting): JsonResponse
    {
        $user = $request->user();

        if ($planting->field->user_id !== $user->id) {
            return response()->json([
                'message' => 'Unauthorized access'
            ], 403);
        }

        $validator = Validator::make($request->all(), [
            'field_id'          => 'sometimes|required|exists:fields,id',
            'rice_variety_id'   => 'nullable|exists:rice_varieties,id',
            'crop_type'         => 'sometimes|required|string|max:255',
            'planting_date'     => 'sometimes|required|date',
            'expected_harvest_date' => 'nullable|date|after_or_equal:planting_date',
            'growth_duration'   => 'nullable|integer|min:30|max:240',
            'planting_method'   => 'nullable|string|in:direct_seeding,transplanting,broadcasting',
            'seed_rate'         => 'nullable|numeric|min:0',
            'seed_unit'         => 'nullable|string|max:50',
            'area_planted'      => 'nullable|numeric|min:0',
            'season'            => 'nullable|string|in:wet,dry',
            'status'            => 'nullable|string|in:planned,planted,growing,ready,harvested,failed',
            'notes'             => 'nullable|string',
            // Failure fields
            'failure_reason'    => 'nullable|string|max:500',
            'failure_category'  => 'nullable|string|in:' . implode(',', array_keys(Planting::FAILURE_CATEGORIES)),
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }

        $data = [];

        if ($request->has('field_id')) {
            $field = Field::findOrFail($request->field_id);

            if ($field->user_id !== $user->id) {
                return response()->json([
                    'message' => 'Unauthorized access to field'
                ], 403);
            }

            $data['field_id'] = $field->id;
        }

        if ($request->has('rice_variety_id')) {
            $varietyId = $request->input('rice_variety_id');

            if (!$varietyId) {
                $varietyId = RiceVariety::value('id');
            }

            if (!$varietyId) {
                return response()->json([
                    'message' => 'No rice variety available. Please add varieties first.'
                ], 422);
            }

            $data['rice_variety_id'] = $varietyId;
        }

        if ($request->has('crop_type')) {
            $data['crop_type'] = $request->crop_type;
        }

        if ($request->has('planting_method')) {
            $data['planting_method'] = $this->normalizePlantingMethod($request->planting_method);
        }

        if ($request->has('seed_rate')) {
            $data['seed_rate'] = $request->seed_rate;
        }

        if ($request->has('seed_unit')) {
            $data['seed_unit'] = $request->seed_unit;
        }

        if ($request->has('area_planted')) {
            $data['area_planted'] = $request->area_planted;
        }

        if ($request->has('status')) {
            $data['status'] = $request->status;
        }

        if ($request->has('notes')) {
            $data['notes'] = $request->notes;
        }

        if ($request->has('failure_reason')) {
            $data['failure_reason'] = $request->failure_reason;
        }

        if ($request->has('failure_category')) {
            $data['failure_category'] = $request->failure_category;
        }

        $plantingDate = $planting->planting_date;
        if ($request->has('planting_date')) {
            $plantingDate = Carbon::parse($request->planting_date);
            $data['planting_date'] = $plantingDate;
            if (!$request->has('season')) {
                $data['season'] = $this->determineSeasonFromDate($plantingDate);
            }
        }

        if ($request->has('season')) {
            $data['season'] = $request->season;
        }

        if ($request->has('expected_harvest_date')) {
            $data['expected_harvest_date'] = Carbon::parse($request->expected_harvest_date);
        } elseif ($request->filled('growth_duration')) {
            $growthDuration = (int) $request->input('growth_duration');
            if (!$plantingDate) {
                $plantingDate = $planting->planting_date;
            }
            if ($plantingDate) {
                $expectedHarvest = (clone $plantingDate)->addDays($growthDuration);
                $data['expected_harvest_date'] = $expectedHarvest;
            }
        }

        if (!isset($data['status']) && isset($data['planting_date'])) {
            if ($data['planting_date'] instanceof Carbon && $data['planting_date']->isFuture() && $planting->status === Planting::STATUS_PLANTED) {
                $data['status'] = Planting::STATUS_PLANNED;
            } elseif ($data['planting_date'] instanceof Carbon && $data['planting_date']->isPast() && $planting->status === Planting::STATUS_PLANNED) {
                $data['status'] = Planting::STATUS_PLANTED;
            }
        }

        // --- Failure transition side-effects ---
        $isNewFailure = $planting->status !== Planting::STATUS_FAILED
            && ($data['status'] ?? null) === Planting::STATUS_FAILED;

        if (!empty($data)) {
            $planting->fill($data);
            $planting->save();
        }

        if ($isNewFailure) {
            $cropLossAmount = 0;

            DB::transaction(function () use ($planting, $user, $request, &$cropLossAmount) {
                // 1) Cancel all pending / in-progress tasks
                $planting->tasks()
                    ->whereIn('status', ['pending', 'in_progress'])
                    ->update(['status' => 'cancelled']);

                // 2) Cancel pending stages; mark in-progress as skipped
                $planting->plantingStages()
                    ->where('status', 'pending')
                    ->update(['status' => 'skipped']);
                $planting->plantingStages()
                    ->where('status', 'in_progress')
                    ->update(['status' => 'skipped']);

                // 3) Revert field to fallow only if no other active plantings on it
                $otherActivePlantings = Planting::where('field_id', $planting->field_id)
                    ->where('id', '!=', $planting->id)
                    ->active()
                    ->count();

                if ($otherActivePlantings === 0) {
                    $planting->field->update(['status' => 'fallow']);
                }

                // 4) Auto-create crop_loss expense from original seed inventory transaction
                $seedTransaction = InventoryTransaction::where('reference_type', 'Planting')
                    ->where('reference_id', $planting->id)
                    ->where('transaction_type', 'out')
                    ->first();

                if ($seedTransaction && $seedTransaction->total_cost > 0) {
                    $cropLossAmount = (float) $seedTransaction->total_cost;

                    // Avoid duplicate expense if farmer un-fails and re-fails
                    $alreadyHasCropLoss = Expense::where('planting_id', $planting->id)
                        ->where('category', 'crop_loss')
                        ->exists();

                    if (!$alreadyHasCropLoss) {
                        Expense::create([
                            'user_id'     => $user->id,
                            'planting_id' => $planting->id,
                            'date'        => now(),
                            'category'    => 'crop_loss',
                            'description' => 'Crop failure write-off – seed cost (Planting #' . $planting->id . ')',
                            'amount'      => $cropLossAmount,
                            'notes'       => 'Auto-generated on planting failure. Reason: '
                                . ($planting->failure_reason ?? 'Not specified'),
                        ]);
                    }
                }
            });

            // Dispatch notification (outside transaction — non-critical)
            try {
                $user->notify(new PlantingFailedNotification($planting->fresh(), $cropLossAmount));
            } catch (\Throwable $e) {
                \Illuminate\Support\Facades\Log::warning('PlantingFailedNotification dispatch failed: ' . $e->getMessage());
            }
        }

        return response()->json([
            'message' => 'Planting updated successfully',
            'planting' => $planting->load(['field', 'riceVariety'])
        ]);
    }

    /**
     * Remove the specified planting
     */
    public function destroy(Request $request, Planting $planting): JsonResponse
    {
        $user = $request->user();

        if ($planting->field->user_id !== $user->id) {
            return response()->json([
                'message' => 'Unauthorized access'
            ], 403);
        }

        $planting->delete();

        return response()->json([
            'message' => 'Planting deleted successfully'
        ]);
    }

    private function normalizePlantingMethod(?string $method): string
    {
        return match ($method) {
            'broadcast' => 'broadcasting',
            'direct_seeding', 'transplanting', 'broadcasting' => $method,
            default => 'transplanting',
        };
    }

    private function determineSeasonFromDate(?Carbon $date): string
    {
        if (!$date) {
            return 'wet';
        }

        $month = (int) $date->format('n');

        // Philippines seasons according to PAGASA:
        // Rainy season: June (6) to November (11)
        // Dry season: December (12) to May (5)
        return ($month >= 6 && $month <= 11) ? 'wet' : 'dry';
    }
}