<?php

namespace App\Http\Controllers\Analytics;

use App\Http\Controllers\Controller;
use App\Services\ReportService;
use App\Services\FinancialService;
use App\Services\WeatherAnalyticsService;
use App\Services\PestPredictionService;
use App\Services\Traits\AnalyticsValidationTrait;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Models\Task;
use App\Models\Field;
use App\Models\Planting;
use App\Models\SeedPlanting;
use App\Models\PestIncident;
use App\Models\InventoryItem;
use App\Models\InventoryTransaction;
use App\Models\WeatherLog;
use App\Models\Laborer;
use App\Models\LaborWage;
use App\Models\PostHarvestProcess;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;

class DataAnalysisController extends Controller
{
    use AnalyticsValidationTrait;

    protected $reportService;
    protected $financialService;
    protected $weatherAnalyticsService;
    protected $pestPredictionService;
    protected $weatherService;

    public function __construct(
        ReportService $reportService,
        FinancialService $financialService,
        WeatherAnalyticsService $weatherAnalyticsService,
        PestPredictionService $pestPredictionService,
        \App\Services\WeatherService $weatherService
    ) {
        $this->reportService = $reportService;
        $this->financialService = $financialService;
        $this->weatherAnalyticsService = $weatherAnalyticsService;
        $this->pestPredictionService = $pestPredictionService;
        $this->weatherService = $weatherService;
    }

