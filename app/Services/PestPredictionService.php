<?php

namespace App\Services;

use App\Models\Farm;
use App\Models\Planting;
use App\Models\PestLibrary;
use App\Models\PestAnalyticsRule;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Cache;
use Carbon\Carbon;

class PestPredictionService
{
    protected $weatherService;

    public function __construct(WeatherService $weatherService)
    {
        $this->weatherService = $weatherService;
    }

    /**
     * Predict pest and disease risks for a farm based on weather forecast
     *
     * @param Farm $farm
     * @return array
     */
    public function predictRisks(Farm $farm, $resolvedIncidents = [], ?Planting $planting = null): array
    {
        // Get farm coordinates
        $coords = $farm->weather_coordinates;
        $lat = $coords['lat'] ?? null;
        $lon = $coords['lon'] ?? null;

        if (!$lat || !$lon) {
            return [];
        }

        // Get 7-day forecast (cache for 30 min, because far fewer calls improves API usage)
        $cacheKey = sprintf('pest_forecast_%s_%s', round($lat, 5), round($lon, 5));
        $forecast = Cache::remember($cacheKey, now()->addMinutes(30), function () use ($lat, $lon) {
            return $this->weatherService->getForecast((float) $lat, (float) $lon, 7);
        });

        if (!$forecast || empty($forecast['list'])) {
            Log::warning('Pest prediction skipped due to missing forecast data', ['lat' => $lat, 'lon' => $lon]);
            return [];
        }

        // Pre-fetch pest library with rules to avoid N+1 and repetitive validation queries
        // Cache this for performance as rules rarely change
        $pests = Cache::remember('active_pest_rules', now()->addHours(6), function () {
            return PestLibrary::with('rules')->get();
        });

        // Calculate growth stage from planting if available
        $growthStage = null;
        if ($planting && $planting->planting_date) {
            $daysPlanted = Carbon::parse($planting->planting_date)->diffInDays(now());
            $growthStage = $this->getGrowthStage($daysPlanted);
        }

        $predictions = [];

        foreach ($forecast['list'] as $day) {
            $risks = $this->analyzeDailyRisk($day, $pests, $growthStage);

            // Filter out resolved risks
            $risks = array_filter($risks, function ($risk) use ($resolvedIncidents) {
                foreach ($resolvedIncidents as $incident) {
                    // Match by exact pest name or similar pest type
                    if (
                        strcasecmp($incident->pest_name, $risk['pest_name']) === 0 ||
                        (strcasecmp($incident->pest_type, $risk['type']) === 0 && abs(now()->diffInDays($incident->updated_at)) < 7)
                    ) {
                        return false; // This risk is already resolved recently
                    }
                }
                return true;
            });

            if (!empty($risks)) {
                $predictions[] = [
                    'date' => date('Y-m-d', $day['dt']),
                    'day_name' => date('l', $day['dt']),
                    'weather_summary' => [
                        'temp' => round($day['main']['temp'], 1),
                        'humidity' => $day['main']['humidity'],
                        'condition' => $day['weather'][0]['main'] ?? 'Clear'
                    ],
                    'risks' => array_values($risks) // Re-index array
                ];
            }
        }

        return $predictions;
    }

