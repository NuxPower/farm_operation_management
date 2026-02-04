<?php

namespace App\Services;

use App\Models\Field;
use App\Models\PestLibrary;
use App\Models\PestAnalyticsRule;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Cache;

class PestPredictionService
{
    protected $weatherService;

    public function __construct(WeatherService $weatherService)
    {
        $this->weatherService = $weatherService;
    }

    /**
     * Predict pest and disease risks for a field based on weather forecast
     *
     * @param Field $field
     * @return array
     */
    public function predictRisks(Field $field, $resolvedIncidents = []): array
    {
        // Get field coordinates
        $lat = $field->location['lat'] ?? $field->field_coordinates['lat'] ?? null;
        $lon = $field->location['lon'] ?? $field->field_coordinates['lon'] ?? null;

        if (!$lat || !$lon) {
            return [];
        }

        // Get 7-day forecast
        $forecast = $this->weatherService->getForecast((float) $lat, (float) $lon, 7);

        if (!$forecast || empty($forecast['list'])) {
            return [];
        }

        // Pre-fetch pest library with rules to avoid N+1 and repetitive validation queries
        // Cache this for performance as rules rarely change
        $pests = Cache::remember('active_pest_rules', now()->addHours(6), function () {
            return PestLibrary::with('rules')->get();
        });

        $predictions = [];

        foreach ($forecast['list'] as $day) {
            $risks = $this->analyzeDailyRisk($day, $pests);

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
    private function analyzeDailyRisk(array $day, $pests): array
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
                    $risks[] = [
                        'pest_name' => $pest->name,
                        'type' => ucfirst($pest->type),
                        'risk_level' => ucfirst($rule->risk_level),
                        'description' => $rule->risk_message,
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
}