    /**
     * Get comprehensive data analysis with action suggestions
     */
    public function getComprehensiveAnalytics(Request $request): JsonResponse
    {
        $user = $request->user();
        $farm = $user->farm;

        // 1. Get Core Dashboard Analytics
        $dashboardData = $this->reportService->getDashboardAnalytics($user->id, $farm ? $farm->id : null);
        $financialSummary = $dashboardData['financial_summary'] ?? [];

        $pendingOrdersCount = \App\Models\RiceOrder::whereHas('riceProduct', function ($query) use ($user) {
            $query->where('farmer_id', $user->id);
        })->where('status', \App\Models\RiceOrder::STATUS_PENDING)->count();

        // 2. Sales Data
        $salesData = [
            'total_revenue' => $financialSummary['total_revenue'] ?? 0,
            'total_orders' => $dashboardData['recent_activities'] ? count(array_filter($dashboardData['recent_activities'], fn($a) => $a['type'] === 'sale')) : 0,
            'pending_orders' => $pendingOrdersCount,
        ];

        // 3. Expenses Data with category breakdown
        $expensesData = [
            'total_expenses' => $financialSummary['total_expenses'] ?? 0,
            'expense_count' => 0,
            'trend_percentage' => 0,
            'by_category' => [],
        ];

        if ($farm) {
            $expenses = $this->financialService->getFarmExpenses($farm->id, now()->subDays(90));
            $expensesData['expense_count'] = $expenses->count();
            $totalExpenseAmount = $expenses->sum('amount');

            if ($totalExpenseAmount > 0) {
                $breakdown = $this->financialService->getExpenseBreakdown($expenses);
                $expensesData['by_category'] = $breakdown->map(function ($item) use ($totalExpenseAmount) {
                    return [
                        'total' => $item['total'],
                        'count' => $item['count'],
                        'percentage' => round(($item['total'] / $totalExpenseAmount) * 100, 1),
                    ];
                })->toArray();
            }
        }

        // 4. Task Statistics
        $taskStats = [
            'total_tasks' => 0,
            'completed_tasks' => 0,
            'pending_tasks' => 0,
            'overdue_tasks' => 0
        ];

        if ($farm) {
            // Count tasks owned via planting->field OR direct field_id
            $farmTaskScope = function ($query) use ($farm) {
                $query->where(function ($q) use ($farm) {
                    $q->whereHas('planting.field', function ($fq) use ($farm) {
                        $fq->where('farm_id', $farm->id);
                    })->orWhereHas('field', function ($fq) use ($farm) {
                        $fq->where('farm_id', $farm->id);
                    });
                });
            };

            $taskStats['total_tasks'] = Task::where(function ($q) use ($farmTaskScope) {
                $farmTaskScope($q);
            })->count();

            $taskStats['completed_tasks'] = Task::where(function ($q) use ($farmTaskScope) {
                $farmTaskScope($q);
            })->where('status', Task::STATUS_COMPLETED)->count();

            $taskStats['pending_tasks'] = Task::where(function ($q) use ($farmTaskScope) {
                $farmTaskScope($q);
            })->where('status', Task::STATUS_PENDING)->count();

            $taskStats['overdue_tasks'] = Task::where(function ($q) use ($farmTaskScope) {
                $farmTaskScope($q);
            })->where('due_date', '<', now())
                ->where('status', '!=', Task::STATUS_COMPLETED)
                ->count();
        }

        // 5. Weather Data
        $weatherData = [
            'avg_temperature' => null,
            'total_rainfall' => null,
            'avg_humidity' => null,
        ];

        $weatherForecast = null;

        if ($farm) {
            $recentWeather = WeatherLog::where('farm_id', $farm->id)
                ->where('recorded_at', '>=', now()->subDays(7))
                ->get();

            if ($recentWeather->isNotEmpty()) {
                $weatherData = [
                    'avg_temperature' => round($recentWeather->avg('temperature'), 1),
                    'total_rainfall' => round($recentWeather->sum('rainfall'), 1),
                    'avg_humidity' => round($recentWeather->avg('humidity'), 1),
                ];
            }

            // Get Forecast for suggestions
            $weatherCoordValidation = $this->validateWeatherCoordinatesSafe($farm);
            if ($weatherCoordValidation['valid']) {
                try {
                    $weatherForecast = $this->weatherService->getForecast(
                        (float) $weatherCoordValidation['coordinates']['lat'],
                        (float) $weatherCoordValidation['coordinates']['lon']
                    );
                } catch (\Exception $e) {
                    Log::error("Weather forecast fetch failed for farm {$farm->id}: " . $e->getMessage());
                    $weatherForecast = null;
                }
            } else {
                Log::warning("Weather forecast skipped for farm {$farm->id}: {$weatherCoordValidation['issue']}");
                $weatherData['weather_alert'] = $weatherCoordValidation['issue'];
            }
        }

        // 6. Fields Data
        $fieldsData = [
            'total_area' => 0,
            'utilization_rate' => 0,
        ];

        if ($farm) {
            $totalArea = $farm->fields->sum('size');
            $plantedArea = Planting::whereHas('field', function ($q) use ($farm) {
                $q->where('farm_id', $farm->id);
            })->whereIn('status', ['planted', 'growing', 'active'])->sum('area_planted');

            $fieldsData = [
                'total_area' => round($totalArea, 2),
                'utilization_rate' => $totalArea > 0 ? round(($plantedArea / $totalArea) * 100, 1) : 0,
            ];
        }

        // 7. Nursery Data (SeedPlanting)
        $nurseryData = [
            'active_batches' => 0,
            'ready_for_transplant' => 0,
        ];

        $nurseryData['active_batches'] = SeedPlanting::where('user_id', $user->id)
            ->whereIn('status', ['sown', 'germinating', 'ready'])
            ->count();

        $nurseryData['ready_for_transplant'] = SeedPlanting::where('user_id', $user->id)
            ->where('status', 'ready')
            ->count();

        // 8. Pest Incidents Data (Enriched)
        $pestsData = [
            'total_incidents' => 0,
            'active_incidents' => 0,
            'by_type' => [],
            'by_severity' => [],
            'total_treatment_cost' => 0,
            'avg_resolution_days' => 0,
            'forecasts' => [],
        ];

        if ($farm) {
            $plantingIds = Planting::whereHas('field', function ($q) use ($farm) {
                $q->where('farm_id', $farm->id);
            })->pluck('id');

            // Add eager loading to prevent N+1 queries
            $farmIncidents = PestIncident::whereIn('planting_id', $plantingIds)
                ->with(['planting.riceVariety', 'planting.field']);

            $pestsData['total_incidents'] = (clone $farmIncidents)->count();
            $pestsData['active_incidents'] = (clone $farmIncidents)->active()->count();

            // Type breakdown
            $pestsData['by_type'] = (clone $farmIncidents)
                ->selectRaw('pest_type, count(*) as count')
                ->groupBy('pest_type')
                ->pluck('count', 'pest_type');

            // Severity breakdown
            $pestsData['by_severity'] = (clone $farmIncidents)
                ->selectRaw('severity, count(*) as count')
                ->groupBy('severity')
                ->pluck('count', 'severity');

            // Treatment cost
            $pestsData['total_treatment_cost'] = round((float) ((clone $farmIncidents)->sum('treatment_cost') ?? 0), 2);

            // Avg resolution days
            $resolved = (clone $farmIncidents)->where('status', 'resolved')->get()->filter(fn($i) => $i->detected_date);
            if ($resolved->count() > 0) {
                $totalDays = $resolved->sum(fn($i) => Carbon::parse($i->detected_date)->diffInDays($i->updated_at));
                $pestsData['avg_resolution_days'] = round($totalDays / $resolved->count(), 1);
            }

            // Pest forecasts — per field with active planting info
            $forecasts = [];
            $resolvedIncidents = (clone $farmIncidents)->where('status', 'resolved')->get();

            foreach ($farm->fields as $field) {
                // Find active planting for this field - add eager loading
                $activePlanting = $field->plantings()
                    ->whereIn('status', ['planted', 'growing'])
                    ->with(['riceVariety', 'harvests'])
                    ->first();

                // Get per-field risks (passing planting for growth-stage filtering)
                $fieldRisks = $this->pestPredictionService->predictRisks($farm, $resolvedIncidents, $activePlanting);

                if (!empty($fieldRisks)) {
                    $fieldForecast = [
                        'field_name' => $field->name,
                        'predictions' => $fieldRisks,
                    ];

                    // Add crop context if there's an active planting
                    if ($activePlanting) {
                        $daysPlanted = Carbon::parse($activePlanting->planting_date)->diffInDays(now());
                        $growthStage = $daysPlanted <= 45 ? 'Vegetative' : ($daysPlanted <= 75 ? 'Reproductive' : 'Ripening');

                        $fieldForecast['crop_info'] = [
                            'variety' => $activePlanting->riceVariety->name ?? $activePlanting->crop_type ?? 'Unknown',
                            'days_planted' => $daysPlanted,
                            'growth_stage' => $growthStage,
                        ];
                    }

                    $forecasts[] = $fieldForecast;
                }
            }
            $pestsData['forecasts'] = $forecasts;
        }

        // 9. Laborers Data
        $laborersData = [
            'total_laborers' => 0,
            'active_laborers' => 0,
            'total_labor_cost' => 0,
            'completion_rate' => 0,
        ];

        $laborersData['total_laborers'] = Laborer::where('user_id', $user->id)->count();
        $laborersData['active_laborers'] = Laborer::where('user_id', $user->id)->where('status', 'active')->count();
        $laborersData['total_labor_cost'] = $financialSummary['total_labor_costs'] ?? 0;

        // Calculate completion rate from tasks
        if ($taskStats['total_tasks'] > 0) {
            $laborersData['completion_rate'] = round(($taskStats['completed_tasks'] / $taskStats['total_tasks']) * 100, 1);
        }

        // 10. Financial Forecast (Projected Cash Flow)
        $financialForecast = null;

        if ($farm) {
            $projection = $this->financialService->getCashFlowProjection($farm->id, 6);
            if (!empty($projection)) {
                $financialForecast = [
                    'months' => array_column($projection, 'month_name'),
                    'projected_revenue' => array_column($projection, 'projected_revenue'),
                    'projected_expenses' => array_map(function ($item) {
                        return ($item['projected_expenses'] ?? 0) + ($item['projected_labor_costs'] ?? 0);
                    }, $projection),
                ];
            }
        }

        // 11. Inventory Data (Enriched)
        $userItems = InventoryItem::where('user_id', $user->id);
        $allItems = (clone $userItems)->get();

        $lowStockItems = $allItems->filter(fn($i) => $i->isLowStock());
        $expiringSoon = (clone $userItems)
            ->whereNotNull('expiry_date')
            ->where('expiry_date', '<=', now()->addDays(30))
            ->where('expiry_date', '>=', now())
            ->get();

        // Category breakdown
        $byCategory = $allItems->groupBy('category')->map(function ($items, $cat) {
            return [
                'count' => $items->count(),
                'total_value' => round($items->sum(fn($i) => $i->current_stock * $i->unit_price), 2),
            ];
        });

        // Historical usage from transactions (last 90 days)
        $usageTransactions = InventoryTransaction::whereHas('inventoryItem', function ($q) use ($user) {
            $q->where('user_id', $user->id);
        })
            ->where('transaction_type', 'removal')
            ->where('transaction_date', '>=', now()->subDays(90))
            ->get();

        $totalConsumed = $usageTransactions->sum('quantity');
        $topConsumedId = $usageTransactions->groupBy('inventory_item_id')
            ->map(fn($txns) => $txns->sum('quantity'))
            ->sortDesc()
            ->keys()
            ->first();

        $mostConsumedItem = $topConsumedId
            ? $allItems->firstWhere('id', $topConsumedId)
            : null;

        $inventoryData = [
            'total_items' => $allItems->count(),
            'total_value' => $dashboardData['overview']['total_inventory_value'] ?? round($allItems->sum(fn($i) => $i->current_stock * $i->unit_price), 2),
            'low_stock_count' => $lowStockItems->count(),
            'expiring_soon_count' => $expiringSoon->count(),
            'by_category' => $byCategory,
            'historical_usage' => [
                'total_consumed' => round($totalConsumed, 2),
                'most_consumed_item' => $mostConsumedItem ? [
                    'name' => $mostConsumedItem->name,
                    'category' => $mostConsumedItem->category,
                ] : null,
            ],
        ];

        // 11.5 PostHarvest Data
        $postHarvestData = [
            'total_processes' => 0,
            'average_recovery_rate' => 0,
            'cost_optimization' => [
                'self_avg_cost' => 0,
                'provider_avg_cost' => 0,
            ],
            'variety_performance' => [],
            'historical_trends' => []
        ];

        if ($farm) {
            $processes = PostHarvestProcess::with(['harvest.planting.riceVariety'])->whereHas('planting.field', function ($q) use ($farm) {
                $q->where('farm_id', $farm->id);
            })->where('status', PostHarvestProcess::STATUS_COMPLETED)
              ->orderBy('completed_date', 'asc')
              ->get();

            $postHarvestData['total_processes'] = $processes->count();

            if ($processes->count() > 0) {
                $totalRecovery = 0;
                $recoveryCount = 0;
                
                $selfCosts = [];
                $providerCosts = [];
                $varietyStats = [];
                $historicalTrends = [];

                foreach ($processes as $process) {
                    $rate = $process->getRecoveryRate();
                    if ($rate !== null) {
                        $totalRecovery += $rate;
                        $recoveryCount++;

                        // Historical trends
                        $month = Carbon::parse($process->completed_date ?? $process->updated_at)->format('Y-m');
                        if (!isset($historicalTrends[$month])) {
                            $historicalTrends[$month] = ['total_rate' => 0, 'count' => 0];
                        }
                        $historicalTrends[$month]['total_rate'] += $rate;
                        $historicalTrends[$month]['count']++;

                        // Variety performance
                        $varietyName = $process->harvest->planting->riceVariety->name ?? $process->harvest->planting->crop_type ?? 'Unknown';
                        if (!isset($varietyStats[$varietyName])) {
                            $varietyStats[$varietyName] = ['total_rate' => 0, 'count' => 0];
                        }
                        $varietyStats[$varietyName]['total_rate'] += $rate;
                        $varietyStats[$varietyName]['count']++;
                    }

                    // Cost Optimization
                    if ($process->cost > 0 && $process->output_quantity > 0) {
                        $costPerUnit = $process->cost / $process->output_quantity;
                        if ($process->cost_type === 'self') {
                            $selfCosts[] = $costPerUnit;
                        } else {
                            $providerCosts[] = $costPerUnit;
                        }
                    }
                }

                $postHarvestData['average_recovery_rate'] = $recoveryCount > 0 ? round($totalRecovery / $recoveryCount, 2) : 0;
                
                $postHarvestData['cost_optimization']['self_avg_cost'] = count($selfCosts) > 0 ? round(array_sum($selfCosts) / count($selfCosts), 2) : 0;
                $postHarvestData['cost_optimization']['provider_avg_cost'] = count($providerCosts) > 0 ? round(array_sum($providerCosts) / count($providerCosts), 2) : 0;

                foreach ($varietyStats as $name => $stat) {
                    $postHarvestData['variety_performance'][] = [
                        'variety' => $name,
                        'average_recovery_rate' => round($stat['total_rate'] / $stat['count'], 2)
                    ];
                }

                foreach ($historicalTrends as $month => $stat) {
                    $postHarvestData['historical_trends'][] = [
                        'month' => $month,
                        'average_recovery_rate' => round($stat['total_rate'] / $stat['count'], 2)
                    ];
                }
            }
        }

        // 12. Failure Analysis (new)
        $failureData = [
            'total_failed'          => 0,
            'failure_rate_pct'      => 0,
            'total_crop_loss_value' => 0,
            'avg_days_before_failure' => 0,
            'by_category'           => [],
            'by_variety'            => [],
            'by_season'             => [],
        ];

        if ($farm) {
            $allPlantingIds = Planting::whereHas('field', function ($q) use ($farm) {
                $q->where('farm_id', $farm->id);
            })->pluck('id');

            $totalPlantingCount = $allPlantingIds->count();

            $failedPlantings = Planting::whereHas('field', function ($q) use ($farm) {
                $q->where('farm_id', $farm->id);
            })->failed()->with(['expenses', 'riceVariety'])->get();

            $failureData['total_failed'] = $failedPlantings->count();
            $failureData['failure_rate_pct'] = $totalPlantingCount > 0
                ? round(($failedPlantings->count() / $totalPlantingCount) * 100, 1)
                : 0;

            // Total crop loss (sum of crop_loss expenses tied to failed plantings)
            $failureData['total_crop_loss_value'] = round(
                $failedPlantings->sum(fn($p) => $p->expenses->where('category', 'crop_loss')->sum('amount')),
                2
            );

            // Average days before failure
            $plantingsWithDates = $failedPlantings->filter(
                fn($p) => $p->planting_date && $p->failed_at
            );
            if ($plantingsWithDates->count() > 0) {
                $totalDays = $plantingsWithDates->sum(
                    fn($p) => $p->planting_date->diffInDays($p->failed_at)
                );
                $failureData['avg_days_before_failure'] = round($totalDays / $plantingsWithDates->count(), 1);
            }

            // By category
            $failureData['by_category'] = $failedPlantings
                ->groupBy('failure_category')
                ->map(fn($group, $cat) => [
                    'category' => Planting::FAILURE_CATEGORIES[$cat] ?? ($cat ?? 'Unknown'),
                    'count'    => $group->count(),
                ])->values();

            // By variety
            $failureData['by_variety'] = $failedPlantings
                ->groupBy(fn($p) => $p->riceVariety->name ?? $p->crop_type ?? 'Unknown')
                ->map(fn($group, $variety) => [
                    'variety' => $variety,
                    'count'   => $group->count(),
                ])->values();

            // By season
            $failureData['by_season'] = $failedPlantings
                ->groupBy('season')
                ->map(fn($group, $season) => [
                    'season' => $season ?? 'Unknown',
                    'count'  => $group->count(),
                ])->values();
        }

        // 13. Executive Summary & Action Suggestions (Generated)
        // 13. Executive Summary & Action Suggestions (Generated)
        $executiveSummary = $this->generateExecutiveSummary($salesData, $expensesData, $taskStats, $pestsData, $user);
        $actionSuggestions = $this->generateActionSuggestions($taskStats, $salesData, $expensesData, $pestsData, $nurseryData, $weatherForecast, $inventoryData, $failureData, $user);

        return response()->json([
            'executive_summary'  => $executiveSummary,
            'action_suggestions' => $actionSuggestions,
            'weather'            => $weatherData,
            'sales'              => $salesData,
            'expenses'           => $expensesData,
            'tasks'              => $taskStats,
            'fields'             => $fieldsData,
            'nursery'            => $nurseryData,
            'pests'              => $pestsData,
            'laborers'           => $laborersData,
            'inventory'          => $inventoryData,
            'post_harvest'       => $postHarvestData,
            'failure_analysis'   => $failureData,
            'financial_forecast' => $financialForecast,
            'generated_at'       => now(),
        ]);
    }

