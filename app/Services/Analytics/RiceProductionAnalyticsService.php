<?php

namespace App\Services\Analytics;

use App\Models\Planting;
use App\Models\Field;
use App\Models\WeatherLog;
use App\Models\Task;
use Illuminate\Support\Collection;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;

class RiceProductionAnalyticsService
{
    /**
     * Base temperature for Rice GDD calculation (Scientific standard: 10°C)
     */
    const RICE_BASE_TEMP = 10;

    /**
     * Calculate Yield Gap (Gap II)
     * Difference between Potential Yield (Variety specific) and Actual Farm Yield.
     * 
     * @param Planting $planting
     * @return array
     */
    public function calculateYieldGap(Planting $planting): array
    {
        // 0. Validate rice variety reference exists
        if (!$planting->riceVariety) {
            Log::warning("Yield gap calculation skipped: Planting {$planting->id} missing rice variety reference", [
                'planting_id' => $planting->id,
                'field_id' => $planting->field_id,
                'rice_variety_id' => $planting->rice_variety_id,
            ]);
            
            return [
                'status' => 'incomplete_data',
                'message' => 'Rice variety not set for this planting',
                'actual_yield_ha' => 0,
                'potential_yield_ha' => 0,
                'gap_kg_ha' => 0,
                'gap_percentage' => 0,
                'planting_id' => $planting->id,
            ];
        }

        // 1. Get Actual Yield from Harvests
        $actualYield = $planting->harvests->sum('yield'); // in kg
        $actualYieldPerHa = $planting->area_planted > 0 ? $actualYield / $planting->area_planted : 0;

        // 2. Get Potential Yield from Variety
        // Use average_yield_per_hectare as the 'Attainable Potential'
        $potentialYieldPerHa = $planting->riceVariety->average_yield_per_hectare ?? 0;

        // If potential is not set or 0, return diagnostic information
        if ($potentialYieldPerHa <= 0) {
            Log::warning("Yield gap calculation incomplete: Variety {$planting->rice_variety_id} missing average yield", [
                'planting_id' => $planting->id,
                'variety_id' => $planting->rice_variety_id,
                'variety_name' => $planting->riceVariety->name,
            ]);
            
            return [
                'actual_yield_ha' => round($actualYieldPerHa, 2),
                'potential_yield_ha' => 0,
                'gap_kg_ha' => 0,
                'gap_percentage' => 0,
                'status' => 'unknown_potential',
                'message' => "Rice variety '{$planting->riceVariety->name}' does not have average yield data configured",
                'planting_id' => $planting->id,
            ];
        }

        // 3. Calculate Gap
        $gapPerHa = max(0, $potentialYieldPerHa - $actualYieldPerHa);
        $gapPercentage = ($potentialYieldPerHa > 0) ? ($gapPerHa / $potentialYieldPerHa) * 100 : 0;

        return [
            'status' => 'calculated',
            'actual_yield_ha' => round($actualYieldPerHa, 2),
            'potential_yield_ha' => round($potentialYieldPerHa, 2),
            'gap_kg_ha' => round($gapPerHa, 2),
            'gap_percentage' => round($gapPercentage, 1),
            'yield_performance' => $this->rateYieldPerformance($gapPercentage)
        ];
    }

    /**
     * Rate yield performance based on gap percentage
     */
    private function rateYieldPerformance($gapPercentage): string
    {
        if ($gapPercentage < 10)
            return 'excellent'; // < 10% gap
        if ($gapPercentage < 25)
            return 'good';      // < 25% gap
        if ($gapPercentage < 50)
            return 'fair';      // < 50% gap
        return 'poor';
    }

