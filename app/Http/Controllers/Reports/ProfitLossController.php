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
        $startDate = $request->start_date ? Carbon::parse($request->start_date)->startOfDay() : now()->subYear()->startOfDay();
        $endDate = $request->end_date ? Carbon::parse($request->end_date)->endOfDay() : now()->endOfDay();

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

    public function byPlanting(Request $request): JsonResponse
    {
        $user = Auth::user();
        $farm = $user->farm;

        if (!$farm) {
            return response()->json(['message' => 'No farm found'], 404);
        }

        $startDate = $request->start_date ? Carbon::parse($request->start_date) : now()->subYear();
        $endDate = $request->end_date ? Carbon::parse($request->end_date) : now();
        
        // Calculate days for the service call, or modify service to accept dates
        $days = $startDate->diffInDays($endDate);

        // Using FinancialService generic analysis
        $plantings = $this->financialService->getPlantingProfitability($farm->id, $days);

        return response()->json([
            'plantings' => $plantings,
            'totals' => [
                'total_revenue' => collect($plantings)->sum('revenue'),
                'total_profit' => collect($plantings)->sum('net_profit')
            ]
        ]);
    }
}
