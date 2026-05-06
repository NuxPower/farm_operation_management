<?php

namespace App\Http\Controllers\Weather;

use App\Http\Controllers\Controller;
use App\Models\Farm;
use App\Models\Field;
use App\Models\WeatherLog;
use App\Services\WeatherService;
use App\Services\ColorfulCloudsWeatherService;
use App\Exceptions\WeatherServiceException;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Validator;

class WeatherController extends Controller
{
    private WeatherService $weatherService;
    private ColorfulCloudsWeatherService $colorfulCloudsService;

    public function __construct(WeatherService $weatherService, ColorfulCloudsWeatherService $colorfulCloudsService)
    {
        $this->weatherService = $weatherService;
        $this->colorfulCloudsService = $colorfulCloudsService;
    }

    /**
     * Get current weather for a farm
     */
    public function getCurrentWeather(Request $request, Farm $farm): JsonResponse
    {
        // Check if user can access this farm
        $user = $request->user();
        if ($farm->user_id !== $user->id) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        // Get coordinates from farm weather coordinates
        $coords = $farm->weather_coordinates;
        $lat = $coords['lat'] ?? null;
        $lon = $coords['lon'] ?? null;

        if ($lat === null || $lon === null) {
            return response()->json([
                'message' => 'Farm location coordinates are required'
            ], 400);
        }

        // First, check if we have a fresh weather log (within last 30 minutes)
        // This acts as a first-level cache using the database
        $recencyThreshold = now()->subMinutes(30);
        $recentLog = $farm->weatherLogs()
            ->where('recorded_at', '>=', $recencyThreshold)
            ->orderBy('recorded_at', 'desc')
            ->first();

        if ($recentLog) {
            // Use existing log
            $weatherLog = $recentLog;

            // Set relation for subsequent usage
            $farm->setRelation('latestWeather', $weatherLog);
        } else {
            // Fetch fresh data from service (which has its own cache)
            try {
                $weatherData = $this->weatherService->getCurrentWeather($lat, $lon);
            } catch (WeatherServiceException $e) {
                return response()->json([
                    'message' => $e->getMessage()
                ], 400);
            } catch (\Exception $e) {
                return response()->json([
                    'message' => 'Unable to fetch weather data: ' . $e->getMessage()
                ], 500);
            }

            if (!$weatherData || !isset($weatherData['main'])) {
                return response()->json([
                    'message' => 'Unable to fetch weather data'
                ], 500);
            }

            // Save weather data to database
            $weatherLog = $this->weatherService->updateFarmWeather($farm, $weatherData);

            if (!$weatherLog) {
                return response()->json([
                    'message' => 'Failed to store weather data'
                ], 500);
            }
        }

        return response()->json([
            'farm' => $farm,
            'weather' => $this->weatherService->formatWeatherLog($farm->latestWeather ?? $weatherLog),
            'alerts' => $this->weatherService->getWeatherAlerts($farm)
        ]);
    }

    /**
     * Get weather forecast for a farm
     */
    public function getForecast(Request $request, Farm $farm): JsonResponse
    {
        // Check if user can access this farm
        $user = $request->user();
        if ($farm->user_id !== $user->id) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        // Get coordinates from farm
        $coords = $farm->weather_coordinates;
        $lat = $coords['lat'] ?? null;
        $lon = $coords['lon'] ?? null;

        if ($lat === null || $lon === null) {
            return response()->json([
                'message' => 'Farm location coordinates are required'
            ], 400);
        }

        $days = $request->get('days', 7);
        if ($days > 14)
            $days = 14; // Limit to 14 days

        // Use ColorfulClouds for forecasts (supports up to 10 days, better than OpenWeatherMap's 5 days)
        // Request one extra day to ensure we get the full requested number (API might exclude today)
        try {
            $forecastData = $this->colorfulCloudsService->getForecast($lat, $lon, $days + 1, 'metric', 'en_US');

            if (empty($forecastData)) {
                // Fallback to OpenWeatherMap if ColorfulClouds fails
                $forecastData = $this->weatherService->getForecast($lat, $lon, $days);

                if (!$forecastData || !isset($forecastData['list'])) {
                    return response()->json([
                        'message' => 'Unable to fetch forecast data'
                    ], 500);
                }

                // Process OpenWeatherMap forecast data to daily format
                $dailyForecasts = $this->processForecastToDaily($forecastData['list'], $days);
            } else {
                // Process ColorfulClouds forecast data to daily format
                $dailyForecasts = $this->processColorfulCloudsForecast($forecastData, $days);
            }
        } catch (\Exception $e) {
            // Fallback to OpenWeatherMap on error
            $forecastData = $this->weatherService->getForecast($lat, $lon, $days);

            if (!$forecastData || !isset($forecastData['list'])) {
                return response()->json([
                    'message' => 'Unable to fetch forecast data: ' . $e->getMessage()
                ], 500);
            }

            $dailyForecasts = $this->processForecastToDaily($forecastData['list'], $days);
        }

        return response()->json([
            'farm' => $farm,
            'forecast' => $dailyForecasts
        ]);
    }

