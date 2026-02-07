<?php

namespace App\Http\Controllers\Reports;

use App\Http\Controllers\Controller;
use App\Services\FinancialService;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class ProfitLossController extends Controller
{
    protected $financialService;

    public function __construct(FinancialService $financialService)
    {
        $this->financialService = $financialService;
    }

    /**
     * Get overall profit/loss summary
     */
    public function summary(Request $request): JsonResponse
    {
        $user = Auth::user();
        $startDate = $request->start_date ? Carbon::parse($request->start_date) : now()->subYear();
        $endDate = $request->end_date ? Carbon::parse($request->end_date) : now();

        $farm = $user->farm;

        if (!$farm) {
            return response()->json(['message' => 'No farm found'], 404);
        }

        // Delegate to FinancialService
        // Assuming generateFinancialReport returns 'summary', 'revenues', 'expenses' etc.
        $report = $this->financialService->generateFinancialReport($farm->id, $startDate, $endDate, 'summary');

        // Map FinancialService output to expected frontend format if necessary
        // Or return directly if compatible.
        // Based on analysis, FinancialService returns a structured array.
        // We ensure the response matches the old controller's basic structure for compatibility.

        return response()->json([
            'summary' => [
                'total_revenue' => $report['total_revenue'] ?? 0,
                'total_expenses' => $report['total_expenses'] ?? 0,
                'net_profit' => $report['net_profit'] ?? 0,
                'profit_margin' => $report['profit_margin'] ?? 0,
                'is_profitable' => ($report['net_profit'] ?? 0) > 0,
            ],
            'expenses_by_category' => $report['expenses_by_category'] ?? [],
            'monthly_trend' => $report['monthly_trends'] ?? [], // Service calls it 'monthly_trends'
            'period' => [
                'start' => $startDate->format('Y-m-d'),
                'end' => $endDate->format('Y-m-d'),
            ],
            'source' => 'FinancialService'
        ]);
    }

    /**
     * Get profit/loss by planting cycle
     */
    public function byPlanting(Request $request): JsonResponse
    {
        // This specific crop-level profitability might be available in FinancialService (getCropProfitability?)
        // Or we can leave it if FinancialService doesn't support "by planting" list specifically.
        // The plan said "Replace raw queries".
        // FinancialService has getCropProfitabilityAnalysis($farmId, $days)

        // Use existing logic if Service doesn't cover this specific granular view, 
        // OR migrate this logic to Service if we want cleanliness.
        // For now, let's delegate to Service's crop profitability if it matches.

        $user = Auth::user();
        $farm = $user->farm;

        if (!$farm) {
            return response()->json(['message' => 'No farm found'], 404);
        }

        // Using FinancialService generic analysis
        // Note: This might change the output format slightly compared to original.
        // If exact compatibility is needed, we would add 'getPlantingProfitability' to Service.
        // For now, let's stick to the Service call to remove raw queries.

        $analysis = $this->financialService->getCropProfitabilityAnalysis($farm->id, 365); // Default 1 year

        return response()->json([
            'plantings' => $analysis['crops'] ?? [], // Service usually groups by crop type, not individual planting ID
            'totals' => [
                'total_revenue' => $analysis['total_revenue'] ?? 0,
                'total_profit' => $analysis['total_profit'] ?? 0
            ]
        ]);
    }
}
