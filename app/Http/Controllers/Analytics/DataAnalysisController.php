<?php

namespace App\Http\Controllers\Analytics;

use App\Http\Controllers\Controller;
use App\Services\ReportService;
use App\Services\WeatherAnalyticsService;
use App\Services\PestPredictionService;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class DataAnalysisController extends Controller
{
    protected $reportService;
    protected $weatherAnalyticsService;
    protected $pestPredictionService;

    public function __construct(
        ReportService $reportService,
        WeatherAnalyticsService $weatherAnalyticsService,
        PestPredictionService $pestPredictionService
    ) {
        $this->reportService = $reportService;
        $this->weatherAnalyticsService = $weatherAnalyticsService;
        $this->pestPredictionService = $pestPredictionService;
    }

    /**
     * Get comprehensive data analysis with action suggestions
     * Delegating heavy logic to specialized Services.
     */
    public function getComprehensiveAnalytics(Request $request): JsonResponse
    {
        $user = $request->user();
        $farm = $user->farms()->first();

        // 1. Get Core Dashboard Analytics
        $dashboardData = $this->reportService->getDashboardAnalytics($user->id, $farm ? $farm->id : null);
        $financialSummary = $dashboardData['financial_summary'] ?? [];

        // 2. Map Financials to Frontend Contract (sales, expenses)
        // Frontend expects 'sales.total_revenue' and 'expenses.total_expenses' at root
        $salesData = [
            'total_revenue' => $financialSummary['total_revenue'] ?? 0,
            // Add other sales details if available from ReportService or mock them
            'total_sales_count' => $dashboardData['recent_activities'] ? count(array_filter($dashboardData['recent_activities'], fn($a) => $a['type'] === 'sale')) : 0
        ];

        $expensesData = [
            'total_expenses' => $financialSummary['total_expenses'] ?? 0,
            'by_category' => [] // ReportService might need asking for this if frontend charts need it
        ];

        // 3. Task Statistics (Frontend Requirement)
        // ReportService doesn't provide this granular task breakdown, so we calculate specific stats here.
        $taskStats = [
            'total_tasks' => 0,
            'completed_tasks' => 0,
            'pending_tasks' => 0,
            'overdue_tasks' => 0
        ];

        if ($farm) {
            // Get tasks for this farm's plantings
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

        $weatherTrends = [];
        $pestRisks = [];
        $weatherImpacts = [];

        if ($farm) {
            // Weather & Pest Analytics (Same as prior refactor)
            $weatherTrends = $this->weatherAnalyticsService->getFarmWeatherTrends($farm);

            foreach ($farm->fields as $field) {
                $fieldRisks = $this->pestPredictionService->predictRisks($field);
                if (!empty($fieldRisks)) {
                    $pestRisks[$field->name] = $fieldRisks;
                }
                $weatherImpacts[$field->name] = $this->weatherAnalyticsService->analyzeWeatherImpact($field);
            }
        }

        return response()->json([
            'overview' => $dashboardData['overview'] ?? [],
            'sales' => $salesData,      // Mapped for Frontend
            'expenses' => $expensesData, // Mapped for Frontend
            'tasks' => $taskStats,       // Calculated for Frontend
            'inventory' => [
                'summary' => $dashboardData['overview'] ?? [],
                'low_stock_alerts' => $dashboardData['low_stock_alerts'] ?? 0
            ],
            'weather_analytics' => [
                'trends' => $weatherTrends,
                'field_impacts' => $weatherImpacts
            ],
            'pest_risks' => $pestRisks,
            'recent_activities' => $dashboardData['recent_activities'] ?? [],
            'generated_at' => now(),
            'source' => 'Refactored Service Layer'
        ]);
    }
}
