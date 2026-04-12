<?php

namespace App\Http\Controllers\Labor;

use App\Http\Controllers\Controller;
use App\Models\Planting;
use App\Models\Task;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class TaskController extends Controller
{
    /**
     * Display a listing of tasks
     */
    public function index(Request $request): JsonResponse
    {
        $user = $request->user();

        $query = Task::query()->with(['planting.field', 'field', 'laborer', 'laborerGroup']);

        // Get tasks owned by the user via planting->field OR direct field_id
        $query->where(function ($q) use ($user) {
            $q->whereHas('planting.field', function ($fieldQuery) use ($user) {
                $fieldQuery->where('user_id', $user->id);
            })->orWhereHas('field', function ($fieldQuery) use ($user) {
                $fieldQuery->where('user_id', $user->id);
            });
        });

        if ($request->filled('status')) {
            $query->where('status', $request->status);
        }

        if ($request->filled('task_type')) {
            $query->where('task_type', $request->task_type);
        }

        if ($request->filled('planting_id')) {
            $query->where('planting_id', $request->planting_id);
        }

        if ($request->filled('date_from')) {
            $query->whereDate('due_date', '>=', Carbon::parse($request->date_from));
        }

        if ($request->filled('date_to')) {
            $query->whereDate('due_date', '<=', Carbon::parse($request->date_to));
        }

        $tasks = $query->orderBy('due_date', 'asc')->get();

        return response()->json([
            'tasks' => $tasks,
        ]);
    }

    /**
     * Store a newly created task
     */
    public function store(Request $request): JsonResponse
    {
        // Accept the payload sent by the frontend (task_type, planting_id, assigned_to, laborer_group_id)
        $validator = Validator::make($request->all(), [
            'field_id' => ['required_without:planting_id', 'nullable', 'exists:fields,id'],
            'planting_id' => ['required_without:field_id', 'nullable', 'exists:plantings,id'],
            'task_type' => ['required', 'string', Rule::in($this->taskTypeOptions())],
            'due_date' => ['required', 'date'],
            'description' => ['required', 'string'],
            'status' => ['nullable', 'string', Rule::in($this->statusOptions())],
            'assigned_to' => ['nullable', 'exists:laborers,id'],
            'laborer_group_id' => ['nullable', 'exists:laborer_groups,id'],
            'payment_type' => ['nullable', 'string', Rule::in([Task::PAYMENT_TYPE_WAGE, Task::PAYMENT_TYPE_SHARE, Task::PAYMENT_TYPE_PIECE_RATE])],
            'revenue_share_percentage' => ['nullable', 'numeric', 'min:0', 'max:100'],
            'wage_amount' => ['nullable', 'numeric', 'min:0'],
            'unit' => ['nullable', 'string'],
            'quantity' => ['nullable', 'numeric', 'min:0'],
            'unit_price' => ['nullable', 'numeric', 'min:0'],
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors(),
            ], 422);
        }

        $user = $request->user();
        $plantingId = $request->planting_id;
        $fieldId = $request->field_id;

        if ($plantingId) {
            $planting = Planting::with('field')->findOrFail($plantingId);
            if (!$this->ownsPlanting($user->id, $planting)) {
                return response()->json(['message' => 'Unauthorized access to planting'], 403);
            }
            $fieldId = $planting->field_id;
        } else {
            $field = \App\Models\Field::findOrFail($fieldId);
            if ((int)$field->user_id !== (int)$user->id) {
                return response()->json(['message' => 'Unauthorized access to field'], 403);
            }
        }

        // Create task using the fields present in the DB/migration and frontend payload
        $task = Task::create([
            'planting_id' => $plantingId,
            'field_id' => $fieldId,
            'task_type' => $request->task_type,
            'due_date' => Carbon::parse($request->due_date),
            'description' => $request->description,
            'status' => $request->input('status', Task::STATUS_PENDING),
            'assigned_to' => $request->assigned_to,
            'laborer_group_id' => $request->laborer_group_id,
            'payment_type' => $request->input('payment_type', Task::PAYMENT_TYPE_WAGE),
            'revenue_share_percentage' => $request->revenue_share_percentage,
            'wage_amount' => $request->payment_type === Task::PAYMENT_TYPE_PIECE_RATE
                ? ($request->quantity * $request->unit_price)
                : $request->wage_amount,
            'unit' => $request->unit,
            'quantity' => $request->quantity,
            'unit_price' => $request->unit_price,
        ]);

        $task->load(['planting.field', 'field', 'laborer', 'laborerGroup']);

        // If due_date is already reached at creation, generate expenses now.
        $this->ensureDueDateCompletion($task, $user);

        return response()->json([
            'message' => 'Task created successfully',
            'task' => $task,
        ], 201);
    }

    /**
     * Display the specified task
     */
    public function show(Request $request, Task $task): JsonResponse
    {
        $user = $request->user();

        if (!$this->ownsTask($user->id, $task)) {
            return response()->json([
                'message' => 'Unauthorized access',
            ], 403);
        }

        $task->load(['planting.field', 'field', 'laborer', 'laborerGroup']);

        return response()->json([
            'task' => $task,
        ]);
    }

    /**
     * Update the specified task
     */
    public function update(Request $request, Task $task): JsonResponse
    {
        $user = $request->user();

        if (!$this->ownsTask($user->id, $task)) {
            return response()->json([
                'message' => 'Unauthorized access',
            ], 403);
        }

        $requestData = $request->all();

        $validator = Validator::make($requestData, [
            'planting_id' => ['nullable', 'exists:plantings,id'],
            'field_id' => ['nullable', 'exists:fields,id'],
            'task_type' => ['sometimes', 'required', 'string', Rule::in($this->taskTypeOptions())],
            'due_date' => ['sometimes', 'required', 'date'],
            'description' => ['sometimes', 'nullable', 'string'],
            'status' => ['sometimes', 'required', 'string', Rule::in($this->statusOptions())],
            'assigned_to' => ['nullable', 'exists:laborers,id'],
            'laborer_group_id' => ['nullable', 'exists:laborer_groups,id'],
            'payment_type' => ['nullable', 'string', Rule::in([Task::PAYMENT_TYPE_WAGE, Task::PAYMENT_TYPE_SHARE, Task::PAYMENT_TYPE_PIECE_RATE])],
            'revenue_share_percentage' => ['nullable', 'numeric', 'min:0', 'max:100'],
            'wage_amount' => ['nullable', 'numeric', 'min:0'],
            'unit' => ['nullable', 'string'],
            'quantity' => ['nullable', 'numeric', 'min:0'],
            'unit_price' => ['nullable', 'numeric', 'min:0'],
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors(),
            ], 422);
        }

        $data = [];

        if ($request->has('planting_id')) {
            if ($request->planting_id) {
                $planting = Planting::with('field')->findOrFail($request->planting_id);
                if (!$this->ownsPlanting($user->id, $planting)) {
                    return response()->json(['message' => 'Unauthorized access to planting'], 403);
                }
                $data['planting_id'] = $planting->id;
                $data['field_id'] = $planting->field_id;
            } else {
                $data['planting_id'] = null;
            }
        }

        if ($request->has('field_id')) {
            if ($request->field_id) {
                $field = \App\Models\Field::findOrFail($request->field_id);
                if ((int)$field->user_id !== (int)$user->id) {
                    return response()->json(['message' => 'Unauthorized access to field'], 403);
                }
                $data['field_id'] = $field->id;
            }
        }

        if ($request->has('task_type')) {
            $data['task_type'] = $request->task_type;
        }

        if ($request->has('due_date')) {
            $data['due_date'] = Carbon::parse($request->due_date);
        }

        if ($request->has('description')) {
            $data['description'] = $request->description;
        }

        if ($request->has('status')) {
            $data['status'] = $request->status;
        }

        if (array_key_exists('assigned_to', $requestData)) {
            $data['assigned_to'] = $requestData['assigned_to'];
        }

        if (array_key_exists('laborer_group_id', $requestData)) {
            $data['laborer_group_id'] = $requestData['laborer_group_id'];
        }

        if ($request->has('payment_type')) {
            $data['payment_type'] = $request->payment_type;
        }

        if ($request->has('revenue_share_percentage')) {
            $data['revenue_share_percentage'] = $request->revenue_share_percentage;
        }

        if ($request->has('wage_amount')) {
            $data['wage_amount'] = $request->wage_amount;
        }

        if ($request->has('unit'))
            $data['unit'] = $request->unit;
        if ($request->has('quantity'))
            $data['quantity'] = $request->quantity;
        if ($request->has('unit_price'))
            $data['unit_price'] = $request->unit_price;

        // Recalculate wage_amount if piece rate fields are updated
        if (
            ($data['payment_type'] ?? $task->payment_type) === Task::PAYMENT_TYPE_PIECE_RATE ||
            (isset($data['payment_type']) && $data['payment_type'] === Task::PAYMENT_TYPE_PIECE_RATE)
        ) {
            $qty = $data['quantity'] ?? $task->quantity ?? 0;
            $price = $data['unit_price'] ?? $task->unit_price ?? 0;
            $data['wage_amount'] = $qty * $price;
        }

        if (!empty($data)) {
            $task->fill($data);
            $task->save();

            // Check if status was changed to completed
            if ($task->wasChanged('status') && $task->status === Task::STATUS_COMPLETED) {
                // Create labor expenses
                $laborExpenses = $this->createLaborExpensesForTask($task, $user, null, Carbon::now());
                $this->syncPostHarvestProcessStatus($task);
            } else {
                // If due date has passed, complete task and create expenses
                $laborExpenses = $this->ensureDueDateCompletion($task, $user);
                $this->syncPostHarvestProcessStatus($task); // sync in case status changed for any reason
            }
        }

        $task->load(['planting.field', 'field', 'laborer', 'laborerGroup']);

        $response = [
            'message' => 'Task updated successfully',
            'task' => $task,
        ];

        // Add warning if task was completed but no labor expenses were created
        if (isset($laborExpenses) && empty($laborExpenses)) {
            $response['warning'] = 'No labor expense was recorded because no laborer is assigned to this task.';
        }

        return response()->json($response);
    }

    /**
     * Remove the specified task
     */
    public function destroy(Request $request, Task $task): JsonResponse
    {
        $user = $request->user();

        if (!$this->ownsTask($user->id, $task)) {
            return response()->json([
                'message' => 'Unauthorized access',
            ], 403);
        }

        $task->delete();

        return response()->json([
            'message' => 'Task deleted successfully',
        ]);
    }

    /**
     * Mark a task as completed
     */
    public function markCompleted(Request $request, Task $task): JsonResponse
    {
        $user = $request->user();

        if (!$this->ownsTask($user->id, $task)) {
            return response()->json([
                'message' => 'Unauthorized access',
            ], 403);
        }

        // Optional: hours worked for the task (defaults to 8 for per_day, 1 for per_task)
        $hoursWorked = $request->input('hours_worked');

        $task->update([
            'status' => Task::STATUS_COMPLETED,
        ]);

        $task->load(['planting.field', 'field', 'laborer', 'laborerGroup.laborers']);

        // Sync to post harvest process
        $this->syncPostHarvestProcessStatus($task);

        // Create labor wage and expense records for assigned laborers
        // Use actual completion time for per-day wage calculation
        $laborExpenses = $this->createLaborExpensesForTask($task, $user, $hoursWorked, Carbon::now());

        return response()->json([
            'message' => 'Task marked as completed',
            'task' => $task,
            'labor_expenses' => $laborExpenses,
        ]);
    }

    /**
     * Create labor wage and expense records for a completed task
     */
    private function createLaborExpensesForTask(Task $task, $user, $hoursWorked = null, $effectiveDate = null): array
    {
        $laborers = collect();
        $expenses = [];

        // Prevent duplicate wage/expense when already generated for this task.
        if ($task->laborWages()->exists()) {
            return $expenses;
        }

        // Get laborers: either individual or from group
        if ($task->laborer) {
            $laborers->push($task->laborer);
        } elseif ($task->laborerGroup && $task->laborerGroup->laborers) {
            $laborers = $task->laborerGroup->laborers;
        }

        if ($laborers->isEmpty()) {
            return $expenses;
        }

        foreach ($laborers as $laborer) {
            // Skip share-based tasks entirely — crop-share compensation is calculated
            // at harvest time by HarvestController when the actual quantity and price
            // are known. Creating an expense here would produce an inaccurate amount.
            if ($task->payment_type === Task::PAYMENT_TYPE_SHARE) {
                continue;
            }

            // Calculate wage based on rate_type and effective period.
            $rate = (float) ($laborer->rate ?? 0);
            $rateType = strtolower($laborer->rate_type ?? 'per_day');
            if ($rateType === 'daily') {
                $rateType = 'per_day';
            }

            // Determine date range used for wage calc.
            $startDate = $task->created_at ? Carbon::parse($task->created_at)->startOfDay() : Carbon::now()->startOfDay();
            $endDate = $effectiveDate ? Carbon::parse($effectiveDate)->startOfDay() : Carbon::now()->startOfDay();
            $days = max(1, $startDate->diffInDays($endDate) + 1);

            if ($rateType === 'per_task') {
                $hours = $hoursWorked ?? 1;
                $wageAmount = $rate;
            } else {
                // per_day (default)
                $hours = $hoursWorked ?? ($days * 8);
                $wageAmount = $rate * $days;
            }

            // Override with task specific wage amount if available
            if ($task->wage_amount > 0) {
                $wageAmount = (float) $task->wage_amount;
            }

            if ($wageAmount <= 0) {
                continue;
            }

            // Distribute piece rate total among group members
            if ($task->payment_type === Task::PAYMENT_TYPE_PIECE_RATE && $laborers->count() > 1) {
                $wageAmount = $wageAmount / $laborers->count();
            }

            // Create LaborWage record
            $laborWage = \App\Models\LaborWage::create([
                'laborer_id' => $laborer->id,
                'task_id' => $task->id,
                'hours_worked' => $hours,
                'wage_amount' => $wageAmount,
                'date' => now(),
                'user_id' => $user->id,
            ]);

            // Create Expense record linked to the task
            $expense = \App\Models\Expense::create([
                'description' => "Labor: {$laborer->name} - {$task->task_type} task",
                'amount' => $wageAmount,
                'category' => \App\Models\Expense::CATEGORY_LABOR,
                'date' => now(),
                'user_id' => $user->id,
                'payment_method' => $task->payment_type === Task::PAYMENT_TYPE_SHARE ? 'revenue_share' : 'cash',
                'notes' => "Auto-generated from task completion. Task ID: {$task->id}, Laborer: {$laborer->name}",
                'related_entity_type' => \App\Models\Expense::ENTITY_TYPE_TASK,
                'related_entity_id' => $task->id,
                'planting_id' => $task->planting_id, // Link to planting for reports
            ]);

            $expenses[] = [
                'laborer_id' => $laborer->id,
                'laborer_name' => $laborer->name,
                'labor_wage_id' => $laborWage->id,
                'expense_id' => $expense->id,
                'amount' => $wageAmount,
            ];
        }

        return $expenses;
    }

    /**
     * Sync task status to associated PostHarvestProcess
     */
    private function syncPostHarvestProcessStatus(Task $task)
    {
        $process = \App\Models\PostHarvestProcess::where('task_id', $task->id)->first();
        if ($process) {
            // If task is in progress, mark process in progress
            if ($task->status === Task::STATUS_IN_PROGRESS && $process->status === \App\Models\PostHarvestProcess::STATUS_PENDING) {
                $process->update(['status' => \App\Models\PostHarvestProcess::STATUS_IN_PROGRESS]);
            }
            // If task is completed, we don't automatically complete the process because it requires weight/yield data!
            // But we can ensure it's at least IN_PROGRESS if not already.
            elseif ($task->status === Task::STATUS_COMPLETED && $process->status === \App\Models\PostHarvestProcess::STATUS_PENDING) {
                $process->update(['status' => \App\Models\PostHarvestProcess::STATUS_IN_PROGRESS]);
            }
        }
    }

    /**
     * Ensure overdue task is marked completed and labor cost is recorded.
     */
    private function ensureDueDateCompletion(Task $task, $user): array
    {
        if ($task->status !== Task::STATUS_COMPLETED && $task->due_date && $task->due_date->lte(now())) {
            $task->update(['status' => Task::STATUS_COMPLETED]);
            return $this->createLaborExpensesForTask($task, $user, null, $task->due_date);
        }

        return [];
    }

    /**
     * @return array<string>
     */
    private function taskTypeOptions(): array
    {
        return [
            Task::TYPE_LAND_PREPARATION,
            Task::TYPE_SEEDLING_MANAGEMENT,
            Task::TYPE_TRANSPLANTING,
            Task::TYPE_WATERING,
            Task::TYPE_WATER_MANAGEMENT,
            Task::TYPE_FERTILIZING,
            Task::TYPE_WEEDING,
            Task::TYPE_PEST_CONTROL,
            Task::TYPE_PESTICIDE_APPLICATION,
            Task::TYPE_HARVESTING,
            Task::TYPE_MAINTENANCE,
            Task::TYPE_THRESHING,
            Task::TYPE_DRYING,
            Task::TYPE_MILLING,
        ];
    }

    /**
     * @return array<string>
     */
    private function statusOptions(): array
    {
        return [
            Task::STATUS_PENDING,
            Task::STATUS_IN_PROGRESS,
            Task::STATUS_COMPLETED,
            Task::STATUS_CANCELLED,
        ];
    }

    private function ownsPlanting(int $userId, Planting $planting): bool
    {
        $field = $planting->field;

        return $field && (int) $field->user_id === $userId;
    }

    private function ownsTask(int $userId, Task $task): bool
    {
        if ($task->planting_id) {
            $task->loadMissing('planting.field');
            if (!$task->planting) return false;
            return (int) $task->planting->field->user_id === $userId;
        }

        if ($task->field_id) {
            $task->loadMissing('field');
            if (!$task->field) return false;
            return (int) $task->field->user_id === $userId;
        }

        return false;
    }
}