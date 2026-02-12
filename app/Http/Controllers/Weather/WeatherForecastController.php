<?php

namespace App\Http\Controllers\Weather;

use App\Http\Controllers\Controller;
use App\Services\WeatherService;
use App\Services\WeatherForecastService;
use App\Models\Field;
use App\Models\Farm;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class WeatherForecastController extends Controller
{
    protected $weatherService;
    protected $forecastService;

    public function __construct(WeatherService $weatherService, WeatherForecastService $forecastService)
    {
        $this->weatherService = $weatherService;
        $this->forecastService = $forecastService;
    }

    /**
     * Get weather forecast for a field
     */
    /**
     * Get weather forecast for a farm
     */
    public function getForecast(Request $request, $farmId)
    {
        $request->validate([
            'days' => 'integer|min:1|max:14',
            'forecast_type' => 'in:basic,detailed,agricultural',
        ]);

        $farm = Farm::findOrFail($farmId);
        $this->authorize('view', $farm);

        $days = $request->days ?? 7;
        $forecastType = $request->forecast_type ?? 'basic';

        $forecast = $this->forecastService->getForecast($farm, $days, $forecastType);

        return response()->json([
            'farm' => $farm,
            'forecast' => $forecast,
            'forecast_type' => $forecastType,
            'days' => $days,
        ]);
    }

    /**
     * Get extended weather forecast
     */
    /**
     * Get extended weather forecast
     */
    public function getExtendedForecast(Request $request, $farmId)
    {
        $request->validate([
            'period' => 'in:weekly,monthly,seasonal',
        ]);

        $farm = Farm::findOrFail($farmId);
        $this->authorize('view', $farm);

        $period = $request->period ?? 'weekly';
        $forecast = $this->forecastService->getExtendedForecast($farm, $period);

        return response()->json([
            'farm' => $farm,
            'extended_forecast' => $forecast,
            'period' => $period,
        ]);
    }

    /**
     * Get agricultural weather forecast
     */
    /**
     * Get agricultural weather forecast
     */
    public function getAgriculturalForecast(Request $request, $farmId)
    {
        $farm = Farm::findOrFail($farmId);
        $this->authorize('view', $farm);

        $forecast = $this->forecastService->getAgriculturalForecast($farm);

        return response()->json([
            'farm' => $farm,
            'agricultural_forecast' => $forecast,
        ]);
    }

    /**
     * Get weather alerts and warnings
     */
    /**
     * Get weather alerts and warnings
     */
    public function getWeatherAlerts(Request $request, $farmId)
    {
        $farm = Farm::findOrFail($farmId);
        $this->authorize('view', $farm);

        $alerts = $this->forecastService->getWeatherAlerts($farm);
        $currentAlerts = $this->weatherService->getWeatherAlerts($farm);

        return response()->json([
            'farm' => $farm,
            'current_alerts' => $currentAlerts,
            'forecast_alerts' => $alerts,
        ]);
    }

    /**
     * Get farm-wide weather forecast
     */
    // getFarmForecast replaced by getForecast above or removed as duplicate

    /**
     * Get weather-based activity recommendations
     */
    /**
     * Get weather-based activity recommendations
     */
    public function getActivityRecommendations(Request $request, $farmId)
    {
        $farm = Farm::findOrFail($farmId);
        $this->authorize('view', $farm);

        $recommendations = $this->forecastService->getActivityRecommendations($farm);

        return response()->json([
            'farm' => $farm,
            'activity_recommendations' => $recommendations,
        ]);
    }

    /**
     * Get optimal timing for farm activities
     */
    /**
     * Get optimal timing for farm activities
     */
    public function getOptimalTiming(Request $request, $farmId)
    {
        $request->validate([
            'activity_type' => 'required|in:planting,harvesting,spraying,fertilizing,irrigation',
            'planning_days' => 'integer|min:1|max:30',
        ]);

        $farm = Farm::findOrFail($farmId);
        $this->authorize('view', $farm);

        $activityType = $request->activity_type;
        $planningDays = $request->planning_days ?? 14;

        $timing = $this->forecastService->getOptimalTiming($farm, $activityType, $planningDays);

        return response()->json([
            'farm' => $farm,
            'activity_type' => $activityType,
            'optimal_timing' => $timing,
            'planning_days' => $planningDays,
        ]);
    }

    /**
     * Get weather-based crop protection recommendations
     */
    /**
     * Get weather-based crop protection recommendations
     */
    public function getCropProtectionForecast(Request $request, $farmId)
    {
        $farm = Farm::findOrFail($farmId);
        $this->authorize('view', $farm);

        $protection = $this->forecastService->getCropProtectionForecast($farm);

        return response()->json([
            'farm' => $farm,
            'crop_protection_forecast' => $protection,
        ]);
    }

    /**
     * Get seasonal weather outlook
     */
    public function getSeasonalOutlook(Request $request, $farmId)
    {
        $request->validate([
            'season' => 'in:spring,summer,autumn,winter,dry,wet',
            'months_ahead' => 'integer|min:1|max:6',
        ]);

        $farm = Farm::findOrFail($farmId);
        $this->authorize('view', $farm);

        $season = $request->season;
        $monthsAhead = $request->months_ahead ?? 3;

        $outlook = $this->forecastService->getSeasonalOutlook($farm, $season, $monthsAhead);

        return response()->json([
            'farm' => $farm,
            'seasonal_outlook' => $outlook,
            'season' => $season,
            'months_ahead' => $monthsAhead,
        ]);
    }

    /**
     * Subscribe to weather alerts
     */
    /**
     * Subscribe to weather alerts
     */
    public function subscribeToAlerts(Request $request, $farmId)
    {
        $request->validate([
            'alert_types' => 'required|array',
            'alert_types.*' => 'in:temperature,humidity,wind,precipitation,severe_weather',
            'notification_methods' => 'required|array',
            'notification_methods.*' => 'in:email,sms,push',
            'thresholds' => 'nullable|array',
        ]);

        $farm = Farm::findOrFail($farmId);
        $this->authorize('update', $farm);

        $subscription = $this->forecastService->subscribeToAlerts(
            $farm,
            $request->alert_types,
            $request->notification_methods,
            $request->thresholds ?? []
        );

        return response()->json([
            'message' => 'Successfully subscribed to weather alerts',
            'subscription' => $subscription,
        ]);
    }

    /**
     * Get weather forecast accuracy metrics
     */
    /**
     * Get weather forecast accuracy metrics
     */
    public function getForecastAccuracy(Request $request, $farmId)
    {
        $request->validate([
            'period_days' => 'integer|min:7|max:90',
        ]);

        $farm = Farm::findOrFail($farmId);
        $this->authorize('view', $farm);

        $periodDays = $request->period_days ?? 30;
        $accuracy = $this->forecastService->getForecastAccuracy($farm, $periodDays);

        return response()->json([
            'farm' => $farm,
            'forecast_accuracy' => $accuracy,
            'period_days' => $periodDays,
        ]);
    }
}