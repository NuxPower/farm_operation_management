<?php

namespace App\Http\Controllers;

use App\Services\Analytics\RiceProductionAnalyticsService;
use App\Services\FinancialService;
use App\Services\WeatherAnalyticsService;
use App\Services\MarketplaceService;
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

    public function __construct(
        RiceProductionAnalyticsService $productionService,
        FinancialService $financialService,
        WeatherAnalyticsService $weatherAnalyticsService,
        MarketplaceService $marketplaceService
    ) {
        $this->productionService = $productionService;
        $this->financialService = $financialService;
        $this->weatherAnalyticsService = $weatherAnalyticsService;
        $this->marketplaceService = $marketplaceService;
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

            // Cache for performance optimization (keep existing strategy)
            $analytics = Cache::remember("farming_analytics_{$user->id}_{$period}", now()->addHours(6), function () use ($user, $farm, $period, $startDate) {

                // 1. Production Analytics (Delegated to RiceProductionAnalyticsService)
                // We iterate through active/recent plantings to get aggregated stats
                $plantings = $farm->plantings()
                    ->where('crop_type', 'rice')
                    ->where('planting_date', '>=', $startDate)
                    ->with('harvests')
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

                return [
                    'production_analytics' => $productionStats,
                    'financial_analytics' => $financials,
                    'field_performance' => $fieldPerformance,
                    'weather_impact' => $weatherImpact,
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
            return response()->json([
                'message' => 'Failed to generate rice farming analytics',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}