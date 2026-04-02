<?php

namespace App\Http\Controllers\Farm;

use App\Http\Controllers\Controller;
use App\Models\PestIncident;
use App\Models\Expense;
use App\Models\Planting;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Carbon\Carbon;

class PestIncidentController extends Controller
{
    /**
     * List all pest incidents for the user
     */
    public function index(Request $request): JsonResponse
    {
        $query = PestIncident::where('user_id', Auth::id())
            ->with(['planting.field', 'planting.riceVariety'])
            ->orderBy('detected_date', 'desc');

        if ($request->status) {
            $query->where('status', $request->status);
        }

        if ($request->severity) {
            $query->where('severity', $request->severity);
        }

        if ($request->planting_id) {
            $query->where('planting_id', $request->planting_id);
        }

        $incidents = $query->paginate(20);

        // Summary stats
        $stats = [
            'total' => PestIncident::where('user_id', Auth::id())->count(),
            'active' => PestIncident::where('user_id', Auth::id())->active()->count(),
            'treated' => PestIncident::where('user_id', Auth::id())->where('status', 'treated')->count(),
            'resolved' => PestIncident::where('user_id', Auth::id())->where('status', 'resolved')->count(),
        ];

        return response()->json([
            'incidents' => $incidents,
            'stats' => $stats,
        ]);
    }

