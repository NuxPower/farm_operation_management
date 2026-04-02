<?php

namespace App\Http\Controllers;

use App\Services\Analytics\RiceProductionAnalyticsService;
use App\Services\FinancialService;
use App\Services\WeatherAnalyticsService;
use App\Services\MarketplaceService;
use App\Services\PestPredictionService;
use App\Models\Farm;
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
                    'growth_stages' => []
                ];

                foreach ($plantings as $planting) {
                    // Calculate Yield Gap (Gap II)
                    if ($planting->status === 'harvested') {
                        $productionStats['yield_gaps'][] = $this->productionService->calculateYieldGap($planting);
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

                // 2. Financial Analytics (Delegated to FinancialService)
                // Using existing robust service
                $financials = $this->financialService->getFarmFinancialSummary($farm->id, $period * 30);

                // 3. Field Efficiency (Delegated to RiceProductionAnalyticsService)
                $fieldPerformance = [];
                foreach ($farm->fields as $field) {
                    $fieldPerformance[] = $this->productionService->getFieldPerformanceAnalytics($field);
                }

                // 4. Weather Impact (Delegated to WeatherAnalyticsService)
                $weatherImpact = $this->weatherAnalyticsService->getFarmWeatherTrends($farm, $period * 30);

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

                return [
                    'production_analytics' => $productionStats,
                    'financial_analytics' => $financials,
                    'field_performance' => $fieldPerformance,
                    'weather_impact' => $weatherImpact,
                    'data_quality' => $dataQuality,
                    'risk_reflex' => [
                        'pest_risks' => $pestReflexRisk,
                        'actions' => $reflexActions,
                        'score' => $this->calculateRiskScore($pestReflexRisk)
                    ],
                    'market_performance' => $this->marketplaceService->getFarmerSales($user->id, $period * 30), // Using existing method
                    'efficiency_metrics' => [
                        'nitrogen_use_efficiency' => $efficiencies,
                        'summary' => 'Research-backed PFP Analysis'
                    ],
                    'generated_at' => now(),
                    'period_months' => $period
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
