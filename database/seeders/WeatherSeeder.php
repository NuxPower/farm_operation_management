<?php

namespace Database\Seeders;

use App\Models\Farm;
use App\Models\WeatherLog;
use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class WeatherSeeder extends Seeder
{
    /**
     * Seed real historical weather data for the past 30 days.
     * Fetches from Open-Meteo Historical API.
     */
    public function run(): void
    {
        $farms = Farm::whereNotNull('farm_coordinates')->get();

        if ($farms->isEmpty()) {
            echo "No farms with coordinates found. Skipping weather seeding.\n";
            return;
        }

        $endDate = Carbon::now();
        $startDate = Carbon::create(2023, 1, 1); // Go back to Jan 1, 2023

        $startDateStr = $startDate->format('Y-m-d');
        $endDateStr = $endDate->format('Y-m-d');

        foreach ($farms as $farm) {
            $coordinates = $farm->farm_coordinates;
            $lat = $coordinates['lat'] ?? 8.0276;
            $lon = $coordinates['lon'] ?? $coordinates['lng'] ?? 125.1885;

            echo "Fetching weather data for farm '{$farm->farm_name}' at ({$lat}, {$lon}) from {$startDateStr} to {$endDateStr}...\n";

            try {
                $response = Http::get("https://archive-api.open-meteo.com/v1/archive", [
                    'latitude' => $lat,
                    'longitude' => $lon,
                    'start_date' => $startDateStr,
                    'end_date' => $endDateStr,
                    'hourly' => 'temperature_2m,relative_humidity_2m,wind_speed_10m,precipitation,weather_code',
                    'timezone' => 'Asia/Manila'
                ]);

                if (!$response->successful()) {
                    echo "Failed to fetch data from Open-Meteo: " . $response->body() . "\n";
                    continue;
                }

                $data = $response->json();
                $hourly = $data['hourly'];

                $count = 0;
                foreach ($hourly['time'] as $index => $time) {
                    $recordedAt = Carbon::parse($time);

                    // We only want data up to "now"
                    if ($recordedAt->isAfter(now())) {
                        continue;
                    }

                    // Frequency check: Record every 6 hours (0, 6, 12, 18) to balance history length and DB size
                    if ($recordedAt->hour % 6 !== 0) {
                        continue;
                    }

                    WeatherLog::updateOrCreate(
                        [
                            'farm_id' => $farm->id,
                            'recorded_at' => $recordedAt,
                        ],
                        [
                            'temperature' => $hourly['temperature_2m'][$index],
                            'humidity' => $hourly['relative_humidity_2m'][$index],
                            'wind_speed' => $hourly['wind_speed_10m'][$index],
                            'rainfall' => $hourly['precipitation'][$index],
                            'conditions' => $this->mapWmoCode($hourly['weather_code'][$index]),
                        ]
                    );
                    $count++;
                }

                echo "Seeded {$count} weather logs for farm '{$farm->farm_name}'.\n";

            } catch (\Exception $e) {
                echo "Error seeding weather for farm '{$farm->farm_name}': " . $e->getMessage() . "\n";
                Log::error("WeatherSeeder Error: " . $e->getMessage());
            }
        }
    }

    /**
     * Map WMO Weather Codes to our system conditions
     * https://open-meteo.com/en/docs
     */
    private function mapWmoCode(int $code): string
    {
        return match (true) {
            $code === 0 => 'clear',
            in_array($code, [1, 2, 3]) => 'cloudy',
            in_array($code, [45, 48]) => 'foggy',
            in_array($code, [51, 53, 55, 61, 63, 65, 80, 81, 82]) => 'rainy',
            in_array($code, [71, 73, 75, 77, 85, 86]) => 'snowy',
            in_array($code, [95, 96, 99]) => 'stormy',
            default => 'clear',
        };
    }
}
