<?php

namespace App\Http\Controllers\Analytics;

use App\Http\Controllers\Controller;
use App\Services\ReportService;
use App\Services\FinancialService;
use App\Services\WeatherAnalyticsService;
use App\Services\PestPredictionService;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Models\Task;
use App\Models\Field;
use App\Models\Planting;
use App\Models\SeedPlanting;
use App\Models\PestIncident;
use App\Models\WeatherLog;
use App\Models\Laborer;
use App\Models\LaborWage;
use Carbon\Carbon;

class DataAnalysisController extends Controller
{
    protected $reportService;
    protected $financialService;
    protected $weatherAnalyticsService;
    protected $pestPredictionService;

    public function __construct(
        ReportService $reportService,
        FinancialService $financialService,
        WeatherAnalyticsService $weatherAnalyticsService,
        PestPredictionService $pestPredictionService
    ) {
        $this->reportService = $reportService;
        $this->financialService = $financialService;
        $this->weatherAnalyticsService = $weatherAnalyticsService;
        $this->pestPredictionService = $pestPredictionService;
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

        // 2. Sales Data
        $salesData = [
            'total_revenue' => $financialSummary['total_revenue'] ?? 0,
            'total_orders' => $dashboardData['recent_activities'] ? count(array_filter($dashboardData['recent_activities'], fn($a) => $a['type'] === 'sale')) : 0,
            'pending_orders' => 0, // Would need separate calculation
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
            $taskStats['total_tasks'] = Task::whereHas('planting.field', function ($q) use ($farm) {
                $q->where('farm_id', $farm->id);
            })->count();

            $taskStats['completed_tasks'] = Task::whereHas('planting.field', function ($q) use ($farm) {
                $q->where('farm_id', $farm->id);
            })->where('status', Task::STATUS_COMPLETED)->count();

            $taskStats['pending_tasks'] = Task::whereHas('planting.field', function ($q) use ($farm) {
                $q->where('farm_id', $farm->id);
            })->where('status', Task::STATUS_PENDING)->count();

            $taskStats['overdue_tasks'] = Task::whereHas('planting.field', function ($q) use ($farm) {
                $q->where('farm_id', $farm->id);
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

        if ($farm) {
            $fieldIds = $farm->fields->pluck('id');
            $recentWeather = WeatherLog::whereIn('field_id', $fieldIds)
                ->where('recorded_at', '>=', now()->subDays(7))
                ->get();

            if ($recentWeather->isNotEmpty()) {
                $weatherData = [
                    'avg_temperature' => round($recentWeather->avg('temperature'), 1),
                    'total_rainfall' => round($recentWeather->sum('rainfall'), 1),
                    'avg_humidity' => round($recentWeather->avg('humidity'), 1),
                ];
            }
        }

        // 6. Fields Data
        $fieldsData = [
            'total_area' => 0,
            'utilization_rate' => 0,
        ];

        if ($farm) {
            $totalArea = $farm->fields->sum('size_hectares');
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

        // 8. Pest Incidents Data
        $pestsData = [
            'total_incidents' => 0,
            'active_incidents' => 0,
            'forecasts' => [],
        ];

        if ($farm) {
            $plantingIds = Planting::whereHas('field', function ($q) use ($farm) {
                $q->where('farm_id', $farm->id);
            })->pluck('id');

            $pestsData['total_incidents'] = PestIncident::whereIn('planting_id', $plantingIds)->count();
            $pestsData['active_incidents'] = PestIncident::whereIn('planting_id', $plantingIds)->active()->count();

            // Add pest forecasts from prediction service
            $forecasts = [];
            foreach ($farm->fields as $field) {
                $fieldRisks = $this->pestPredictionService->predictRisks($field);
                if (!empty($fieldRisks)) {
                    $forecasts[] = [
                        'field_name' => $field->name,
                        'predictions' => $fieldRisks,
                    ];
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

        // 11. Inventory Data
        $inventoryData = [
            'total_value' => $dashboardData['overview']['total_inventory_value'] ?? 0,
            'historical_usage' => [
                'total_consumed' => 0,
                'most_consumed_item' => null,
            ],
        ];

        // 12. Executive Summary & Action Suggestions (Generated)
        $executiveSummary = $this->generateExecutiveSummary($salesData, $expensesData, $taskStats, $pestsData);
        $actionSuggestions = $this->generateActionSuggestions($taskStats, $salesData, $expensesData, $pestsData, $nurseryData);

        return response()->json([
            'executive_summary' => $executiveSummary,
            'action_suggestions' => $actionSuggestions,
            'weather' => $weatherData,
            'sales' => $salesData,
            'expenses' => $expensesData,
            'tasks' => $taskStats,
            'fields' => $fieldsData,
            'nursery' => $nurseryData,
            'pests' => $pestsData,
            'laborers' => $laborersData,
            'inventory' => $inventoryData,
            'financial_forecast' => $financialForecast,
            'generated_at' => now(),
        ]);
    }

    /**
     * Generate an executive summary based on analytics data
     */
    private function generateExecutiveSummary($sales, $expenses, $tasks, $pests): array
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

        return [
            'tone' => $tone,
            'text' => $text,
        ];
    }

    /**
     * Generate action suggestions based on analytics data
     */
    private function generateActionSuggestions($tasks, $sales, $expenses, $pests, $nursery): array
    {
        $suggestions = [];

        // Overdue tasks suggestion
        if (($tasks['overdue_tasks'] ?? 0) > 0) {
            $suggestions[] = [
                'icon' => '⚠️',
                'category' => 'Task Management',
                'message' => sprintf('%d overdue tasks need immediate attention', $tasks['overdue_tasks']),
                'priority' => 'high',
                'action_label' => 'View Tasks',
                'action_url' => '/rice-farming/tasks',
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
                'action_url' => '/rice-farming/pest-control',
            ];
        }

        // Nursery suggestion
        if (($nursery['ready_for_transplant'] ?? 0) > 0) {
            $suggestions[] = [
                'icon' => '🌱',
                'category' => 'Transplanting',
                'message' => sprintf('%d seedling batches are ready for transplanting', $nursery['ready_for_transplant']),
                'priority' => 'medium',
                'action_label' => 'View Nursery',
                'action_url' => '/rice-farming/nursery',
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

        // Pending tasks suggestion
        if (($tasks['pending_tasks'] ?? 0) > 5) {
            $suggestions[] = [
                'icon' => '📋',
                'category' => 'Planning',
                'message' => sprintf('%d pending tasks. Consider prioritizing or delegating.', $tasks['pending_tasks']),
                'priority' => 'low',
                'action_label' => 'Plan Tasks',
                'action_url' => '/rice-farming/tasks',
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
                'action_url' => '/rice-farming/lifecycle',
            ];
            $suggestions[] = [
                'icon' => '📈',
                'category' => 'Marketplace',
                'message' => 'Check marketplace trends and pricing for your products.',
                'priority' => 'low',
                'action_label' => 'Visit Marketplace',
                'action_url' => '/marketplace',
            ];
        }

        return array_slice($suggestions, 0, 4); // Max 4 suggestions
    }
}