    /**
     * Generate an executive summary based on analytics data
     */
    private function generateExecutiveSummary($sales, $expenses, $tasks, $pests, $user = null): array
    {
        $revenue = $sales['total_revenue'] ?? 0;
        $expenseTotal = $expenses['total_expenses'] ?? 0;
        $profit = $revenue - $expenseTotal;

        $tone = 'neutral';
        $text = 'Farm operations are proceeding normally.';

        if ($profit > 0 && $revenue > 0) {
            $margin = ($profit / $revenue) * 100;
            if ($margin > 20) {
                $tone = 'positive';
                $text = sprintf(
                    'Strong financial performance with %.1f%% profit margin. Revenue of ₱%s with expenses at ₱%s.',
                    $margin,
                    number_format($revenue, 0),
                    number_format($expenseTotal, 0)
                );
            } else {
                $tone = 'neutral';
                $text = sprintf(
                    'Moderate performance with %.1f%% profit margin. Consider reviewing expenses to improve profitability.',
                    $margin
                );
            }
        } elseif ($profit < 0) {
            $tone = 'concern';
            $text = sprintf(
                'Expenses (₱%s) currently exceed revenue (₱%s). Review cost management strategies.',
                number_format($expenseTotal, 0),
                number_format($revenue, 0)
            );
        }

        // Add pest concerns
        if (($pests['active_incidents'] ?? 0) > 0) {
            $tone = 'concern';
            $text .= sprintf(' There are %d active pest incidents requiring attention.', $pests['active_incidents']);
        }

        // Add task concerns
        if (($tasks['overdue_tasks'] ?? 0) > 0) {
            $text .= sprintf(' %d tasks are overdue.', $tasks['overdue_tasks']);
        }

        // Add auto-cancelled order warning
        if ($user) {
            $autoCancelled = \App\Models\RiceOrder::whereHas('riceProduct', fn($q) => $q->where('farmer_id', $user->id))
                ->where('status', \App\Models\RiceOrder::STATUS_CANCELLED)
                ->where('updated_at', '>=', now()->subWeek())
                ->where('cancellation_reason', 'like', '%auto-cancelled%')
                ->count();
            if ($autoCancelled > 0) {
                $tone = 'concern';
                $text .= sprintf(' Attention: %d orders were auto-cancelled this week due to expired pick-up deadlines.', $autoCancelled);
            }
        }

        return [
            'tone' => $tone,
            'text' => $text,
        ];
    }