    /**
     * Get weather history for a farm
     */
    public function getHistory(Request $request, Farm $farm): JsonResponse
    {
        // Check if user can access this farm
        $user = $request->user();
        if ($farm->user_id !== $user->id) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $validator = Validator::make($request->all(), [
            'days' => 'integer|min:1|max:2000',
            'page' => 'integer|min:1',
            'per_page' => 'integer|min:1|max:5000'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }

        $days = (int) $request->get('days', 30);
        $perPage = (int) $request->get('per_page', 5000);

        $weatherLogs = WeatherLog::where('farm_id', $farm->id)
            ->where('recorded_at', '>=', now()->subDays($days))
            ->orderBy('recorded_at', 'desc')
            ->paginate($perPage);

        $stats = $this->weatherService->getFarmWeatherStats($farm, $days);

        return response()->json([
            'farm' => $farm,
            'weather_logs' => $weatherLogs,
            'stats' => $stats
        ]);
    }

    /**
     * Get weather alerts for a farm
     */
    public function getAlerts(Request $request, Farm $farm): JsonResponse
    {
        // Check if user can access this farm
        $user = $request->user();
        if ($farm->user_id !== $user->id) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $alerts = $this->weatherService->getWeatherAlerts($farm);

        return response()->json([
            'farm' => $farm,
            'alerts' => $alerts
        ]);
    }

    /**
     * Update weather data for a farm
     */
    public function updateWeather(Request $request, Farm $farm): JsonResponse
    {
        // Check if user can access this farm
        $user = $request->user();
        if ($farm->user_id !== $user->id) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $weatherLog = $this->weatherService->updateFarmWeather($farm);

        if (!$weatherLog) {
            return response()->json([
                'message' => 'Failed to update weather data'
            ], 500);
        }

        return response()->json([
            'message' => 'Weather data updated successfully',
            'farm' => $farm,
            'latest_weather' => $this->weatherService->formatWeatherLog($farm->latestWeather ?? $weatherLog),
            'alerts' => $this->weatherService->getWeatherAlerts($farm)
        ]);
    }

    /**
     * Update weather data for all user's farms
     */
    public function updateAllWeather(Request $request): JsonResponse
    {
        $user = $request->user();

        $farms = Farm::where('user_id', $user->id)->get();
        $updated = 0;

        foreach ($farms as $farm) {
            if ($this->weatherService->updateFarmWeather($farm)) {
                $updated++;
            }
        }

        return response()->json([
            'message' => "Weather data updated for {$updated} farms",
            'updated_count' => $updated
        ]);
    }

    /**
     * Get weather dashboard data
     */
    public function dashboard(Request $request): JsonResponse
    {
        $user = $request->user();

        $farms = Farm::where('user_id', $user->id)
            ->with(['latestWeather', 'fields'])
            ->get();

        $dashboardData = [
            'total_farms' => $farms->count(),
            'total_fields' => $farms->sum(fn($farm) => $farm->fields->count()),
            'farms_with_weather' => $farms->filter(fn($farm) => $farm->latestWeather)->count(),
            'weather_alerts' => [],
            'farm_weather' => []
        ];

        foreach ($farms as $farm) {
            if ($farm->latestWeather) {
                $alerts = $this->weatherService->getWeatherAlerts($farm);
                $dashboardData['weather_alerts'] = array_merge(
                    $dashboardData['weather_alerts'],
                    array_map(fn($alert) => array_merge($alert, ['farm' => $farm->name ?? "Farm {$farm->id}"]), $alerts)
                );

                $dashboardData['farm_weather'][] = [
                    'farm' => $farm,
                    'weather' => $this->weatherService->formatWeatherLog($farm->latestWeather),
                    'alerts_count' => count($alerts)
                ];
            }
        }

        return response()->json($dashboardData);
    }

    /**
     * Get rice-specific weather analytics for a farm
     */
    public function getRiceAnalytics(Request $request, Farm $farm): JsonResponse
    {
        // Check if user can access this farm
        $user = $request->user();
        if ($farm->user_id !== $user->id) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $validator = Validator::make($request->all(), [
            'days' => 'integer|min:1|max:365',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }

        $days = $request->get('days', 30);

        try {
            $analytics = $this->weatherService->getRiceWeatherAnalytics($farm, $days);
            $recommendations = $this->weatherService->getRiceFarmingRecommendations($farm);

            return response()->json([
                'farm' => $farm,
                'analytics' => $analytics,
                'recommendations' => $recommendations,
                'period_days' => $days
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to get rice weather analytics',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get rice farming dashboard with weather insights
     */
    public function getRiceDashboard(Request $request): JsonResponse
    {
        $user = $request->user();

        $fields = Field::where('user_id', $user->id)
            ->with(['farm.latestWeather', 'plantings.riceVariety'])
            ->get();

        $dashboardData = [
            'total_fields' => $fields->count(),
            'rice_fields' => 0,
            'active_plantings' => 0,
            'weather_alerts' => [],
            'rice_analytics_summary' => [
                'total_growing_degree_days' => 0,
                'heat_stress_fields' => 0,
                'optimal_conditions_fields' => 0,
                'disease_risk_fields' => 0,
            ],
            'field_details' => []
        ];

        foreach ($fields as $field) {
            $currentPlanting = $field->getCurrentRicePlanting();
            $isRiceField = $currentPlanting !== null;

            if ($isRiceField) {
                $dashboardData['rice_fields']++;
                $dashboardData['active_plantings']++;
            }

            // Access weather via farm
            $farm = $field->farm;
            if ($farm && $farm->latestWeather) {
                $alerts = $this->weatherService->getWeatherAlerts($farm);
                $riceAlerts = array_filter($alerts, fn($alert) => isset($alert['rice_specific']) && $alert['rice_specific']);

                $dashboardData['weather_alerts'] = array_merge(
                    $dashboardData['weather_alerts'],
                    array_map(fn($alert) => array_merge($alert, ['field' => $field->name ?? "Field {$field->id}"]), $riceAlerts)
                );

                // Get rice analytics for the field (using farm weather)
                if ($isRiceField) {
                    try {
                        $analytics = $this->weatherService->getRiceWeatherAnalytics($farm, 7);
                        if (isset($analytics['rice_analytics'])) {
                            $riceAnalytics = $analytics['rice_analytics'];

                            $dashboardData['rice_analytics_summary']['total_growing_degree_days'] += $riceAnalytics['growing_degree_days'] ?? 0;

                            if (($riceAnalytics['heat_stress_days'] ?? 0) > 0) {
                                $dashboardData['rice_analytics_summary']['heat_stress_fields']++;
                            }

                            if (($riceAnalytics['weather_suitability_score'] ?? 0) >= 70) {
                                $dashboardData['rice_analytics_summary']['optimal_conditions_fields']++;
                            }

                            if (($riceAnalytics['disease_risk_days'] ?? 0) > 2) {
                                $dashboardData['rice_analytics_summary']['disease_risk_fields']++;
                            }
                        }
                    } catch (\Exception $e) {
                        // Continue processing other fields if one fails
                    }
                }

                $dashboardData['field_details'][] = [
                    'field' => $field,
                    'weather' => $this->weatherService->formatWeatherLog($field->latestWeather),
                    'is_rice_field' => $isRiceField,
                    'current_planting' => $currentPlanting,
                    'alerts_count' => count($riceAlerts),
                    'critical_alerts' => count(array_filter($riceAlerts, fn($alert) => ($alert['severity'] ?? null) === 'critical')),
                ];
            }
        }

        return response()->json($dashboardData);
    }

    /**
     * Process forecast data from 3-hourly intervals to daily forecasts
     */
    private function processForecastToDaily(array $forecastList, int $days): array
    {
        $dailyForecasts = [];
        $today = \Carbon\Carbon::today('Asia/Manila');
        $todayStr = $today->format('Y-m-d');

        foreach ($forecastList as $forecast) {
            if (!isset($forecast['dt']) || !isset($forecast['main']) || !isset($forecast['weather'][0])) {
                continue;
            }

            // Use Carbon with Asia/Manila timezone to ensure consistent date comparison
            $forecastDate = \Carbon\Carbon::createFromTimestamp($forecast['dt'])
                ->setTimezone('Asia/Manila')
                ->format('Y-m-d');

            // Skip past dates - only include today and future dates
            if ($forecastDate < $todayStr) {
                continue;
            }

            if (!isset($dailyForecasts[$forecastDate])) {
                $dailyForecasts[$forecastDate] = [
                    'date' => $forecastDate,
                    'time' => $forecastDate,
                    'high' => PHP_FLOAT_MIN,
                    'low' => PHP_FLOAT_MAX,
                    'temperature_max' => PHP_FLOAT_MIN,
                    'temperature_min' => PHP_FLOAT_MAX,
                    'max_temp' => PHP_FLOAT_MIN,
                    'min_temp' => PHP_FLOAT_MAX,
                    'condition' => '',
                    'weather' => '',
                    'description' => '',
                    'weather_description' => '',
                    'rain_chance' => 0,
                    'precipitation_probability' => 0,
                    'precipitation_chance' => 0,
                    'wind_speed' => 0,
                    'wind' => 0,
                    'weather_code' => 0,
                    'code' => 0,
                    'humidity' => 0,
                    'icon' => '🌤️',
                    'count' => 0, // Track number of forecasts for this day
                    'hourly' => []
                ];
            }

            // Keep temperature in Celsius (API returns metric/Celsius)
            $tempC = $forecast['main']['temp'] ?? 0;
            $tempMaxInput = $forecast['main']['temp_max'] ?? $tempC;
            $tempMinInput = $forecast['main']['temp_min'] ?? $tempC;

            $dailyForecasts[$forecastDate]['high'] = max($dailyForecasts[$forecastDate]['high'], $tempMaxInput);
            $dailyForecasts[$forecastDate]['low'] = min($dailyForecasts[$forecastDate]['low'], $tempMinInput);
            $dailyForecasts[$forecastDate]['temperature_max'] = max($dailyForecasts[$forecastDate]['temperature_max'], $tempMaxInput);
            $dailyForecasts[$forecastDate]['temperature_min'] = min($dailyForecasts[$forecastDate]['temperature_min'], $tempMinInput);
            $dailyForecasts[$forecastDate]['max_temp'] = max($dailyForecasts[$forecastDate]['max_temp'], $tempMaxInput);
            $dailyForecasts[$forecastDate]['min_temp'] = min($dailyForecasts[$forecastDate]['min_temp'], $tempMinInput);

            // Preserve hourly data if available (from Open-Meteo service)
            if (isset($forecast['hourly'])) {
                $dailyForecasts[$forecastDate]['hourly'] = $forecast['hourly'];
            }

            // Calculate average temperature
            $dailyForecasts[$forecastDate]['temperature'] = ($dailyForecasts[$forecastDate]['high'] + $dailyForecasts[$forecastDate]['low']) / 2;

            // Collect conditions for finding the most representative one later
            if (!isset($dailyForecasts[$forecastDate]['conditions_list'])) {
                $dailyForecasts[$forecastDate]['conditions_list'] = [];
            }
            $dailyForecasts[$forecastDate]['conditions_list'][] = [
                'main' => $forecast['weather'][0]['main'] ?? 'Clear',
                'description' => $forecast['weather'][0]['description'] ?? 'Clear skies',
                'id' => $forecast['weather'][0]['id'] ?? 800
            ];

            // Weather code - prioritize worse weather
            // IDs: 2xx Thunderstorm, 3xx Drizzle, 5xx Rain, 6xx Snow, 7xx Atmos, 800 Clear, 80x Clouds
            $currentCode = $forecast['weather'][0]['id'] ?? 800;
            $existingCode = $dailyForecasts[$forecastDate]['weather_code'] ?? 0;

            // Logic to prioritize severe weather for the daily code/icon
            // If we don't have a code yet, take the current one
            if ($existingCode === 0) {
                $dailyForecasts[$forecastDate]['weather_code'] = $currentCode;
                $dailyForecasts[$forecastDate]['code'] = $currentCode;
            } else {
                // Priority: Thunderstorm (2xx) > Snow (6xx) > Rain (5xx) > Drizzle (3xx) > Atmosphere (7xx) > Clouds (80x) > Clear (800)
                // Simplify by checking ranges
                $isSevere = fn($c) => ($c >= 200 && $c < 700);

                if ($isSevere($currentCode) && !$isSevere($existingCode)) {
                    $dailyForecasts[$forecastDate]['weather_code'] = $currentCode;
                    $dailyForecasts[$forecastDate]['code'] = $currentCode;
                }
            }

            // Get max precipitation probability
            $pop = $forecast['pop'] ?? 0;
            $dailyForecasts[$forecastDate]['rain_chance'] = max($dailyForecasts[$forecastDate]['rain_chance'], $pop * 100);
            $dailyForecasts[$forecastDate]['precipitation_probability'] = max($dailyForecasts[$forecastDate]['precipitation_probability'], $pop * 100);
            $dailyForecasts[$forecastDate]['precipitation_chance'] = max($dailyForecasts[$forecastDate]['precipitation_chance'], $pop * 100);

            // Keep wind speed in m/s (can convert to km/h if needed, but keep metric)
            $windSpeed = $forecast['wind']['speed'] ?? 0; // m/s
            $dailyForecasts[$forecastDate]['wind_speed'] = max($dailyForecasts[$forecastDate]['wind_speed'], $windSpeed);
            $dailyForecasts[$forecastDate]['wind'] = max($dailyForecasts[$forecastDate]['wind'], $windSpeed);

            // Average humidity
            $humidity = $forecast['main']['humidity'] ?? 0;
            if ($dailyForecasts[$forecastDate]['humidity'] === 0) {
                $dailyForecasts[$forecastDate]['humidity'] = $humidity;
            } else {
                $dailyForecasts[$forecastDate]['humidity'] = ($dailyForecasts[$forecastDate]['humidity'] + $humidity) / 2;
            }

            $dailyForecasts[$forecastDate]['count']++;
        }

        // Post-process to set final daily condition based on accumulated data
        foreach ($dailyForecasts as &$day) {
            // If rain chance is high (>40%), force condition to Rain/Snow if not already
            $isRainy = $day['rain_chance'] > 40;

            // Find worst condition from list
            $worstCondition = null;
            $worstCode = 800;

            foreach ($day['conditions_list'] as $cond) {
                $code = $cond['id'];
                // Simple priority check: lower ID is generally worse in OWM (2xx storm, 3xx drizzle, 5xx rain)
                // Exception: 800 is clear, 80x is clouds. 7xx is fog etc.
                // We want to prioritize 2xx, 5xx, 6xx, 3xx.

                $score = 0;
                if ($code >= 200 && $code < 300)
                    $score = 10; // Thunderstorm
                elseif ($code >= 600 && $code < 700)
                    $score = 9; // Snow
                elseif ($code >= 500 && $code < 600)
                    $score = 8; // Rain
                elseif ($code >= 300 && $code < 400)
                    $score = 7; // Drizzle
                elseif ($code >= 700 && $code < 800)
                    $score = 6; // Fog/Mist
                elseif ($code > 800)
                    $score = 5; // Cloudy
                elseif ($code == 800)
                    $score = 1; // Clear

                if (!$worstCondition || $score > $worstCondition['score']) {
                    $worstCondition = $cond;
                    $worstCondition['score'] = $score;
                }
            }

            // If we have high rain chance but didn't pick up a rain condition (e.g. all intervals were cloudy but POP was high),
            // force it to Rain if we didn't find something worse (like Storm).
            if ($isRainy && ($worstCondition['score'] ?? 0) < 8) {
                $day['condition'] = 'Rain';
                $day['weather'] = 'Rain';
                $day['description'] = 'Rain expected';
                $day['weather_description'] = 'Rain expected';
            } else {
                $day['condition'] = $worstCondition['main'];
                $day['weather'] = $worstCondition['main'];
                $day['description'] = $worstCondition['description'];
                $day['weather_description'] = $worstCondition['description'];
            }

            // Consistency check: If condition is Rain/Storm, ensure rain_chance is non-zero
            // This handles cases where OWM returns condition 'Rain' but pop=0
            $conditionLower = strtolower($day['condition']);
            if ((str_contains($conditionLower, 'rain') || str_contains($conditionLower, 'storm')) && $day['rain_chance'] < 30) {
                $day['rain_chance'] = 30; // Set a minimum baseline if it's actually raining
                $day['precipitation_probability'] = 30;
                $day['precipitation_chance'] = 30;
            }

            // Cleanup separate list
            unset($day['conditions_list']);
        }
        unset($day); // break reference

        // Sort by date and get first N days (starting from today)
        ksort($dailyForecasts);
        $result = array_values($dailyForecasts);

        // Ensure we return exactly the requested number of days starting from today
        // Build result array ensuring we have exactly $days days starting from today
        $finalResult = [];
        $currentDate = clone $today;
        $resultIndex = 0;

        for ($i = 0; $i < $days; $i++) {
            $dateStr = $currentDate->format('Y-m-d');

            // Find matching forecast for this date from the processed results
            $found = false;
            for ($j = $resultIndex; $j < count($result); $j++) {
                if ($result[$j]['date'] === $dateStr) {
                    // Remove 'count' field before adding to result
                    unset($result[$j]['count']);
                    $finalResult[] = $result[$j];
                    $resultIndex = $j + 1; // Move index forward
                    $found = true;
                    break;
                }
            }

            // If no forecast found for this date, we've run out of API data
            // For a 7-day forecast, if API only provides 5-6 days, we'll return what we have
            // The frontend should handle displaying fewer days gracefully
            if (!$found) {
                // We've exhausted available forecast data
                // Return what we have rather than creating placeholder data
                break;
            }

            // Move to next day
            $currentDate->modify('+1 day');
        }

        // Return the days we have (should be at least what API provides, up to requested days)
        return $finalResult;
    }

    /**
     * Process ColorfulClouds forecast data to match frontend format
     */
    private function processColorfulCloudsForecast(array $forecastData, int $days): array
    {
        $dailyForecasts = [];
        $today = \Carbon\Carbon::today('Asia/Manila');
        $todayStr = $today->format('Y-m-d');

        // Map skycon to weather code for icon display
        $skyconToCode = [
            'CLEAR_DAY' => 800,
            'CLEAR_NIGHT' => 800,
            'PARTLY_CLOUDY_DAY' => 801,
            'PARTLY_CLOUDY_NIGHT' => 801,
            'CLOUDY' => 803,
            'LIGHT_HAZE' => 721,
            'MODERATE_HAZE' => 721,
            'HEAVY_HAZE' => 721,
            'LIGHT_RAIN' => 500,
            'MODERATE_RAIN' => 501,
            'HEAVY_RAIN' => 502,
            'STORM_RAIN' => 211,
            'LIGHT_SNOW' => 600,
            'MODERATE_SNOW' => 601,
            'HEAVY_SNOW' => 602,
            'STORM_SNOW' => 622,
            'DUST' => 731,
            'SAND' => 731,
            'WIND' => 771,
            'FOG' => 741,
        ];

        // Map condition to OpenWeatherMap-style condition
        $conditionMap = [
            'clear' => 'Clear',
            'partly_cloudy' => 'Partly Cloudy',
            'cloudy' => 'Cloudy',
            'haze' => 'Haze',
            'rain' => 'Rain',
            'storm' => 'Thunderstorm',
            'snow' => 'Snow',
            'dust' => 'Dust',
            'windy' => 'Windy',
            'fog' => 'Fog',
        ];

        // Process all forecast entries
        foreach ($forecastData as $forecast) {
            if (!isset($forecast['date'])) {
                continue;
            }

            $forecastDate = $forecast['date'];

            // Normalize date format - handle different formats
            if (strpos($forecastDate, ' ') !== false) {
                // If it's a datetime string, extract just the date part
                $forecastDate = date('Y-m-d', strtotime($forecastDate));
            }

            // Ensure we're working with Asia/Manila dates
            if (is_numeric($forecastDate) || strtotime($forecastDate)) {
                $forecastDate = \Carbon\Carbon::parse($forecastDate)
                    ->setTimezone('Asia/Manila')
                    ->format('Y-m-d');
            }

            // Skip past dates - only include today and future dates
            if ($forecastDate < $todayStr) {
                continue;
            }

            // Skip if we already have this date
            if (isset($dailyForecasts[$forecastDate])) {
                continue;
            }

            // Get skycon from conditions if available, or use default
            $skycon = 'CLEAR_DAY';
            if (isset($forecast['conditions'])) {
                // Reverse map condition to skycon for code lookup
                $condition = strtolower($forecast['conditions']);
                $skyconMap = [
                    'clear' => 'CLEAR_DAY',
                    'partly_cloudy' => 'PARTLY_CLOUDY_DAY',
                    'cloudy' => 'CLOUDY',
                    'haze' => 'LIGHT_HAZE',
                    'rain' => 'LIGHT_RAIN',
                    'storm' => 'STORM_RAIN',
                    'snow' => 'LIGHT_SNOW',
                    'dust' => 'DUST',
                    'windy' => 'WIND',
                    'fog' => 'FOG',
                ];
                $skycon = $skyconMap[$condition] ?? 'CLEAR_DAY';
            }

            $weatherCode = $skyconToCode[$skycon] ?? 800;
            $condition = $conditionMap[strtolower($forecast['conditions'] ?? 'clear')] ?? 'Clear';

            // Calculate rain chance from precipitation (simplified - ColorfulClouds doesn't provide probability)
            // Use precipitation amount as indicator (0-1mm = 0%, 1-5mm = 30%, 5-10mm = 60%, >10mm = 90%)
            $precipitation = $forecast['rain'] ?? 0;
            $rainChance = 0;
            if ($precipitation > 0) {
                if ($precipitation < 1) {
                    $rainChance = 20;
                } elseif ($precipitation < 5) {
                    $rainChance = 50;
                } elseif ($precipitation < 10) {
                    $rainChance = 70;
                } else {
                    $rainChance = 90;
                }
            }

            // Wind speed is in km/h from ColorfulClouds (metric unit)
            // Convert to m/s for consistency with OpenWeatherMap format (frontend will convert)
            $windSpeedKmh = $forecast['wind_speed'] ?? 0;
            $windSpeedMs = $windSpeedKmh / 3.6; // Convert km/h to m/s

            $dailyForecasts[$forecastDate] = [
                'date' => $forecastDate,
                'time' => $forecastDate,
                'high' => $forecast['temperature_high'] ?? $forecast['temperature'] ?? 0,
                'low' => $forecast['temperature_low'] ?? $forecast['temperature'] ?? 0,
                'temperature_max' => $forecast['temperature_high'] ?? $forecast['temperature'] ?? 0,
                'temperature_min' => $forecast['temperature_low'] ?? $forecast['temperature'] ?? 0,
                'max_temp' => $forecast['temperature_high'] ?? $forecast['temperature'] ?? 0,
                'min_temp' => $forecast['temperature_low'] ?? $forecast['temperature'] ?? 0,
                'condition' => $condition,
                'weather' => $condition,
                'description' => $forecast['description'] ?? 'Clear skies',
                'weather_description' => $forecast['description'] ?? 'Clear skies',
                'rain_chance' => $rainChance,
                'precipitation_probability' => $rainChance,
                'precipitation_chance' => $rainChance,
                'wind_speed' => $windSpeedMs, // m/s for consistency
                'wind' => $windSpeedMs,
                'weather_code' => $weatherCode,
                'code' => $weatherCode,
                'humidity' => $forecast['humidity'] ?? 0,
                'temperature' => $forecast['temperature'] ?? (($dailyForecasts[$forecastDate]['high'] + $dailyForecasts[$forecastDate]['low']) / 2),
            ];

            // Sanitize values to avoid frontend NaN issues
            if ($dailyForecasts[$forecastDate]['high'] === null)
                $dailyForecasts[$forecastDate]['high'] = 0;
            if ($dailyForecasts[$forecastDate]['low'] === null)
                $dailyForecasts[$forecastDate]['low'] = 0;
            if ($dailyForecasts[$forecastDate]['rain_chance'] === null)
                $dailyForecasts[$forecastDate]['rain_chance'] = 0;
            if ($dailyForecasts[$forecastDate]['wind_speed'] === null)
                $dailyForecasts[$forecastDate]['wind_speed'] = 0;
        }

        // Sort by date
        ksort($dailyForecasts);
        $result = array_values($dailyForecasts);

        // Build final result ensuring exactly $days starting from today
        // ColorfulClouds might not include today, so we need to handle that
        $finalResult = [];
        $currentDate = $today->copy();
        $hasToday = false;

        // Check if today is in the results
        foreach ($result as $forecast) {
            if ($forecast['date'] === $todayStr) {
                $hasToday = true;
                break;
            }
        }

        // If today is not in results and we have data, the API might start from tomorrow
        // In that case, we'll use the first available day as "today" or start from the first day
        $startIndex = 0;
        if (!$hasToday && count($result) > 0) {
            // Check if first result is tomorrow
            $firstDate = \Carbon\Carbon::parse($result[0]['date']);
            $tomorrow = $today->copy();
            $tomorrow->addDay();

            if ($firstDate->format('Y-m-d') === $tomorrow->format('Y-m-d')) {
                // API starts from tomorrow, so we have tomorrow + 6 more days = 7 days total
                // But we want today + 6 future days, so we need to add today
                // For now, let's use the first day as day 1 and continue
                $startIndex = 0;
            }
        }

        // Build result array starting from today
        // First, try to match dates exactly
        $usedIndices = [];
        for ($i = 0; $i < $days; $i++) {
            $dateStr = $currentDate->format('Y-m-d');
            $found = false;

            // Find matching forecast for this date (skip already used ones)
            for ($j = 0; $j < count($result); $j++) {
                if (in_array($j, $usedIndices)) {
                    continue;
                }

                if ($result[$j]['date'] === $dateStr) {
                    $finalResult[] = $result[$j];
                    $usedIndices[] = $j;
                    $found = true;
                    break;
                }
            }

            // If not found and this is today, try to use first available forecast as today
            if (!$found && $i === 0 && count($result) > 0 && !in_array(0, $usedIndices)) {
                // Use first forecast as today if API doesn't include today
                $firstForecast = $result[0];
                $firstForecast['date'] = $dateStr;
                $firstForecast['time'] = $dateStr;
                $finalResult[] = $firstForecast;
                $usedIndices[] = 0;
                $found = true;
            }

            // If still not found, try to use next available forecast
            if (!$found && count($result) > count($usedIndices)) {
                // Find next unused forecast
                for ($j = 0; $j < count($result); $j++) {
                    if (!in_array($j, $usedIndices)) {
                        $nextForecast = $result[$j];
                        $nextForecast['date'] = $dateStr;
                        $nextForecast['time'] = $dateStr;
                        $finalResult[] = $nextForecast;
                        $usedIndices[] = $j;
                        $found = true;
                        break;
                    }
                }
            }

            // If still not found, we've run out of data - use last available forecast
            if (!$found && count($result) > 0) {
                $lastForecast = end($result);
                $lastForecast['date'] = $dateStr;
                $lastForecast['time'] = $dateStr;
                $finalResult[] = $lastForecast;
            }

            // Move to next day
            $currentDate->addDay();
        }

        // Ensure we have exactly $days
        return array_slice($finalResult, 0, $days);
    }
}