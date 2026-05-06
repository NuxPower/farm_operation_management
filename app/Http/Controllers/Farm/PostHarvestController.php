<?php

namespace App\Http\Controllers\Farm;

use App\Http\Controllers\Controller;
use App\Models\Harvest;
use App\Models\PostHarvestProcess;
use App\Services\PostHarvestService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class PostHarvestController extends Controller
{
    private PostHarvestService $service;

    public function __construct(PostHarvestService $service)
    {
        $this->service = $service;
    }

    /**
     * List all post-harvest processes for a harvest
     */
    public function index(Request $request, Harvest $harvest): JsonResponse
    {
        $user = $request->user();

        if (!$harvest->planting || !$harvest->planting->field || $harvest->planting->field->user_id !== $user->id) {
            return response()->json(['message' => 'Unauthorized access'], 403);
        }

        $processes = $harvest->postHarvestProcesses()
            ->with(['task.laborer', 'task.laborerGroup', 'parentProcess'])
            ->orderBy('id')
            ->get();

        $summary = $this->service->getProcessingSummary($harvest);

        // Determine pipeline status for the frontend
        $completedTypes = $processes
            ->where('status', 'completed')
            ->pluck('process_type')
            ->toArray();

        $nextStep = null;
        foreach (PostHarvestProcess::PIPELINE_ORDER as $step) {
            if (!in_array($step, $completedTypes)) {
                // Check if there's an in-progress/pending one already
                $existing = $processes->where('process_type', $step)
                    ->whereNotIn('status', ['cancelled'])
                    ->first();
                $nextStep = $step;
                break;
            }
        }

        $riceVarietyName = $harvest->planting?->riceVariety?->name
            ?? $harvest->planting?->crop_type
            ?? 'Rice';

        return response()->json([
            'processes' => $processes,
            'summary' => $summary,
            'harvest' => $harvest->load('planting.riceVariety', 'planting.field'),
            'pipeline_status' => [
                'completed_types' => $completedTypes,
                'next_step' => $nextStep,
                'is_complete' => count($completedTypes) === count(PostHarvestProcess::PIPELINE_ORDER),
            ],
            'rice_variety_name' => $riceVarietyName,
        ]);
    }

    /**
     * Get post-harvest efficiency analytics for a harvest.
     */
    public function efficiency(Request $request, Harvest $harvest): JsonResponse
    {
        $user = $request->user();

        if (!$harvest->planting || !$harvest->planting->field || $harvest->planting->field->user_id !== $user->id) {
            return response()->json(['message' => 'Unauthorized access'], 403);
        }

        $efficiency = $this->service->getPostHarvestEfficiency($harvest);

        return response()->json([ 'efficiency' => $efficiency ]);
    }

    /**
     * Create a new post-harvest process
     */
    public function store(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'harvest_id' => 'required|exists:harvests,id',
            'process_type' => ['required', 'string', Rule::in(PostHarvestProcess::PROCESS_TYPES)],
            'process_date' => 'required|date',
            'input_quantity' => 'nullable|numeric|min:0.01',
            'input_unit' => 'nullable|string',
            'cost' => 'nullable|numeric|min:0',
            'cost_type' => ['nullable', 'string', Rule::in(PostHarvestProcess::COST_TYPES)],
            'cost_per_unit' => 'nullable|numeric|min:0',
            'service_provider' => 'nullable|string|max:255',
            'parent_process_id' => 'nullable|exists:post_harvest_processes,id',
            'process_data' => 'nullable|array',
            'notes' => 'nullable|string',
            'task_id' => 'nullable|exists:tasks,id',
            'assign_laborers' => 'nullable|boolean',
            'assigned_to' => 'nullable|exists:laborers,id',
            'laborer_group_id' => 'nullable|exists:laborer_groups,id',
            'payment_type' => ['nullable', 'string', Rule::in(['wage', 'share', 'piece_rate'])],
            'wage_amount' => 'nullable|numeric|min:0',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors(),
            ], 422);
        }

        $harvest = Harvest::with('planting.field')->findOrFail($request->harvest_id);
        $user = $request->user();

        if (!$harvest->planting || !$harvest->planting->field || $harvest->planting->field->user_id !== $user->id) {
            return response()->json(['message' => 'Unauthorized access to harvest'], 403);
        }

        try {
            $process = $this->service->createProcess($request->all(), $harvest, $user->id);
        } catch (\InvalidArgumentException $e) {
            return response()->json(['message' => $e->getMessage()], 422);
        }

        $process->load(['harvest.planting.riceVariety', 'task.laborer', 'task.laborerGroup', 'parentProcess']);

        return response()->json([
            'message' => 'Post-harvest process created successfully',
            'process' => $process,
        ], 201);
    }

    /**
     * Show a single process
     */
    public function show(Request $request, PostHarvestProcess $process): JsonResponse
    {
        $user = $request->user();

        if ((int) $process->user_id !== $user->id) {
            return response()->json(['message' => 'Unauthorized access'], 403);
        }

        $process->load(['harvest.planting.riceVariety', 'harvest.planting.field', 'task', 'parentProcess', 'childProcess']);

        return response()->json([
            'process' => $process,
        ]);
    }

    /**
     * Update a pending/in-progress process
     */
    public function update(Request $request, PostHarvestProcess $process): JsonResponse
    {
        $user = $request->user();

        if ((int) $process->user_id !== $user->id) {
            return response()->json(['message' => 'Unauthorized access'], 403);
        }

        if ($process->status === PostHarvestProcess::STATUS_COMPLETED) {
            return response()->json(['message' => 'Cannot edit a completed process'], 422);
        }

        $validator = Validator::make($request->all(), [
            'process_type' => ['sometimes', 'string', Rule::in(PostHarvestProcess::PROCESS_TYPES)],
            'process_date' => 'sometimes|date',
            'input_quantity' => 'sometimes|numeric|min:0.01',
            'input_unit' => 'sometimes|string',
            'status' => ['sometimes', 'string', Rule::in([PostHarvestProcess::STATUS_PENDING, PostHarvestProcess::STATUS_IN_PROGRESS, PostHarvestProcess::STATUS_CANCELLED])],
            'cost' => 'sometimes|numeric|min:0',
            'cost_type' => ['sometimes', 'string', Rule::in(PostHarvestProcess::COST_TYPES)],
            'cost_per_unit' => 'nullable|numeric|min:0',
            'service_provider' => 'nullable|string|max:255',
            'process_data' => 'nullable|array',
            'notes' => 'nullable|string',
            'task_id' => 'nullable|exists:tasks,id',
            'assign_laborers' => 'nullable|boolean',
            'assigned_to' => 'nullable|exists:laborers,id',
            'laborer_group_id' => 'nullable|exists:laborer_groups,id',
            'payment_type' => ['nullable', 'string', Rule::in(['wage', 'share', 'piece_rate'])],
            'wage_amount' => 'nullable|numeric|min:0',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors(),
            ], 422);
        }

        try {
            $freshProcess = $this->service->updateProcess($process, $request->all());
        } catch (\InvalidArgumentException $e) {
            return response()->json(['message' => $e->getMessage()], 422);
        }

        return response()->json([
            'message' => 'Process updated successfully',
            'process' => $freshProcess->load(['task.laborer', 'task.laborerGroup', 'parentProcess']),
        ]);
    }

    /**
     * Complete a post-harvest process with output data
     */
    public function complete(Request $request, PostHarvestProcess $process): JsonResponse
    {
        $user = $request->user();

        if ((int) $process->user_id !== $user->id) {
            return response()->json(['message' => 'Unauthorized access'], 403);
        }

        if (!$process->canComplete()) {
            return response()->json(['message' => 'This process cannot be completed in its current state.'], 422);
        }

        $validator = Validator::make($request->all(), [
            'output_quantity' => ['required', 'numeric', 'min:0', 'max:' . $process->input_quantity],
            'output_unit' => 'nullable|string',
            'completed_date' => 'nullable|date',
            'cost' => 'nullable|numeric|min:0',
            'cost_per_unit' => 'nullable|numeric|min:0',
            'process_data' => 'nullable|array',
            'notes' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors(),
            ], 422);
        }

        try {
            $completedProcess = $this->service->completeProcess($process, $request->all());
        } catch (\InvalidArgumentException $e) {
            return response()->json(['message' => $e->getMessage()], 422);
        }

        $completedProcess->load(['harvest.planting.riceVariety', 'harvest.planting.field', 'task']);

        return response()->json([
            'message' => 'Process completed successfully',
            'process' => $completedProcess,
            'summary' => $this->service->getProcessingSummary($completedProcess->harvest),
        ]);
    }

    /**
     * Delete a pending process
     */
    public function destroy(Request $request, PostHarvestProcess $process): JsonResponse
    {
        $user = $request->user();

        if ((int) $process->user_id !== $user->id) {
            return response()->json(['message' => 'Unauthorized access'], 403);
        }

        if (!$process->canDelete()) {
            return response()->json(['message' => 'Only pending or cancelled processes can be deleted'], 422);
        }

        $harvest = $process->harvest;
        $process->delete();

        return response()->json([
            'message' => 'Process deleted successfully',
            'summary' => $harvest ? $this->service->getProcessingSummary($harvest) : null,
        ]);
    }
}
