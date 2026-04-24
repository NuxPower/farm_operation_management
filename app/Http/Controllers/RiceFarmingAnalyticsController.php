<?php

namespace App\Http\Controllers;

use App\Services\Analytics\RiceProductionAnalyticsService;
use App\Services\FinancialService;
use App\Services\WeatherAnalyticsService;
use App\Services\MarketplaceService;
use App\Services\PestPredictionService;
use App\Models\Farm;
use App\Models\WeatherLog;
use App\Models\PlantingStage;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Cache;
use Carbon\Carbon;

class RiceFarmingAnalyticsController extends Controller
{
    protected $productionService;
    protected $financialService;
    protected $weatherAnalyticsService;
    protected $marketplaceService;
    protected $pestPredictionService;

    public function __construct(
        RiceProductionAnalyticsService $productionService,
        FinancialService $financialService,
        WeatherAnalyticsService $weatherAnalyticsService,
        MarketplaceService $marketplaceService,
        PestPredictionService $pestPredictionService
    ) {
        $this->productionService = $productionService;
        $this->financialService = $financialService;
        $this->weatherAnalyticsService = $weatherAnalyticsService;
        $this->marketplaceService = $marketplaceService;
        $this->pestPredictionService = $pestPredictionService;
    }

    /**
     * Get comprehensive rice farming analytics
     */
    public function getRiceFarmingAnalytics(Request $request): JsonResponse
    {
        try {
            $user = $request->user();
            $farm = $user->farm; // Assuming single farm focus for now

            if (!$farm) {
                return response()->json(['message' => 'No farm found'], 404);
            }

            $period = $request->get('period', '12'); // months
            $startDate = Carbon::now()->subMonths($period);

            // Cache with versioning keys based on farm snapshot to avoid stale stats
            $farmVersion = $farm->updated_at?->timestamp ?? now()->timestamp;
            $fieldsVersion = $farm->fields->max('updated_at')?->timestamp ?? $farmVersion;
            $cacheKey = "farming_analytics_{$user->id}_{$period}_{$farmVersion}_{$fieldsVersion}";

            $analytics = Cache::remember($cacheKey, now()->addMinutes(30), function () use ($user, $farm, $period, $startDate) {

                // 1. Production Analytics (Delegated to RiceProductionAnalyticsService)
                // We iterate through active/recent plantings to get aggregated stats
                // Add eager loading to prevent N+1 queries in loops below
                $plantings = $farm->plantings()
                    ->where('crop_type', 'rice')
                    ->where('planting_date', '>=', $startDate)
                    ->with(['harvests', 'riceVariety', 'field'])
                    ->get();

                $productionStats = [
                    'total_plantings' => $plantings->count(),
                    'yield_gaps' => [],
                    'growth_stages' => [],
                    'post_harvest_efficiency' => []
                ];

                foreach ($plantings as $planting) {
                    // Calculate Yield Gap (Gap II)
                    if ($planting->status === 'harvested') {
                        $productionStats['yield_gaps'][] = $this->productionService->calculateYieldGap($planting);
                        $productionStats['post_harvest_efficiency'][] = $this->productionService->calculatePostHarvestEfficiency($planting);
                    }
                    // Track Growth Stages (GDD)
                    if ($planting->status !== 'harvested') {
                        $productionStats['growth_stages'][] = $this->productionService->trackGrowthStages($planting);
                    }
                }

                // Determine predominant yield unit from harvests
                $allHarvests = $plantings->flatMap(function ($p) {
                    return $p->harvests ?? collect();
                });
                $yieldUnit = 'kg';
                if ($allHarvests->isNotEmpty()) {
                    $unitCounts = $allHarvests->groupBy('unit')->map->count();
                    $yieldUnit = $unitCounts->sortDesc()->keys()->first() ?: 'kg';
                }
                $productionStats['yield_unit'] = $yieldUnit;

                // Aggregate total yield and per-hectare average for the frontend
                $totalYield = $allHarvests->sum('yield');
                $totalAreaPlanted = $plantings->where('status', 'harvested')->sum('area_planted');
                $productionStats['total_yield'] = round($totalYield, 2);
                $productionStats['average_yield_per_hectare'] = $totalAreaPlanted > 0
                    ? round($totalYield / $totalAreaPlanted, 2)
                    : 0;

                // Monthly production trend for charts
                $productionStats['monthly_production'] = $allHarvests
                    ->sortBy('harvest_date')
                    ->groupBy(fn($h) => Carbon::parse($h->harvest_date)->format('M Y'))
                    ->map(fn($group, $month) => [
                        'month'       => $month,
                        'total_yield' => round($group->sum('yield'), 2),
                    ])
                    ->values()
                    ->toArray();

                // Yield breakdown by rice variety
                $productionStats['yield_by_variety'] = $plantings
                    ->where('status', 'harvested')
                    ->groupBy(fn($p) => $p->riceVariety?->name ?? $p->crop_type ?? 'Unknown')
                    ->map(function ($group, $varietyName) {
                        $varietyHarvests = $group->flatMap(fn($p) => $p->harvests ?? collect());
                        $varietyYield    = round($varietyHarvests->sum('yield'), 2);
                        $varietyArea     = round($group->sum('area_planted'), 2);
                        return [
                            'variety_name'      => $varietyName,
                            'total_yield'       => $varietyYield,
                            'total_area'        => $varietyArea,
                            'yield_per_hectare' => $varietyArea > 0 ? round($varietyYield / $varietyArea, 2) : 0,
                        ];
                    })
                    ->values()
                    ->toArray();

                // 2. Financial Analytics (Delegated to FinancialService)
                // Using existing robust service
                $financials = $this->financialService->getFarmFinancialSummary($farm->id, $period * 30);

                // 3. Field Efficiency (Delegated to RiceProductionAnalyticsService)
                $rawFieldItems = [];
                foreach ($farm->fields as $field) {
                    $perf = $this->productionService->getFieldPerformanceAnalytics($field);
                    if (isset($perf['field_name'])) {
                        $fieldHarvests = $field->plantings()
                            ->with('harvests')
                            ->where('status', 'harvested')
                            ->get()
                            ->flatMap(fn($p) => $p->harvests ?? collect());
                        $fieldYield    = $fieldHarvests->sum('yield');
                        $fieldArea     = $field->size > 0 ? $field->size : 1;
                        $rawFieldItems[] = [
                            'field_id'                      => $field->id,
                            'field_name'                    => $field->name,
                            'size'                          => round($field->size, 2),
                            'productivity_score'            => $perf['productivity_score'] ?? 0,
                            'average_yield_gap_pct'         => $perf['average_yield_gap_pct'] ?? 0,
                            'average_fertilizer_efficiency' => $perf['average_fertilizer_efficiency'] ?? 0,
                            'yield_per_hectare'             => round($fieldYield / $fieldArea, 2),
                        ];
                    }
                }
                $fieldPerformance = [
                    'average_productivity_score' => count($rawFieldItems) > 0
                        ? round(collect($rawFieldItems)->avg('productivity_score'), 1)
                        : 0,
                    'field_performance' => $rawFieldItems,
                ];

                // 4. Weather Impact (Delegated to WeatherAnalyticsService)
                $weatherImpact = $this->weatherAnalyticsService->getFarmWeatherTrends($farm, $period * 30);

                // Compute weather suitability from recent logs (temp 60% weight, humidity 40%)
                $recentLogs     = WeatherLog::where('farm_id', $farm->id)->where('recorded_at', '>=', $startDate)->get();
                $avgSuitability = 0;
                if ($recentLogs->isNotEmpty()) {
                    $avgTemp     = $recentLogs->avg('temperature');
                    $avgHumidity = $recentLogs->avg('humidity');
                    $tempScore   = ($avgTemp >= 22 && $avgTemp <= 28) ? 100 : (($avgTemp >= 18 && $avgTemp <= 32) ? 70 : 40);
                    $humScore    = ($avgHumidity >= 65 && $avgHumidity <= 80) ? 100 : (($avgHumidity >= 55 && $avgHumidity <= 90) ? 70 : 40);
                    $avgSuitability = round($tempScore * 0.6 + $humScore * 0.4, 1);
                }
                $riskLevel = data_get($weatherImpact, 'trend_analysis.risk_level', 'low');
                $weatherImpact['average_weather_suitability'] = $avgSuitability;
                $weatherImpact['weather_risk_assessment']     = ucfirst($riskLevel);

                // 5. Fertilizer/Resource Efficiency (Delegated to RiceProductionAnalyticsService)
                // Calculate average NUE (PFP) across recent plantings
                $efficiencies = [];
                foreach ($plantings as $p) {
                    if ($p->status === 'harvested') {
                        $efficiencies[] = $this->productionService->calculateFertilizerEfficiency($p);
                    }
                }

                // Data drift auditing and risk reflex evaluations
                $dataQuality = $this->weatherAnalyticsService->getDataQualityMetrics($farm, $period * 30);

                $pestReflexRisk = $this->pestPredictionService->predictRisks($farm, collect(), null);
                $reflexActions = $this->determineReflexActions($pestReflexRisk, $weatherImpact);

                // 6. Aggregate post-harvest efficiency as top-level summary
                $phEfficiencyData = collect($productionStats['post_harvest_efficiency'])
                    ->where('status', 'calculated');

                $postHarvestSummary = null;
                if ($phEfficiencyData->isNotEmpty()) {
                    $avgRecovery = round($phEfficiencyData->avg('average_recovery_rate'), 2);
                    $avgWeightLoss = round($phEfficiencyData->avg('average_weight_loss_percentage'), 2);
                    $totalProcessingCost = $phEfficiencyData->sum('total_processing_cost');
                    $totalProcesses = $phEfficiencyData->sum('processes_count');

                    $postHarvestSummary = [
                        'average_recovery_rate' => $avgRecovery,
                        'average_weight_loss' => $avgWeightLoss,
                        'total_processing_cost' => $totalProcessingCost,
                        'total_processes' => $totalProcesses,
                        'cost_efficiency' => [
                            'avg_cost_per_bushel' => $totalProcesses > 0 && $totalYield > 0
                                ? round($totalProcessingCost / $totalYield, 2)
                                : 0,
                        ],
                    ];
                }

                // Stage completion efficiency
                $plantingIds     = $plantings->pluck('id')->toArray();
                $allStages        = PlantingStage::whereIn('planting_id', $plantingIds)->get();
                $totalStageCount  = $allStages->count();
                $completedCount   = $allStages->where('status', 'completed')->count();
                $stageCompletion  = $totalStageCount > 0
                    ? round(($completedCount / $totalStageCount) * 100, 1)
                    : 0;

                // Yield efficiency from yield gap analysis
                $validGaps        = collect($productionStats['yield_gaps'])->where('status', 'calculated');
                $avgYieldEff      = $validGaps->isNotEmpty()
                    ? max(0, round(100 - $validGaps->avg('gap_percentage'), 1))
                    : 0;

                return [
                    'production_analytics' => $productionStats,
                    'financial_analytics'  => $financials,
                    'field_performance'    => $fieldPerformance,
                    'weather_impact'       => $weatherImpact,
                    'data_quality'         => $dataQuality,
                    'post_harvest_efficiency' => $postHarvestSummary,
                    'risk_reflex' => [
                        'pest_risks' => $pestReflexRisk,
                        'actions'    => $reflexActions,
                        'score'      => $this->calculateRiskScore($pestReflexRisk)
                    ],
                    'market_performance' => $this->marketplaceService->getFarmerSales($user->id, $period * 30),
                    'efficiency_metrics' => [
                        'stage_completion_efficiency' => $stageCompletion,
                        'yield_efficiency'            => $avgYieldEff,
                        'nitrogen_use_efficiency'     => $efficiencies,
                        'summary'                     => 'Research-backed PFP Analysis',
                    ],
                    'generated_at'  => now(),
                    'period_months' => $period,
                ];
            });

            return response()->json([
                'analytics' => $analytics,
                'status' => 'success'
            ]);

        } catch (\Exception $e) {
            \Log::error('Rice farming analytics failed', [
                'user_id' => $request->user()?->id,
                'farm_id' => $request->user()?->farm?->id,
                'error' => $e->getMessage()
            ]);

            return response()->json([
                'message' => 'Failed to generate rice farming analytics',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    private function determineReflexActions(array $pestRisks, array $weatherImpact): array
    {
        $actions = [];

        if (empty($pestRisks)) {
            $actions[] = 'Maintain regular monitoring; no immediate pest risk detected.';
            return $actions;
        }

        $highSeverityCount = collect($pestRisks)->filter(fn($r) => strtolower($r['risks'][0]['risk_level'] ?? 'low') === 'high')->count();
        if ($highSeverityCount > 0) {
            $actions[] = 'Implement immediate integrated pest management protocols on high-risk fields.';
        }

        $actions[] = 'Adjust irrigation schedule based on recent weather impact recommendations.';

        $temperatureTrend = data_get($weatherImpact, 'trends.temperature.overall_average');
        if ($temperatureTrend !== null && $temperatureTrend > 35) {
            $actions[] = 'Prepare heat stress mitigation measures: shade nets and extra irrigation.';
        }

        return array_values(array_unique($actions));
    }

    private function calculateRiskScore(array $pestRisks): float
    {
        if (empty($pestRisks)) {
            return 0.0;
        }

        $score = 0;
        foreach ($pestRisks as $risk) {
            $riskLevel = strtolower($risk['risks'][0]['risk_level'] ?? 'low');
            $score += match ($riskLevel) {
                'critical' => 3,
                'high' => 2,
                'medium' => 1,
                default => 0.3,
            };
        }

        return min(100, $score * 10);
    }
}