    /**
     * Track Growth Stages using Growing Degree Days (GDD)
     * Replaces simple calendar day tracking with thermal time.
     * 
     * @param Planting $planting
     * @return array
     */
    public function trackGrowthStages(Planting $planting): array
    {
        if (!$planting->planting_date) {
            return [];
        }

        $startDate = $planting->planting_date;
        $endDate = $planting->actual_harvest_date ?? now();

        // fetch weather logs for the farm (weather is now farm-level)
        $farmId = $planting->field->farm_id;
        $logs = WeatherLog::where('farm_id', $farmId)
            ->whereBetween('recorded_at', [$startDate, $endDate])
            ->get();

        $gddSum = 0;
        foreach ($logs as $log) {
            // Formula: [(Tmax + Tmin) / 2] - Tbase
            // Assuming 'temperature' is average, we might need max/min. 
            // If only avg is available: Avg - Tbase.
            // Let's assume weather_logs has temp_max/min, else fallback to temperature.
            $tMax = $log->temperature_max ?? $log->temperature;
            $tMin = $log->temperature_min ?? $log->temperature;

            $dailyGdd = (($tMax + $tMin) / 2) - self::RICE_BASE_TEMP;
            $gddSum += max(0, $dailyGdd);
        }

        // Define Thresholds (General Guidelines for Rice)
        // Vegetative: 0 - 1100
        // Reproductive: 1100 - 1700
        // Ripening: 1700+

        $estimatedStage = 'Unknown';
        if ($gddSum <= 1100) {
            $estimatedStage = 'Vegetative';
        } elseif ($gddSum <= 1700) {
            $estimatedStage = 'Reproductive';
        } elseif ($gddSum <= 2200) {
            $estimatedStage = 'Ripening';
        } else {
            $estimatedStage = 'Maturity';
        }

        return [
            'status' => 'ok',
            'accumulated_gdd' => round($gddSum, 1),
            'estimated_biological_stage' => $estimatedStage,
            'calendar_days' => $startDate->diffInDays($endDate),
            'is_delayed' => $this->isGrowthDelayed($planting, $gddSum),
            'records_count' => $logs->count()
        ];
    }

    private function isGrowthDelayed($planting, $gddSum): bool
    {
        // Simple heuristic check: if calendar days suggest late stage but GDD is low
        // This is complex, returning false for now as a placeholder
        return false;
    }

    /**
     * Calculate Fertilizer Use Efficiency (Partial Factor Productivity)
     * Formula: Total Yield (kg) / Total Fertilizer Applied (kg)
     * 
     * @param Planting $planting
     * @return array
     */
    public function calculateFertilizerEfficiency(Planting $planting): array
    {
        $totalYield = $planting->harvests->sum('yield');

        // Sum quantity of 'fertilizing' tasks
        $fertilizerTasks = Task::where('planting_id', $planting->id)
            ->where('task_type', Task::TYPE_FERTILIZING)
            ->get();

        $totalFertilizerKg = 0;
        foreach ($fertilizerTasks as $task) {
            // Check unit, assume kg if not specified or convert bags
            // This is a simplification. Ideally verify unit.
            $qty = $task->quantity ?? 0;
            $unit = strtolower($task->unit ?? 'kg');

            if ($unit === 'bag' || $unit === 'sack') {
                $qty *= 50; // Standard 50kg bag
            } elseif ($unit === 'gram' || $unit === 'g') {
                $qty /= 1000;
            }

            $totalFertilizerKg += $qty;
        }

        // Partial Factor Productivity (PFP)
        // Target: > 40 kg grain / kg fertilizer (rough proxy for N if mostly Urea/NPK)
        $pfp = ($totalFertilizerKg > 0) ? ($totalYield / $totalFertilizerKg) : 0;

        $rating = 'low';
        if ($pfp > 40) {
            $rating = 'good';
        } elseif ($pfp >= 20) {
            $rating = 'fair';
        }

        return [
            'status' => 'ok',
            'total_fertilizer_applied_kg' => $totalFertilizerKg,
            'pfp_efficiency' => round($pfp, 2),
            'rating' => $rating
        ];
    }

    /**
     * Get Field Performance Ranking
     * Aggregates efficiency metrics across all plantings for a specific field.
     * 
     * @param Field $field
     * @return array
     */
    public function getFieldPerformanceAnalytics(Field $field): array
    {
        $plantings = $field->plantings()->with(['harvests', 'riceVariety'])->get();

        if ($plantings->isEmpty()) {
            return ['status' => 'no_data'];
        }

        $avgYieldGap = 0;
        $avgPfp = 0;
        $count = 0;

        foreach ($plantings as $planting) {
            if ($planting->status === 'harvested') {
                $gap = $this->calculateYieldGap($planting);
                $eff = $this->calculateFertilizerEfficiency($planting);

                $avgYieldGap += $gap['gap_percentage'];
                $avgPfp += $eff['pfp_efficiency'];
                $count++;
            }
        }

        if ($count === 0)
            return ['status' => 'no_harvest_data'];

        return [
            'field_name' => $field->name,
            'average_yield_gap_pct' => round($avgYieldGap / $count, 1),
            'average_fertilizer_efficiency' => round($avgPfp / $count, 2),
            'productivity_score' => $field->productivity_score // Use existing model attribute
        ];
    }
}