    /**
     * Analyze weather conditions for a single day against database rules
     */
    private function analyzeDailyRisk(array $day, $pests, ?string $growthStage = null): array
    {
        $risks = [];
        $temp = $day['main']['temp'];
        $humidity = $day['main']['humidity'];
        $condition = strtolower($day['weather'][0]['main'] ?? '');
        $rainProb = $day['pop'] ?? 0;
        $windSpeed = $day['wind']['speed'] ?? 0;

        // Calculate derived metrics
        $isRainy = in_array($condition, ['rainy', 'stormy']) || $rainProb > 0.5;
        $rainfall = $day['rain'] ?? 0; // Simplified
        $lunarPhase = $this->getLunarPhase($day['dt']);

        foreach ($pests as $pest) {
            // Growth stage filtering: skip pests not relevant to current stage
            if ($growthStage && !empty($pest->vulnerable_stages)) {
                if (!in_array($growthStage, $pest->vulnerable_stages)) {
                    continue;
                }
            }

            // Check each rule for this pest
            foreach ($pest->rules as $rule) {
                $triggered = false;

                switch ($rule->metric) {
                    case 'temperature':
                        $triggered = $this->checkCondition($temp, $rule);
                        break;
                    case 'humidity':
                        $triggered = $this->checkCondition($humidity, $rule);
                        break;
                    case 'rainfall':
                        // If rule expects rainfall > X, check if it's rainy or using Pop
                        if ($rule->condition === '>' && $rule->value_min > 0) {
                            $triggered = $isRainy; // Simplify since precise mm forecast might be unavailable or tricky
                        }
                        break;
                    case 'wind_speed':
                        $triggered = $this->checkCondition($windSpeed, $rule);
                        break;
                    case 'lunar_phase':
                        if ($rule->condition === 'equals' && $lunarPhase === 'Full Moon') {
                            $triggered = true;
                        }
                        break;
                }

                if ($triggered) {
                    // Build description with stage context
                    $description = $rule->risk_message;
                    $stageNote = null;
                    if ($growthStage && $rule->stage_note) {
                        $stageNote = $rule->stage_note;
                        $description .= ' ⚠️ ' . $rule->stage_note;
                    }

                    $risks[] = [
                        'pest_name' => $pest->name,
                        'type' => ucfirst($pest->type),
                        'risk_level' => ucfirst($rule->risk_level),
                        'description' => $description,
                        'stage_note' => $stageNote,
                        'recommendation' => $pest->treatment_guidance ?? 'Monitor field closely.',
                        'image' => $pest->images[0] ?? null
                    ];
                }
            }
        }

        return $risks;
    }

    /**
     * Helper to evaluate numerical rules
     */
    private function checkCondition($value, $rule): bool
    {
        switch ($rule->condition) {
            case '>':
                return $value > $rule->value_min;
            case '<':
                return $value < $rule->value_max;
            case 'between':
                return $value >= $rule->value_min && $value <= $rule->value_max;
            case 'equals':
                return $value == $rule->value_min;
            default:
                return false;
        }
    }

    /**
     * Calculate approximate lunar phase
     * Returns 'New Moon', 'First Quarter', 'Full Moon', 'Last Quarter', or 'Intermediate'
     */
    private function getLunarPhase($timestamp): string
    {
        $year = date('Y', $timestamp);
        $month = date('n', $timestamp);
        $day = date('j', $timestamp);

        // Simple calculation for moon age (0-29.53)
        // This is an approximation.
        $c = $e = $jd = $b = 0;
        if ($month < 3) {
            $year--;
            $month += 12;
        }
        ++$month;
        $c = 365.25 * $year;
        $e = 30.6 * $month;
        $jd = $c + $e + $day - 694039.09; // jd is total days elapsed
        $jd /= 29.5305882; // Divide by lunar cycle
        $b = (int) $jd; // Integer part
        $jd -= $b; // Fractional part
        $b = round($jd * 8); // Scale to 0-8

        if ($b >= 8)
            $b = 0; // 0 and 8 are New Moon

        switch ($b) {
            case 0:
                return 'New Moon';
            case 2:
                return 'First Quarter';
            case 4:
                return 'Full Moon';
            case 6:
                return 'Last Quarter';
            default:
                // Creating a +/- window for Full Moon as per RBB requirement
                // If it's close to 4 (Full Moon), we can consider it conducive
                if ($b === 3 || $b === 5)
                    return 'Full Moon'; // Broaden definition for RBB (Waxing/Waning Gibbous close to full)
                return 'Intermediate';
        }

        return 'Intermediate';
    }

    /**
     * Determine growth stage from days since planting
     */
    public function getGrowthStage(int $days): string
    {
        if ($days <= 45)
            return 'vegetative';
        if ($days <= 75)
            return 'reproductive';
        return 'ripening';
    }
}