    /**
     * Create a new pest incident
     */
    public function store(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'planting_id' => 'required|exists:plantings,id',
            'pest_type' => 'required|in:' . implode(',', PestIncident::TYPES),
            'pest_name' => 'required|string|max:100',
            'severity' => 'required|in:' . implode(',', PestIncident::SEVERITIES),
            'affected_area' => 'nullable|numeric|min:0',
            'detected_date' => 'required|date',
            'symptoms' => 'nullable|string|max:1000',
            'treatment_applied' => 'nullable|string|max:500',
            'treatment_date' => 'nullable|date',
            'treatment_cost' => 'nullable|numeric|min:0',
            'notes' => 'nullable|string|max:1000',
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => 'Validation failed', 'errors' => $validator->errors()], 422);
        }

        // Verify planting belongs to user
        $planting = Planting::whereHas('field', function ($q) {
            $q->where('user_id', Auth::id());
        })->find($request->planting_id);

        if (!$planting) {
            return response()->json(['message' => 'Planting not found'], 404);
        }

        if ($validationResponse = $this->validateSprayRestriction($request->all(), $planting)) {
            return $validationResponse;
        }

        $incident = PestIncident::create([
            ...$request->only([
                'planting_id',
                'pest_type',
                'pest_name',
                'severity',
                'affected_area',
                'detected_date',
                'symptoms',
                'treatment_applied',
                'treatment_date',
                'treatment_cost',
                'notes'
            ]),
            'user_id' => Auth::id(),
            'status' => $request->treatment_applied ? PestIncident::STATUS_TREATED : PestIncident::STATUS_ACTIVE,
        ]);

        $incident->load(['planting.field']);

        // Auto-create expense if treatment cost is provided
        if ($incident->treatment_cost && $incident->treatment_cost > 0) {
            Expense::create([
                'description' => "Pest treatment: {$incident->pest_name}",
                'amount' => $incident->treatment_cost,
                'category' => Expense::CATEGORY_PESTICIDE,
                'date' => $incident->treatment_date ?? $incident->detected_date,
                'planting_id' => $incident->planting_id,
                'user_id' => Auth::id(),
                'related_entity_type' => 'pest_incident',
                'related_entity_id' => $incident->id,
                'notes' => "Auto-generated from pest incident #{$incident->id}",
            ]);
        }

        return response()->json([
            'message' => 'Pest incident recorded',
            'incident' => $incident
        ], 201);
    }

    /**
     * Get a specific pest incident
     */
    public function show(PestIncident $pestIncident): JsonResponse
    {
        if ($pestIncident->user_id !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $pestIncident->load(['planting.field', 'planting.riceVariety']);

        return response()->json(['incident' => $pestIncident]);
    }

    /**
     * Update a pest incident (e.g., add treatment)
     */
    public function update(Request $request, PestIncident $pestIncident): JsonResponse
    {
        if ($pestIncident->user_id !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $validator = Validator::make($request->all(), [
            'pest_type' => 'sometimes|in:' . implode(',', PestIncident::TYPES),
            'pest_name' => 'sometimes|string|max:100',
            'severity' => 'sometimes|in:' . implode(',', PestIncident::SEVERITIES),
            'affected_area' => 'nullable|numeric|min:0',
            'symptoms' => 'nullable|string|max:1000',
            'treatment_applied' => 'nullable|string|max:500',
            'treatment_date' => 'nullable|date',
            'treatment_cost' => 'nullable|numeric|min:0',
            'status' => 'sometimes|in:active,treated,resolved',
            'notes' => 'nullable|string|max:1000',
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => 'Validation failed', 'errors' => $validator->errors()], 422);
        }

        if ($validationResponse = $this->validateSprayRestriction($request->all(), $pestIncident->planting)) {
            return $validationResponse;
        }

        $pestIncident->update($request->only([
            'pest_type',
            'pest_name',
            'severity',
            'affected_area',
            'symptoms',
            'treatment_applied',
            'treatment_date',
            'treatment_cost',
            'status',
            'notes'
        ]));

        // Sync expense record if treatment cost changed
        if ($pestIncident->treatment_cost && $pestIncident->treatment_cost > 0) {
            Expense::updateOrCreate(
                [
                    'related_entity_type' => 'pest_incident',
                    'related_entity_id' => $pestIncident->id,
                ],
                [
                    'description' => "Pest treatment: {$pestIncident->pest_name}",
                    'amount' => $pestIncident->treatment_cost,
                    'category' => Expense::CATEGORY_PESTICIDE,
                    'date' => $pestIncident->treatment_date ?? $pestIncident->detected_date,
                    'planting_id' => $pestIncident->planting_id,
                    'user_id' => Auth::id(),
                    'notes' => "Auto-generated from pest incident #{$pestIncident->id}",
                ]
            );
        }

        return response()->json([
            'message' => 'Pest incident updated',
            'incident' => $pestIncident->fresh()
        ]);
    }

    /**
     * Check spraying restrictions for insect control
     */
    private function validateSprayRestriction(array $data, Planting $planting): ?\Illuminate\Http\JsonResponse
    {
        $treatment = strtolower($data['treatment_applied'] ?? '');

        // Only enforce on pesticide spray actions
        if (!str_contains($treatment, 'spray') && !str_contains($treatment, 'pesticide')) {
            return null;
        }

        $currentStage = $planting->getCurrentStage();
        if (!$currentStage || $currentStage->riceGrowthStage->stage_code !== 'flowering') {
            return response()->json(['message' => 'Pesticide spray is allowed only during flowering stage'], 422);
        }

        $treatmentDate = isset($data['treatment_date']) ? Carbon::parse($data['treatment_date']) : Carbon::now();

        // Ensure 7:00-8:00 local time (single hour window)
        $hour = (int) $treatmentDate->format('H');
        if ($hour !== 7) {
            return response()->json(['message' => 'Pesticide spray is allowed only between 07:00 and 08:00'], 422);
        }

        return null;
    }

    /**
     * Delete a pest incident
     */
    public function destroy(PestIncident $pestIncident): JsonResponse
    {
        if ($pestIncident->user_id !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $pestIncident->delete();

        return response()->json(['message' => 'Pest incident deleted']);
    }

    /**
     * Get pest types and common pests for dropdown
     */
    public function options(): JsonResponse
    {
        return response()->json([
            'pest_types' => PestIncident::TYPES,
            'severities' => PestIncident::SEVERITIES,
            'common_pests' => [
                'insect' => ['Rice Stem Borer', 'Brown Planthopper', 'Green Leafhopper', 'Rice Bug', 'Armyworm'],
                'disease' => ['Blast', 'Bacterial Leaf Blight', 'Sheath Blight', 'Tungro', 'Brown Spot'],
                'weed' => ['Barnyard Grass', 'Chinese Sprangletop', 'Red Sprangletop', 'Jungle Rice'],
                'rodent' => ['Rice Field Rat', 'House Mouse'],
                'other' => ['Birds', 'Snails', 'Crabs'],
            ],
        ]);
    }

    /**
     * Get pest analytics (type/severity breakdowns, trends, costs, top pests)
     */
    public function analytics(): JsonResponse
    {
        $userId = Auth::id();
        $incidents = PestIncident::where('user_id', $userId);

        // By Type
        $byType = (clone $incidents)->selectRaw('pest_type, count(*) as count')
            ->groupBy('pest_type')
            ->pluck('count', 'pest_type');

        // By Severity
        $bySeverity = (clone $incidents)->selectRaw('severity, count(*) as count')
            ->groupBy('severity')
            ->pluck('count', 'severity');

        // Monthly Trend (last 12 months)
        $twelveMonthsAgo = Carbon::now()->subMonths(12)->startOfMonth();
        $monthlyTrend = (clone $incidents)
            ->where('detected_date', '>=', $twelveMonthsAgo)
            ->selectRaw("TO_CHAR(detected_date, 'YYYY-MM') as month, count(*) as count")
            ->groupBy('month')
            ->orderBy('month')
            ->pluck('count', 'month');

        // Fill in missing months with 0
        $filledTrend = [];
        for ($i = 11; $i >= 0; $i--) {
            $monthKey = Carbon::now()->subMonths($i)->format('Y-m');
            $filledTrend[$monthKey] = $monthlyTrend[$monthKey] ?? 0;
        }

        // Treatment Costs
        $allIncidents = (clone $incidents)->get();
        $treatedWithCost = $allIncidents->whereNotNull('treatment_cost')->where('treatment_cost', '>', 0);
        $totalCost = $treatedWithCost->sum('treatment_cost');
        $avgCost = $treatedWithCost->count() > 0 ? round($totalCost / $treatedWithCost->count(), 2) : 0;

        $mostExpensive = $treatedWithCost->sortByDesc('treatment_cost')->first();

        $treatmentCosts = [
            'total' => round((float) $totalCost, 2),
            'average_per_incident' => $avgCost,
            'treated_count' => $treatedWithCost->count(),
            'most_expensive' => $mostExpensive ? [
                'pest_name' => $mostExpensive->pest_name,
                'cost' => round((float) $mostExpensive->treatment_cost, 2),
            ] : null,
        ];

        // Top 5 Recurring Pests
        $topPests = (clone $incidents)->selectRaw('pest_name, pest_type, count(*) as count')
            ->groupBy('pest_name', 'pest_type')
            ->orderByDesc('count')
            ->limit(5)
            ->get()
            ->map(fn($p) => [
                'pest_name' => $p->pest_name,
                'pest_type' => $p->pest_type,
                'count' => $p->count,
            ]);

        // Avg Resolution Days
        $resolved = $allIncidents->where('status', 'resolved')->filter(fn($i) => $i->detected_date);
        $avgResolutionDays = 0;
        if ($resolved->count() > 0) {
            $totalDays = $resolved->sum(function ($incident) {
                return Carbon::parse($incident->detected_date)->diffInDays($incident->updated_at);
            });
            $avgResolutionDays = round($totalDays / $resolved->count(), 1);
        }

        return response()->json([
            'by_type' => $byType,
            'by_severity' => $bySeverity,
            'monthly_trend' => $filledTrend,
            'treatment_costs' => $treatmentCosts,
            'top_pests' => $topPests,
            'avg_resolution_days' => $avgResolutionDays,
        ]);
    }
}
