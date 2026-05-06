<?php

namespace App\Services;

use App\Models\Expense;
use App\Models\Harvest;
use App\Models\InventoryItem;
use App\Models\InventoryTransaction;
use App\Models\LaborWage;
use App\Models\PostHarvestProcess;
use App\Models\Task;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class PostHarvestService
{
    private function resolveTaskType(string $processType): string
    {
        return match ($processType) {
            PostHarvestProcess::TYPE_THRESHING => Task::TYPE_THRESHING,
            PostHarvestProcess::TYPE_DRYING => Task::TYPE_DRYING,
            PostHarvestProcess::TYPE_MILLING => Task::TYPE_MILLING,
            default => Task::TYPE_MAINTENANCE,
        };
    }

    /**
     * Create a new post-harvest process for a harvest.
     *
     * The pipeline is flexible: processes can be created in any order.
     * input_quantity defaults to the previous step's output or the harvest quantity.
     */
    public function createProcess(array $data, Harvest $harvest, int $userId): PostHarvestProcess
    {
        $processType = $data['process_type'];

        // ── Pipeline Validation (fixed order: threshing → drying → milling) ──
        $this->validatePipelineStep($harvest, $processType);

        // ── Auto-resolve input from the previous pipeline step ──
        $predecessor = PostHarvestProcess::getRequiredPredecessor($processType);

        if ($predecessor) {
            // Find the completed predecessor process
            $parentProcess = $harvest->postHarvestProcesses()
                ->where('process_type', $predecessor)
                ->where('status', PostHarvestProcess::STATUS_COMPLETED)
                ->first();

            if ($parentProcess) {
                // If input_quantity is provided, it must not exceed parent's actual output
                if (isset($data['input_quantity']) && $data['input_quantity'] > $parentProcess->output_quantity) {
                    throw new \InvalidArgumentException('Input quantity cannot exceed the output quantity of the previous process (' . $parentProcess->output_quantity . ').');
                }
                $data['input_quantity'] = $data['input_quantity'] ?? $parentProcess->output_quantity;
                $data['input_unit'] = $parentProcess->output_unit;
                $data['parent_process_id'] = $parentProcess->id;
            }
        } else {
            // First step (threshing) — use harvest quantity
            if (isset($data['input_quantity']) && $data['input_quantity'] > $harvest->quantity) {
                throw new \InvalidArgumentException('Input quantity cannot exceed the available harvest quantity (' . $harvest->quantity . ').');
            }
            $data['input_quantity'] = $data['input_quantity'] ?? $harvest->quantity;
            $data['input_unit'] = $harvest->unit;
        }

        // ── Auto-set correct units based on process type ──
        $data['input_unit'] = PostHarvestProcess::getInputUnitLabel($processType);

        // Calculate cost for service_per_unit
        if (($data['cost_type'] ?? 'self') === PostHarvestProcess::COST_TYPE_SERVICE_PER_UNIT) {
            $costPerUnit = (float) ($data['cost_per_unit'] ?? 0);
            $data['cost'] = $costPerUnit * (float) $data['input_quantity'];
        }

        $process = \Illuminate\Support\Facades\DB::transaction(function () use ($data, $harvest, $userId, $processType) {
            // Create the process first
            $process = PostHarvestProcess::create([
                'harvest_id' => $harvest->id,
                'planting_id' => $harvest->planting_id,
                'user_id' => $userId,
                'parent_process_id' => $data['parent_process_id'] ?? null,
                'process_type' => $processType,
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

            // Handle optional laborer assignment → Create Task
            if (!empty($data['assign_laborers'])) {
                $processData = $data;

                // Task types map exactly from process types in this case
                $taskType = $this->resolveTaskType($processType);

                $paymentType = $data['payment_type'] ?? Task::PAYMENT_TYPE_WAGE;

                $task = Task::create([
                    'planting_id' => $harvest->planting_id,
                    'field_id' => $harvest->planting->field_id,
                    'task_type' => $taskType,
                    'due_date' => $data['process_date'],
                    'description' => "Post-harvest processing: " . ucfirst($processType) . " for harvest #{$harvest->id}",
                    'status' => \App\Models\Task::STATUS_PENDING,
                    'quantity' => $data['input_quantity'],
                    'unit' => $data['input_unit'],
                    'payment_type' => $paymentType,
                    'assigned_to' => $data['assigned_to'] ?? null,
                    'laborer_group_id' => $data['laborer_group_id'] ?? null,
                    'wage_amount' => $data['wage_amount'] ?? null,
                ]);

                $process->update(['task_id' => $task->id]);
            }

            $this->syncProcessingExpense($process, (float) ($data['cost'] ?? 0));

            return $process;
        });

        return $process;
    }

    public function updateProcess(PostHarvestProcess $process, array $data): PostHarvestProcess
    {
        return DB::transaction(function () use ($process, $data) {
            $process->update([
                'process_type' => $data['process_type'] ?? $process->process_type,
                'process_date' => $data['process_date'] ?? $process->process_date,
                'input_quantity' => $data['input_quantity'] ?? $process->input_quantity,
                'input_unit' => $data['input_unit'] ?? $process->input_unit,
                'status' => $data['status'] ?? $process->status,
                'cost' => $data['cost'] ?? $process->cost,
                'cost_type' => $data['cost_type'] ?? $process->cost_type,
                'cost_per_unit' => $data['cost_per_unit'] ?? $process->cost_per_unit,
                'service_provider' => $data['service_provider'] ?? $process->service_provider,
                'process_data' => $data['process_data'] ?? $process->process_data,
                'notes' => $data['notes'] ?? $process->notes,
            ]);

            if (array_key_exists('assign_laborers', $data)) {
                $assignLaborers = (bool) $data['assign_laborers'];
                $task = $process->task;

                if ($assignLaborers) {
                    $taskPayload = [
                        'planting_id' => $process->planting_id,
                        'field_id' => $process->harvest?->planting?->field_id,
                        'task_type' => $this->resolveTaskType((string) $process->process_type),
                        'due_date' => $process->process_date,
                        'description' => "Post-harvest processing: " . ucfirst((string) $process->process_type) . " for harvest #{$process->harvest_id}",
                        'quantity' => $process->input_quantity,
                        'unit' => $process->input_unit,
                        'payment_type' => $data['payment_type'] ?? ($task?->payment_type ?? Task::PAYMENT_TYPE_WAGE),
                        'assigned_to' => $data['assigned_to'] ?? null,
                        'laborer_group_id' => $data['laborer_group_id'] ?? null,
                        'wage_amount' => $data['wage_amount'] ?? null,
                    ];

                    if ($task) {
                        $task->update($taskPayload);
                    } else {
                        $task = Task::create(array_merge($taskPayload, [
                            'status' => Task::STATUS_PENDING,
                        ]));
                        $process->update(['task_id' => $task->id]);
                    }
                } elseif ($task) {
                    if ($task->status === Task::STATUS_COMPLETED) {
                        throw new \InvalidArgumentException('Cannot remove labor assignment from a completed task.');
                    }

                    $task->delete();
                    $process->update(['task_id' => null]);
                }
            } elseif ($process->task) {
                // Keep linked task synchronized with edited process details.
                $process->task->update([
                    'task_type' => $this->resolveTaskType((string) $process->process_type),
                    'due_date' => $process->process_date,
                    'description' => "Post-harvest processing: " . ucfirst((string) $process->process_type) . " for harvest #{$process->harvest_id}",
                    'quantity' => $process->input_quantity,
                    'unit' => $process->input_unit,
                ]);
            }

            $freshProcess = $process->fresh();
            $this->syncProcessingExpense($freshProcess, (float) ($freshProcess->cost ?? 0));

            return $freshProcess;
        });
    }

    /**
     * Validate that the pipeline step can be created (fixed order: threshing → drying → milling).
     *
     * @throws \InvalidArgumentException
     */
    public function validatePipelineStep(Harvest $harvest, string $processType): void
    {
        $existingProcesses = $harvest->postHarvestProcesses()
            ->whereNotIn('status', [PostHarvestProcess::STATUS_CANCELLED])
            ->get();

        // Check: this process type must not already exist (non-cancelled)
        $alreadyExists = $existingProcesses->where('process_type', $processType)->isNotEmpty();
        if ($alreadyExists) {
            throw new \InvalidArgumentException(
                ucfirst($processType) . ' has already been recorded for this harvest.'
            );
        }

        // Check: predecessor must be completed
        $requiredPredecessor = PostHarvestProcess::getRequiredPredecessor($processType);
        if ($requiredPredecessor) {
            $predecessorCompleted = $existingProcesses
                ->where('process_type', $requiredPredecessor)
                ->where('status', PostHarvestProcess::STATUS_COMPLETED)
                ->isNotEmpty();

            if (!$predecessorCompleted) {
                throw new \InvalidArgumentException(
                    ucfirst($requiredPredecessor) . ' must be completed before ' . $processType . ' can begin.'
                );
            }
        }
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

            if ($outputQty > $inputQty) {
                throw new \InvalidArgumentException('Output quantity (' . $outputQty . ') cannot exceed input quantity (' . $inputQty . ').');
            }

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

            $this->syncProcessingExpense($process, $cost);

            // ── Task Sync ──
            if ($process->task_id && $process->task) {
                $task = $process->task;
                $task->update(['status' => Task::STATUS_COMPLETED]);
                $this->createLaborExpensesForCompletedTask($task, Carbon::now());
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
            $deducted = $sourceItem->removeStock($inputQty);

            if ($deducted) {
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
                Log::warning('Post-harvest: insufficient stock to deduct from source inventory', [
                    'process_id' => $process->id,
                    'item_name' => $sourceItemName,
                    'requested' => $inputQty,
                    'available' => $sourceItem->current_stock,
                ]);
            }
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
        // Milling is the final step — output is just the variety name (the marketable product)
        if ($process->process_type === PostHarvestProcess::TYPE_MILLING) {
            $name = $varietyName;
            if ($harvest->quality_grade) {
                $name .= ' (Grade ' . $harvest->quality_grade . ')';
            }
            return $name;
        }

        $suffix = match ($process->process_type) {
            PostHarvestProcess::TYPE_THRESHING => ' - Palay',
            PostHarvestProcess::TYPE_DRYING => ' - Dried Palay',
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

    public function syncProcessingExpense(PostHarvestProcess $process, float $cost): void
    {
        $existingExpense = Expense::where('related_entity_type', Expense::ENTITY_TYPE_POST_HARVEST_PROCESS)
            ->where('related_entity_id', $process->id)
            ->first();

        if ($cost <= 0) {
            if ($existingExpense) {
                $existingExpense->delete();
            }
            return;
        }

        if ($existingExpense) {
            $description = ucfirst($process->process_type) . ' processing';
            if ($process->service_provider) {
                $description .= " by {$process->service_provider}";
            }

            $existingExpense->update([
                'description' => $description,
                'amount' => $cost,
                'date' => $process->completed_date ?? $process->process_date ?? now(),
                'payment_method' => $process->cost_type === PostHarvestProcess::COST_TYPE_SELF ? 'self' : 'cash',
                'notes' => "Auto-generated from post-harvest process #{$process->id}. "
                    . "Input: {$process->input_quantity} {$process->input_unit}, "
                    . "Output: {$process->output_quantity} {$process->output_unit}. "
                    . "Loss: {$process->weight_loss_percentage}%.",
            ]);
            return;
        }

        $this->createProcessingExpense($process, $cost);
    }

    /**
     * Create labor wage + expense records when post-harvest completion closes an assigned task.
     * Mirrors TaskController behavior so labor costs appear in expenses/reports.
     */
    private function createLaborExpensesForCompletedTask(Task $task, Carbon $effectiveDate): void
    {
        // Prevent duplicate generation if this task already has wages recorded.
        if ($task->laborWages()->exists()) {
            return;
        }

        $task->loadMissing(['laborer', 'laborerGroup.laborers']);

        $laborers = collect();
        if ($task->laborer) {
            $laborers->push($task->laborer);
        } elseif ($task->laborerGroup && $task->laborerGroup->laborers) {
            $laborers = $task->laborerGroup->laborers;
        }

        if ($laborers->isEmpty()) {
            return;
        }

        foreach ($laborers as $laborer) {
            // Share compensation is handled at harvest-time value realization.
            if ($task->payment_type === Task::PAYMENT_TYPE_SHARE) {
                continue;
            }

            $rate = (float) ($laborer->rate ?? 0);
            $rateType = strtolower($laborer->rate_type ?? 'per_day');
            if ($rateType === 'daily') {
                $rateType = 'per_day';
            }

            $startDate = $task->created_at ? Carbon::parse($task->created_at)->startOfDay() : Carbon::now()->startOfDay();
            $endDate = $effectiveDate->copy()->startOfDay();
            $days = max(1, $startDate->diffInDays($endDate) + 1);

            if ($rateType === 'per_task') {
                $hours = 1;
                $wageAmount = $rate;
            } else {
                $hours = $days * 8;
                $wageAmount = $rate * $days;
            }

            if ((float) $task->wage_amount > 0) {
                $wageAmount = (float) $task->wage_amount;
            }

            if ($task->payment_type === Task::PAYMENT_TYPE_PIECE_RATE && $laborers->count() > 1) {
                $wageAmount = $wageAmount / $laborers->count();
            }

            if ($wageAmount <= 0) {
                continue;
            }

            LaborWage::create([
                'laborer_id' => $laborer->id,
                'task_id' => $task->id,
                'hours_worked' => $hours,
                'wage_amount' => $wageAmount,
                'date' => $effectiveDate,
            ]);

            Expense::create([
                'description' => "Labor: {$laborer->name} - {$task->task_type} task",
                'amount' => $wageAmount,
                'category' => Expense::CATEGORY_LABOR,
                'date' => $effectiveDate,
                'user_id' => $task->field?->user_id ?? $task->planting?->field?->user_id,
                'payment_method' => $task->payment_type === Task::PAYMENT_TYPE_SHARE ? 'revenue_share' : 'cash',
                'notes' => "Auto-generated from post-harvest completion. Task ID: {$task->id}, Laborer: {$laborer->name}",
                'related_entity_type' => Expense::ENTITY_TYPE_TASK,
                'related_entity_id' => $task->id,
                'planting_id' => $task->planting_id,
            ]);
        }
    }

    /**
     * Get an aggregate summary of all post-harvest processing for a harvest.
     */
    public function getProcessingSummary(Harvest $harvest): array
    {
        $processes = $harvest->postHarvestProcesses()
            ->orderBy('id')
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
            'efficiency_breakdown' => $completed->values()->map(fn($p) => [
                'id' => $p->id,
                'type' => $p->process_type,
                'input_quantity' => $p->input_quantity,
                'output_quantity' => $p->output_quantity,
                'weight_loss_percentage' => $p->weight_loss_percentage,
                'cost' => $p->cost,
            ])->all(),
            'processes' => $processes->values()->map(fn($p) => [
                'id' => $p->id,
                'type' => $p->process_type,
                'status' => $p->status,
                'input' => "{$p->input_quantity} {$p->input_unit}",
                'output' => $p->output_quantity ? "{$p->output_quantity} {$p->output_unit}" : null,
                'loss' => $p->weight_loss_percentage,
                'cost' => $p->cost,
                'date' => $p->process_date?->toDateString(),
                'completed' => $p->completed_date?->toDateString(),
            ])->all(),
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

