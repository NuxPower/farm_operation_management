<?php

namespace App\Services\Traits;

use App\Models\Farm;
use App\Models\Planting;
use App\Exceptions\WeatherServiceException;
use Illuminate\Support\Facades\Log;

/**
 * AnalyticsValidationTrait
 * 
 * Provides reusable validation methods for analytics services to ensure data integrity.
 * Prevents silent failures by validating critical relationships and coordinates.
 * 
 * @package App\Services\Traits
 */
trait AnalyticsValidationTrait
{
    /**
     * Validate that a farm has weather coordinates configured.
     * 
     * @param Farm $farm
     * @return bool
     * @throws WeatherServiceException If coordinates are missing
     */
    public function validateWeatherCoordinates(Farm $farm): bool
    {
        $coords = $farm->weather_coordinates;
        
        if (!$coords || !isset($coords['lat'], $coords['lon'])) {
            Log::warning("Farm {$farm->id} ({$farm->name}) missing weather coordinates", [
                'farm_id' => $farm->id,
                'farm_coordinates' => $farm->farm_coordinates,
            ]);
            
            throw new WeatherServiceException(
                "Weather coordinates not configured for farm '{$farm->name}'. "
                . "Please set farm location during onboarding to enable weather analytics."
            );
        }
        
        // Validate coordinate values are within reasonable ranges
        if ($coords['lat'] < -90 || $coords['lat'] > 90 || 
            $coords['lon'] < -180 || $coords['lon'] > 180) {
            Log::error("Farm {$farm->id} has invalid coordinates", [
                'lat' => $coords['lat'],
                'lon' => $coords['lon'],
            ]);
            
            throw new WeatherServiceException(
                "Invalid weather coordinates for farm '{$farm->name}'. "
                . "Latitude must be between -90 and 90, longitude between -180 and 180."
            );
        }
        
        return true;
    }

    /**
     * Validate that a planting has a rice variety reference.
     * 
     * @param Planting $planting
     * @return bool
     * @throws \Exception If rice variety is missing
     */
    public function validateRiceVariety(Planting $planting): bool
    {
        if (!$planting->riceVariety) {
            Log::warning("Planting {$planting->id} missing rice variety reference", [
                'planting_id' => $planting->id,
                'field_id' => $planting->field_id,
                'rice_variety_id' => $planting->rice_variety_id,
            ]);
            
            throw new \Exception(
                "Rice variety not set for planting on field '{$planting->field->name}'. "
                . "Please select a rice variety when creating the planting."
            );
        }
        
        // Validate that the variety has critical data
        if ($planting->riceVariety->average_yield_per_hectare === null) {
            Log::warning("Rice variety {$planting->rice_variety_id} missing average yield", [
                'variety_id' => $planting->rice_variety_id,
                'variety_name' => $planting->riceVariety->name,
            ]);
        }
        
        return true;
    }

    /**
     * Validate that a planting has usable data for analytics.
     * 
     * Returns validation result instead of throwing, useful for batch operations.
     * 
     * @param Planting $planting
     * @return array ['valid' => bool, 'issues' => array of strings]
     */
    public function validatePlantingForAnalytics(Planting $planting): array
    {
        $issues = [];
        
        if (!$planting->riceVariety) {
            $issues[] = "Missing rice variety reference";
        }
        
        if (!$planting->field) {
            $issues[] = "Missing field reference";
        } elseif (!$planting->field->farm) {
            $issues[] = "Field missing farm reference";
        }
        
        if (!$planting->planting_date) {
            $issues[] = "Missing planting date";
        }
        
        if ($planting->area_planted <= 0) {
            $issues[] = "Invalid area planted";
        }
        
        return [
            'valid' => empty($issues),
            'issues' => $issues,
            'planting_id' => $planting->id,
        ];
    }

    /**
     * Validate that a farm has weather coordinates. Instead of throwing,
     * returns validation result. Useful for determining data completeness.
     * 
     * @param Farm $farm
     * @return array ['valid' => bool, 'has_coordinates' => bool, 'issue' => string|null]
     */
    public function validateWeatherCoordinatesSafe(Farm $farm): array
    {
        $coords = $farm->weather_coordinates;
        
        if (!$coords) {
            return [
                'valid' => false,
                'has_coordinates' => false,
                'issue' => 'Weather coordinates not configured',
            ];
        }
        
        if (!isset($coords['lat'], $coords['lon'])) {
            return [
                'valid' => false,
                'has_coordinates' => false,
                'issue' => 'Weather coordinates incomplete (missing lat/lon)',
            ];
        }
        
        if ($coords['lat'] < -90 || $coords['lat'] > 90 || 
            $coords['lon'] < -180 || $coords['lon'] > 180) {
            return [
                'valid' => false,
                'has_coordinates' => true,
                'issue' => 'Weather coordinates out of valid range',
            ];
        }
        
        return [
            'valid' => true,
            'has_coordinates' => true,
            'coordinates' => $coords,
        ];
    }
}
