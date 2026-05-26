<?php

namespace App\Http\Controllers;

use App\Models\SeedPlanting;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class SeedPlantingController extends Controller
{
    public function index()
    {
        $seedPlantings = SeedPlanting::where('user_id', Auth::id())
            ->with(['riceVariety', 'inventoryItem'])
            ->latest('planting_date')
            ->get();

        return response()->json($seedPlantings);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'rice_variety_id' => 'required|exists:rice_varieties,id',
            'inventory_item_id' => 'nullable|exists:inventory_items,id',
            'planting_date' => 'required|date',
            'expected_transplant_date' => 'nullable|date|after:planting_date',
            'quantity' => 'required|numeric|min:0',
            'unit' => 'required|string',
            'notes' => 'nullable|string',
            'batch_id' => 'nullable|string|max:50',
        ]);

        $seedPlanting = DB::transaction(function () use ($validated) {
            $inventoryItem = null;

            if (!empty($validated['inventory_item_id'])) {
                $inventoryItem = \App\Models\InventoryItem::find($validated['inventory_item_id']);

                if ($inventoryItem && !$inventoryItem->removeStock($validated['quantity'])) {
                    throw ValidationException::withMessages([
                        'quantity' => "Insufficient stock. Available: {$inventoryItem->current_stock} {$inventoryItem->unit}",
                    ]);
                }
            }

            $seedPlanting = SeedPlanting::create([
                'user_id' => Auth::id(),
                'rice_variety_id' => $validated['rice_variety_id'],
                'inventory_item_id' => $validated['inventory_item_id'] ?? null,
                'planting_date' => $validated['planting_date'],
                'expected_transplant_date' => $validated['expected_transplant_date'] ?? null,
                'quantity' => $validated['quantity'],
                'unit' => $validated['unit'],
                'notes' => $validated['notes'] ?? null,
                'batch_id' => $validated['batch_id'] ?? null,
                'status' => 'sown'
            ]);

            if ($inventoryItem) {
                \App\Models\InventoryTransaction::create([
                    'inventory_item_id' => $inventoryItem->id,
                    'user_id' => Auth::id(),
                    'transaction_type' => 'out',
                    'quantity' => $validated['quantity'],
                    'unit_cost' => $inventoryItem->unit_price,
                    'total_cost' => $validated['quantity'] * ($inventoryItem->unit_price ?? 0),
                    'reference_type' => 'SeedPlanting',
                    'reference_id' => $seedPlanting->id,
                    'notes' => 'Used for nursery batch',
                    'transaction_date' => now(),
                ]);
            }

            return $seedPlanting;
        });

        return response()->json($seedPlanting->load(['riceVariety', 'inventoryItem']), 201);
    }

    public function show(SeedPlanting $seedPlanting)
    {
        if ($seedPlanting->user_id !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        return response()->json($seedPlanting->load('riceVariety', 'inventoryItem', 'plantings'));
    }

    public function update(Request $request, SeedPlanting $seedPlanting)
    {
        if ($seedPlanting->user_id !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $validated = $request->validate([
            'rice_variety_id' => 'exists:rice_varieties,id',
            'planting_date' => 'date',
            'expected_transplant_date' => 'nullable|date|after:planting_date',
            'quantity' => 'numeric|min:0',
            'unit' => 'string',
            'status' => 'in:sown,germinating,ready,transplanted,failed',
            'notes' => 'nullable|string',
            'batch_id' => 'nullable|string|max:50',
        ]);

        DB::transaction(function () use ($seedPlanting, $validated) {
            if (array_key_exists('quantity', $validated) && $seedPlanting->inventory_item_id) {
                $oldQuantity = (float) $seedPlanting->quantity;
                $newQuantity = (float) $validated['quantity'];
                $delta = $newQuantity - $oldQuantity;

                if (abs($delta) > 0.00001) {
                    $inventoryItem = $seedPlanting->inventoryItem()->lockForUpdate()->first();

                    if ($inventoryItem) {
                        if ($delta > 0 && !$inventoryItem->removeStock($delta)) {
                            throw ValidationException::withMessages([
                                'quantity' => "Insufficient stock. Available: {$inventoryItem->current_stock} {$inventoryItem->unit}",
                            ]);
                        }

                        if ($delta < 0) {
                            $inventoryItem->addStock(abs($delta));
                        }

                        \App\Models\InventoryTransaction::create([
                            'inventory_item_id' => $inventoryItem->id,
                            'user_id' => Auth::id(),
                            'transaction_type' => $delta > 0 ? 'out' : 'in',
                            'quantity' => abs($delta),
                            'unit_cost' => $inventoryItem->unit_price,
                            'total_cost' => abs($delta) * ($inventoryItem->unit_price ?? 0),
                            'reference_type' => 'SeedPlanting',
                            'reference_id' => $seedPlanting->id,
                            'notes' => $delta > 0
                                ? 'Additional seed used for nursery batch adjustment'
                                : 'Returned from nursery batch quantity adjustment',
                            'transaction_date' => now(),
                        ]);
                    }
                }
            }

            $seedPlanting->update($validated);
        });

        return response()->json($seedPlanting->fresh()->load(['riceVariety', 'inventoryItem']));
    }

    public function destroy(SeedPlanting $seedPlanting)
    {
        if ($seedPlanting->user_id !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $seedPlanting->delete();

        return response()->json(['message' => 'Seed planting deleted successfully']);
    }

    /**
     * Get ready seed plantings for transplanting
     */
    public function getReady()
    {
        $ready = SeedPlanting::where('user_id', Auth::id())
            ->where('status', 'ready')
            ->with('riceVariety', 'inventoryItem')
            ->get();

        return response()->json($ready);
    }
}
