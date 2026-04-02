<?php

namespace App\Services;

use App\Models\Expense;
use App\Models\Harvest;
use App\Models\InventoryItem;
use App\Models\InventoryTransaction;
use App\Models\PostHarvestProcess;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class PostHarvestService
{
    /**
     * Create a new post-harvest process for a harvest.
     *
     * The pipeline is flexible: processes can be created in any order.
     * input_quantity defaults to the previous step's output or the harvest quantity.
     */
    public function createProcess(array $data, Harvest $harvest, int $userId): PostHarvestProcess
    {
        // If a parent process is specified, pull input from its output
        if (!empty($data['parent_process_id'])) {
            $parent = PostHarvestProcess::where('id', $data['parent_process_id'])
                ->where('harvest_id', $harvest->id)
                ->where('status', PostHarvestProcess::STATUS_COMPLETED)
                ->firstOrFail();

            $data['input_quantity'] = $data['input_quantity'] ?? $parent->output_quantity;
            $data['input_unit'] = $data['input_unit'] ?? $parent->output_unit;
        } else {
            // Use the last completed process output, or fall back to harvest quantity
            $lastProcess = $harvest->postHarvestProcesses()
                ->where('status', PostHarvestProcess::STATUS_COMPLETED)
                ->latest('completed_date')
                ->first();

            if ($lastProcess) {
                $data['input_quantity'] = $data['input_quantity'] ?? $lastProcess->output_quantity;
                $data['input_unit'] = $data['input_unit'] ?? $lastProcess->output_unit;
                $data['parent_process_id'] = $lastProcess->id;
            } else {
                $data['input_quantity'] = $data['input_quantity'] ?? $harvest->quantity;
                $data['input_unit'] = $data['input_unit'] ?? $harvest->unit;
            }
        }

        // Calculate cost for service_per_unit
        if (($data['cost_type'] ?? 'self') === PostHarvestProcess::COST_TYPE_SERVICE_PER_UNIT) {
            $costPerUnit = (float) ($data['cost_per_unit'] ?? 0);
            $data['cost'] = $costPerUnit * (float) $data['input_quantity'];
        }

        return PostHarvestProcess::create([
            'harvest_id' => $harvest->id,
            'planting_id' => $harvest->planting_id,
            'user_id' => $userId,
            'task_id' => $data['task_id'] ?? null,
            'parent_process_id' => $data['parent_process_id'] ?? null,
            'process_type' => $data['process_type'],
            'status' => $data['status'] ?? PostHarvestProcess::STATUS_PENDING,
            'input_quantity' => $data['input_quantity'],
            'input_unit' => $data['input_unit'],
            'process_date' => $data['process_date'],
            'cost' => $data['cost'] ?? 0,
            'cost_type' => $data['cost_type'] ?? PostHarvestProcess::COST_TYPE_SELF,
            'cost_per_unit' => $data['cost_per_unit'] ?? null,
            'service_provider' => $data['service_provider'] ?? null,
            'process_data' => $data['process_data'] ?? null,
            'notes' => $data['notes'] ?? null,
        ]);
    }

    /**
     * Complete a post-harvest process:
     * 1. Calculate weight loss
     * 2. Deduct input from source inventory (tracked)
     * 3. Add output to new/existing inventory (tracked)
     * 4. Record processing expense
     */
    public function completeProcess(PostHarvestProcess $process, array $completionData): PostHarvestProcess
    {
        if (!$process->canComplete()) {
            throw new \InvalidArgumentException('This process cannot be completed in its current state.');
        }

        return DB::transaction(function () use ($process, $completionData) {
            $outputQty = (float) $completionData['output_quantity'];
            $outputUnit = $completionData['output_unit'] ?? $process->input_unit;
            $inputQty = (float) $process->input_quantity;

            // Calculate weight loss percentage
            $weightLoss = $inputQty > 0
                ? round((($inputQty - $outputQty) / $inputQty) * 100, 2)
                : 0;

            // Recalculate cost for per-unit if cost_per_unit provided at completion
            $cost = (float) ($completionData['cost'] ?? $process->cost);
            if (isset($completionData['cost_per_unit']) && $process->cost_type === PostHarvestProcess::COST_TYPE_SERVICE_PER_UNIT) {
                $cost = (float) $completionData['cost_per_unit'] * $inputQty;
            }

            // Update process_data if provided (e.g., moisture readings)
            $processData = $process->process_data ?? [];
            if (isset($completionData['process_data'])) {
                $processData = array_merge($processData, $completionData['process_data']);
            }

            // Update the process record
            $process->update([
                'output_quantity' => $outputQty,
                'output_unit' => $outputUnit,
                'weight_loss_percentage' => $weightLoss,
                'completed_date' => $completionData['completed_date'] ?? now()->toDateString(),
                'status' => PostHarvestProcess::STATUS_COMPLETED,
                'cost' => $cost,
                'cost_per_unit' => $completionData['cost_per_unit'] ?? $process->cost_per_unit,
                'process_data' => $processData,
                'notes' => $completionData['notes'] ?? $process->notes,
            ]);

            // ── Inventory Transformation ──

            $this->transformInventory($process, $inputQty, $outputQty, $outputUnit);

            // ── Expense Recording ──

            if ($cost > 0) {
                $this->createProcessingExpense($process, $cost);
            }

            return $process->fresh();
        });
    }

    /**
     * Deduct inputQty from source inventory item and add outputQty to the new form.
     * Both operations are recorded as InventoryTransactions for full traceability.
     */
    private function transformInventory(PostHarvestProcess $process, float $inputQty, float $outputQty, string $outputUnit): void
    {
        $userId = $process->user_id;
        $harvest = $process->harvest()->with('planting.riceVariety', 'planting.field')->first();

        if (!$harvest) {
            Log::warning('Post-harvest process completion: harvest not found', ['process_id' => $process->id]);
            return;
        }

        $varietyName = $harvest->planting?->riceVariety?->name ?? $harvest->planting?->crop_type ?? 'Rice';

        // ── 1. Deduct from source inventory ──

        $sourceItemName = $this->resolveSourceInventoryName($process, $varietyName, $harvest);
        $sourceItem = InventoryItem::where('user_id', $userId)
            ->where('category', InventoryItem::CATEGORY_PRODUCE)
            ->where('name', $sourceItemName)
            ->first();

        if ($sourceItem && $inputQty > 0) {
            $sourceItem->removeStock($inputQty);

            InventoryTransaction::create([
                'inventory_item_id' => $sourceItem->id,
                'user_id' => $userId,
                'transaction_type' => 'out',
                'quantity' => $inputQty,
                'unit_cost' => $sourceItem->unit_price ?? 0,
                'total_cost' => $inputQty * ($sourceItem->unit_price ?? 0),
                'reference_type' => 'PostHarvestProcess',
                'reference_id' => $process->id,
                'notes' => ucfirst($process->process_type) . " processing — deducted from {$sourceItemName}",
                'transaction_date' => now(),
            ]);
        } else {
            Log::info('Post-harvest: no source inventory item found to deduct from', [
                'process_id' => $process->id,
                'expected_name' => $sourceItemName,
            ]);
        }

        // ── 2. Add to output inventory ──

        $outputItemName = $this->buildOutputInventoryName($process, $varietyName, $harvest);

        $outputItem = InventoryItem::firstOrCreate(
            [
                'user_id' => $userId,
                'name' => $outputItemName,
                'category' => InventoryItem::CATEGORY_PRODUCE,
                'unit' => $outputUnit,
            ],
            [
                'description' => $process->getOutputProductForm() . ' from ' . ($harvest->planting?->field?->name ?? 'field'),
                'current_stock' => 0,
                'minimum_stock' => 0,
                'unit_price' => $harvest->price_per_unit ?? 0,
                'notes' => 'Auto-created from post-harvest processing',
            ]
        );

        if ($outputQty > 0) {
            $outputItem->addStock($outputQty);

            InventoryTransaction::create([
                'inventory_item_id' => $outputItem->id,
                'user_id' => $userId,
                'transaction_type' => 'in',
                'quantity' => $outputQty,
                'unit_cost' => $outputItem->unit_price ?? 0,
                'total_cost' => $outputQty * ($outputItem->unit_price ?? 0),
                'reference_type' => 'PostHarvestProcess',
                'reference_id' => $process->id,
                'notes' => ucfirst($process->process_type) . " output — added to {$outputItemName}",
                'transaction_date' => now(),
            ]);
        }
    }

    /**
     * Build the expected source inventory item name based on
     * what the harvest or prior process would have created.
     */
    private function resolveSourceInventoryName(PostHarvestProcess $process, string $varietyName, Harvest $harvest): string
    {
        // If there's a parent process, source is the parent's output name
        if ($process->parent_process_id) {
            $parent = $process->parentProcess;
            if ($parent) {
                return $this->buildOutputInventoryName($parent, $varietyName, $harvest);
            }
        }

        // Otherwise, source is the original harvest inventory item
        $name = $varietyName;
        if ($harvest->quality_grade) {
            $name .= ' (Grade ' . $harvest->quality_grade . ')';
        }
        return $name;
    }

    /**
     * Build the output inventory item name based on process type.
     */
    private function buildOutputInventoryName(PostHarvestProcess $process, string $varietyName, Harvest $harvest): string
    {
        $suffix = match ($process->process_type) {
            PostHarvestProcess::TYPE_THRESHING => ' - Threshed',
            PostHarvestProcess::TYPE_DRYING => ' - Dried',
            PostHarvestProcess::TYPE_MILLING => ' - Milled',
            default => ' - Processed',
        };

        $name = $varietyName . $suffix;

        if ($harvest->quality_grade) {
            $name .= ' (Grade ' . $harvest->quality_grade . ')';
        }

        return $name;
    }

    /**
     * Create an expense record for the processing cost.
     */
    private function createProcessingExpense(PostHarvestProcess $process, float $cost): void
    {
        $description = ucfirst($process->process_type) . ' processing';
        if ($process->service_provider) {
            $description .= " by {$process->service_provider}";
        }

        Expense::create([
            'description' => $description,
            'amount' => $cost,
            'category' => Expense::CATEGORY_PROCESSING,
            'date' => $process->completed_date ?? now(),
            'user_id' => $process->user_id,
            'payment_method' => $process->cost_type === PostHarvestProcess::COST_TYPE_SELF ? 'self' : 'cash',
            'notes' => "Auto-generated from post-harvest process #{$process->id}. "
                . "Input: {$process->input_quantity} {$process->input_unit}, "
                . "Output: {$process->output_quantity} {$process->output_unit}. "
                . "Loss: {$process->weight_loss_percentage}%.",
            'related_entity_type' => Expense::ENTITY_TYPE_POST_HARVEST_PROCESS,
            'related_entity_id' => $process->id,
            'planting_id' => $process->planting_id,
        ]);
    }

    /**
     * Get an aggregate summary of all post-harvest processing for a harvest.
     */
    public function getProcessingSummary(Harvest $harvest): array
    {
        $processes = $harvest->postHarvestProcesses()
            ->orderBy('process_date')
            ->get();

        $completed = $processes->where('status', PostHarvestProcess::STATUS_COMPLETED);

        $originalQuantity = (float) $harvest->quantity;
        $finalOutputQuantity = (float) ($completed->last()?->output_quantity ?? $originalQuantity);
        $averageWeightLoss = $completed->count() > 0 ? round($completed->avg('weight_loss_percentage'), 2) : 0;
        $totalCost = (float) $completed->sum('cost');
        $costPerOutputUnit = $finalOutputQuantity > 0 ? round($totalCost / $finalOutputQuantity, 2) : 0;

        return [
            'total_processes' => $processes->count(),
            'completed_processes' => $completed->count(),
            'total_cost' => $totalCost,
            'original_quantity' => $originalQuantity,
            'original_unit' => $harvest->unit,
            'final_quantity' => $finalOutputQuantity,
            'final_unit' => $completed->last()?->output_unit ?? $harvest->unit,
            'overall_recovery_rate' => $harvest->quantity > 0 && $completed->count() > 0
                ? round(($finalOutputQuantity / $harvest->quantity) * 100, 2)
                : 100.0,
            'average_weight_loss_percentage' => $averageWeightLoss,
            'cost_per_output_unit' => $costPerOutputUnit,
            'efficiency_breakdown' => $completed->map(fn($p) => [
                'id' => $p->id,
                'type' => $p->process_type,
                'input_quantity' => $p->input_quantity,
                'output_quantity' => $p->output_quantity,
                'weight_loss_percentage' => $p->weight_loss_percentage,
                'cost' => $p->cost,
            ]),
            'processes' => $processes->map(fn($p) => [
                'id' => $p->id,
                'type' => $p->process_type,
                'status' => $p->status,
                'input' => "{$p->input_quantity} {$p->input_unit}",
                'output' => $p->output_quantity ? "{$p->output_quantity} {$p->output_unit}" : null,
                'loss' => $p->weight_loss_percentage,
                'cost' => $p->cost,
                'date' => $p->process_date?->toDateString(),
                'completed' => $p->completed_date?->toDateString(),
            ]),
        ];
    }

    public function getPostHarvestEfficiency(Harvest $harvest): array
    {
        $summary = $this->getProcessingSummary($harvest);

        return [
            'harvest_id' => $harvest->id,
            'planting_id' => $harvest->planting_id,
            'overall_recovery_rate' => $summary['overall_recovery_rate'],
            'average_weight_loss_percentage' => $summary['average_weight_loss_percentage'],
            'cost_per_output_unit' => $summary['cost_per_output_unit'],
            'total_cost' => $summary['total_cost'],
            'final_quantity' => $summary['final_quantity'],
            'efficiency_breakdown' => $summary['efficiency_breakdown'],
        ];
    }
}

