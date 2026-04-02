<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

use Illuminate\Database\Eloquent\Factories\HasFactory;

class Farm extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'name',
        'location',
        'description',
        'total_area',
        'cultivated_area',
        'soil_type',
        'soil_ph',
        'water_source',
        'irrigation_type',
        'primary_rice_variety_id',
        'farm_coordinates',
        'elevation',
        'slope',
        'drainage_system',
        'is_setup_complete',
    ];

    protected $casts = [
        'farm_coordinates' => 'array',
        'total_area' => 'decimal:2',
        'cultivated_area' => 'decimal:2',
        'soil_ph' => 'decimal:1',
        'elevation' => 'decimal:2',
        'slope' => 'decimal:2',
        'is_setup_complete' => 'boolean',
    ];

    public function user(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function fields(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(Field::class);
    }

    public function plantings(): \Illuminate\Database\Eloquent\Relations\HasManyThrough
    {
        return $this->hasManyThrough(Planting::class, Field::class);
    }

    public function weatherLogs(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(WeatherLog::class);
    }

    public function latestWeather(): \Illuminate\Database\Eloquent\Relations\HasOne
    {
        return $this->hasOne(WeatherLog::class)->latestOfMany('recorded_at');
    }

    /**
     * Get lat/lon from farm_coordinates for weather API calls.
     * 
     * Returns coordinates as an array with 'lat' and 'lon' keys.
     * This accessor extracts weather coordinates from the farm_coordinates JSON column.
     * 
     * IMPORTANT: This method returns null if farm_coordinates is not set.
     * Calling code MUST validate this returned value before using in analytics.
     * Use AnalyticsValidationTrait::validateWeatherCoordinatesSafe() to safely check coordinates.
     * 
     * @return array|null Returns ['lat' => float, 'lon' => float] or null if not configured
     * 
     * @example
     * $farm->weather_coordinates // Returns ['lat' => 14.5995, 'lon' => 120.9842]
     * $farm->weather_coordinates // Returns null if farm_coordinates is null
     */
    public function getWeatherCoordinatesAttribute(): ?array
    {
        $coords = $this->farm_coordinates;
        if (!$coords) {
            return null;
        }
        return [
            'lat' => $coords['lat'] ?? null,
            'lon' => $coords['lon'] ?? $coords['lng'] ?? null,
        ];
    }
}