    /**
     * Generate action suggestions based on analytics data
     */
    private function generateActionSuggestions($tasks, $sales, $expenses, $pests, $nursery, $weatherForecast = null, $inventory = null, $failureData = null, $user = null): array
    {
        $suggestions = [];

        if ($user) {
            // Pending Sales Orders
            $pendingOrdersCount = \App\Models\RiceOrder::whereHas('riceProduct', fn($q) => $q->where('farmer_id', $user->id))
                ->where('status', \App\Models\RiceOrder::STATUS_PENDING)
                ->count();
            if ($pendingOrdersCount > 0) {
                $suggestions[] = [
                    'icon' => '🛒',
                    'category' => 'Sales & Orders',
                    'message' => sprintf('You have %d pending sales order(s). Review and confirm them.', $pendingOrdersCount),
                    'priority' => 'high',
                    'action_label' => 'View Orders',
                    'action_url' => '/marketplace/orders',
                ];
            }

            // Pickup Deadline Expiring
            $expiringPickups = \App\Models\RiceOrder::whereHas('riceProduct', fn($q) => $q->where('farmer_id', $user->id))
                ->where('status', \App\Models\RiceOrder::STATUS_READY_FOR_PICKUP)
                ->whereNotNull('pickup_deadline')
                ->where('pickup_deadline', '>', now())
                ->where('pickup_deadline', '<=', now()->addHours(24))
                ->count();
            if ($expiringPickups > 0) {
                $suggestions[] = [
                    'icon' => '⏳',
                    'category' => 'Sales & Orders',
                    'message' => sprintf('%d order(s) awaiting pickup will expire within 24 hours.', $expiringPickups),
                    'priority' => 'urgent',
                    'action_label' => 'Check Pickups',
                    'action_url' => '/marketplace/orders',
                ];
            }

            // Harvest Readiness
            $readyForHarvest = \App\Models\Planting::whereHas('field.farm', fn($q) => $q->where('user_id', $user->id))
                ->where('status', 'in_progress')
                ->whereHas('plantingStages', function($q) {
                    $q->where('status', 'in_progress')
                      ->whereHas('riceGrowthStage', fn($q2) => $q2->where('name', 'like', '%ripening%')->orWhere('name', 'like', '%maturity%'));
                })->count();
            if ($readyForHarvest > 0) {
                $suggestions[] = [
                    'icon' => '🌾',
                    'category' => 'Production',
                    'message' => sprintf('%d planting(s) have reached maturity/ripening. Schedule a harvest.', $readyForHarvest),
                    'priority' => 'high',
                    'action_label' => 'Schedule Harvest',
                    'action_url' => '/plantings',
                ];
            }
        }

        // Weather suggestion (Priority)
        if ($weatherForecast) {
            $todayForecast = $weatherForecast['list'][0] ?? null;
            if ($todayForecast) {
                $rainfall = $todayForecast['pop'] > 0 ? ($todayForecast['rain'] ?? 0) : 0; // Check structure
                // Assuming OWM format might vary, but pop is probability.
                // Let's rely on rain volume or description if available or simple conditions.

                // Check if weather condition indicates rain/storm
                $conditionCode = $todayForecast['weather'][0]['main'] ?? '';

                if (in_array(strtolower($conditionCode), ['rainy', 'stormy', 'thunderstorm', 'rain'])) {
                    $suggestions[] = [
                        'icon' => '🌧️',
                        'category' => 'Weather Alert',
                        'message' => 'Rain is in the forecast. Check drainage and delay sensitive activities.',
                        'priority' => 'high',
                        'action_label' => 'View Forecast',
                        'action_url' => '/weather',
                    ];
                }
            }
        }

        // Overdue tasks suggestion
        if (($tasks['overdue_tasks'] ?? 0) > 0) {
            $suggestions[] = [
                'icon' => '⚠️',
                'category' => 'Task Management',
                'message' => sprintf('%d overdue tasks need immediate attention', $tasks['overdue_tasks']),
                'priority' => 'high',
                'action_label' => 'View Tasks',
                'action_url' => '/tasks',
            ];
        }

        // Pest incidents suggestion
        if (($pests['active_incidents'] ?? 0) > 0) {
            $suggestions[] = [
                'icon' => '🐛',
                'category' => 'Pest Control',
                'message' => sprintf('%d active pest incidents require treatment', $pests['active_incidents']),
                'priority' => 'high',
                'action_label' => 'Manage Pests',
                'action_url' => '/pest-tracker',
            ];
        }

        // Nursery suggestion
        if (($nursery['ready_for_transplant'] ?? 0) > 0) {
            $suggestions[] = [
                'icon' => '🌱',
                'category' => 'Transplanting',
                'message' => sprintf('%d seedling batches are ready for transplanting', $nursery['ready_for_transplant']),
                'priority' => 'medium',
                'action_label' => 'View Seedbed',
                'action_url' => '/seed-plantings',
            ];
        }

        // Financial suggestion
        $revenue = $sales['total_revenue'] ?? 0;
        $expenseTotal = $expenses['total_expenses'] ?? 0;
        if ($expenseTotal > $revenue && $revenue > 0) {
            $suggestions[] = [
                'icon' => '💰',
                'category' => 'Financial Review',
                'message' => 'Expenses exceed revenue. Review expense categories for optimization.',
                'priority' => 'medium',
                'action_label' => 'View Finances',
                'action_url' => '/reports/profit-loss',
            ];
        }

        // Failed planting suggestion
        if ($failureData && ($failureData['total_failed'] ?? 0) > 0) {
            $suggestions[] = [
                'icon'         => '💀',
                'category'     => 'Crop Failure',
                'message'      => sprintf(
                    '%d planting(s) failed this season. Total crop loss: ₱%s. Review causes to prevent recurrence.',
                    $failureData['total_failed'],
                    number_format($failureData['total_crop_loss_value'] ?? 0, 0)
                ),
                'priority'     => 'high',
                'action_label' => 'View Failed',
                'action_url'   => '/plantings?status=failed',
            ];
        }

        // Low stock suggestion
        if ($inventory && ($inventory['low_stock_count'] ?? 0) > 0) {
            $suggestions[] = [
                'icon' => '📦',
                'category' => 'Inventory',
                'message' => sprintf('%d item(s) below minimum stock level — restock needed', $inventory['low_stock_count']),
                'priority' => 'high',
                'action_label' => 'View Inventory',
                'action_url' => '/inventory',
            ];
        }

        // Expiring items suggestion
        if ($inventory && ($inventory['expiring_soon_count'] ?? 0) > 0) {
            $suggestions[] = [
                'icon' => '⏰',
                'category' => 'Inventory',
                'message' => sprintf('%d item(s) expiring within 30 days — use or dispose', $inventory['expiring_soon_count']),
                'priority' => 'high',
                'action_label' => 'Check Expiry',
                'action_url' => '/inventory',
            ];
        }

        // Pending tasks suggestion
        if (($tasks['pending_tasks'] ?? 0) > 5) {
            $suggestions[] = [
                'icon' => '📋',
                'category' => 'Planning',
                'message' => sprintf('%d pending tasks. Consider prioritizing or delegating.', $tasks['pending_tasks']),
                'priority' => 'low',
                'action_label' => 'Plan Tasks',
                'action_url' => '/tasks',
            ];
        }

        // Fallback suggestions if no issues exist
        if (empty($suggestions)) {
            $suggestions[] = [
                'icon' => '📊',
                'category' => 'Analytics',
                'message' => 'Review your farm performance and identify optimization opportunities.',
                'priority' => 'low',
                'action_label' => 'View Reports',
                'action_url' => '/reports/profit-loss',
            ];
            $suggestions[] = [
                'icon' => '🌾',
                'category' => 'Planning',
                'message' => 'Plan your next planting cycle for optimal yields.',
                'priority' => 'low',
                'action_label' => 'Start Planting',
                'action_url' => '/plantings',
            ];
            $suggestions[] = [
                'icon' => '📈',
                'category' => 'Marketplace',
                'message' => 'Manage your product listings and check orders.',
                'priority' => 'low',
                'action_label' => 'My Products',
                'action_url' => '/marketplace/my-products',
            ];
        }

        return array_slice($suggestions, 0, 4); // Max 4 suggestions
    }
}
