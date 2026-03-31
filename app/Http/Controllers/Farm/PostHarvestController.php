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

        if ($harvest->planting->field->user_id !== $user->id) {
            return response()->json(['message' => 'Unauthorized access'], 403);
        }

        $processes = $harvest->postHarvestProcesses()
            ->with(['task', 'parentProcess'])
            ->orderBy('process_date')
            ->get();

        $summary = $this->service->getProcessingSummary($harvest);

        return response()->json([
            'processes' => $processes,
            'summary' => $summary,
            'harvest' => $harvest->load('planting.riceVariety', 'planting.field'),
        ]);
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
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors(),
            ], 422);
        }

        $harvest = Harvest::with('planting.field')->findOrFail($request->harvest_id);
        $user = $request->user();

        if ($harvest->planting->field->user_id !== $user->id) {
            return response()->json(['message' => 'Unauthorized access to harvest'], 403);
        }

        $process = $this->service->createProcess($request->all(), $harvest, $user->id);

        $process->load(['harvest.planting.riceVariety', 'task', 'parentProcess']);

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
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors(),
            ], 422);
        }

        $process->update($request->only([
            'process_type', 'process_date', 'input_quantity', 'input_unit',
            'status', 'cost', 'cost_type', 'cost_per_unit',
            'service_provider', 'process_data', 'notes', 'task_id',
        ]));

        return response()->json([
            'message' => 'Process updated successfully',
            'process' => $process->fresh()->load(['task', 'parentProcess']),
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
            'output_quantity' => 'required|numeric|min:0',
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

        $completedProcess = $this->service->completeProcess($process, $request->all());

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
            return response()->json(['message' => 'Only pending processes can be deleted'], 422);
        }

        $process->delete();

        return response()->json([
            'message' => 'Process deleted successfully',
        ]);
    }
}
