<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\Field;
use App\Models\Planting;
use App\Models\PestIncident;
use App\Services\WeatherService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;
use Carbon\Carbon;
use Mockery;

class PestWarningRegressionTest extends TestCase
{
    use RefreshDatabase;

    protected $farmer;
    protected $field;
    protected $planting;

    protected function setUp(): void
    {
        parent::setUp();

        // Create a farmer user
        $this->farmer = User::factory()->create([
            'role' => 'farmer',
            'phone_verified_at' => now(),
        ]);

        // Create farm
        $farm = \App\Models\Farm::factory()->create([
            'user_id' => $this->farmer->id,
            'name' => 'Test Farm',
        ]);

        // Create field
        $this->field = Field::create([
            'user_id' => $this->farmer->id,
            'farm_id' => $farm->id,
            'name' => 'Test Field',
            'size' => 2.5,
            'soil_type' => 'loam',
            'irrigation_source' => 'canal',
            'location' => ['lat' => 14.5, 'lon' => 121.0], // Mock coordinates
        ]);

        // Create rice variety
        $variety = \App\Models\RiceVariety::create([
            'name' => 'Test Variety',
            'variety_code' => 'TEST001',
            'type' => 'lowland',
            'description' => 'Test variety for testing',
            'maturity_days' => 120,
            'average_yield_per_hectare' => 5000,
            'season' => 'both',
            'grain_type' => 'long',
            'resistance_level' => 'high',
        ]);

        // Create planting
        $this->planting = Planting::create([
            'field_id' => $this->field->id,
            'rice_variety_id' => $variety->id,
            'status' => 'growing',
            'area_planted' => 2.0,
            'planting_date' => now()->subDays(30),
            'expected_harvest_date' => now()->addDays(90),
            'planting_method' => 'transplanting',
            'season' => 'dry',
        ]);
    }

    /** @test */
    public function resolved_pest_warnings_are_suppressed()
    {
        // 1. Mock WeatherService to return conditions conducive to Rice Blast
        // Rice Blast: Humidity >= 85, Temp 20-30, Rainy
        $mockWeatherService = $this->mock(WeatherService::class);

        $mockWeatherService->shouldReceive('getForecast')
            ->andReturn([
                'list' => [
                    [
                        'dt' => now()->addDay()->timestamp,
                        'main' => [
                            'temp' => 25,
                            'humidity' => 90,
                        ],
                        'weather' => [
                            ['main' => 'Rain']
                        ],
                        'pop' => 0.8
                    ]
                ]
            ]);

        // We also need to mock these as they might be called by other parts of the controller
        $mockWeatherService->shouldReceive('getWeatherAnalytics')->andReturn([]);
        $mockWeatherService->shouldReceive('getFieldWeatherStats')->andReturn([]);

        // Note: The controller calls $this->getWeatherAnalytics which calls WeatherLog model, 
        // not WeatherService directly for analytics. 
        // But PestPredictionService calls WeatherService->getForecast.

        // 2. First call: Verify warning exists
        $response = $this->actingAs($this->farmer, 'sanctum')
            ->getJson('/api/analytics/data-analysis');

        $response->assertStatus(200);

        // Check if Rice Blast warning is present in forecasts
        $data = $response->json();
        $hasRisk = false;

        if (isset($data['pests']['forecasts'])) {
            foreach ($data['pests']['forecasts'] as $forecast) {
                foreach ($forecast['predictions'] as $prediction) {
                    if (collect($prediction['risks'])->contains('pest_name', 'Rice Blast')) {
                        $hasRisk = true;
                        break 2;
                    }
                }
            }
        }

        $this->assertTrue($hasRisk, "Rice Blast warning should be present initially.");

        // 3. Create a RESOLVED incident for Rice Blast
        PestIncident::create([
            'planting_id' => $this->planting->id,
            'user_id' => $this->farmer->id,
            'pest_type' => 'Disease',
            'pest_name' => 'Rice Blast',
            'severity' => 'medium',
            'detected_date' => now()->subDays(2),
            'status' => 'resolved', // KEY: Status is resolved
            'updated_at' => now(),
        ]);

        // Clear cache to force re-calculation
        \Illuminate\Support\Facades\Cache::flush();

        // 4. Second call: Verify warning is GONE

        // We need to re-mock because the previous mock might have been consumed or we want to ensure it's called again
        // But since we bound it to the container with $this->mock, it should persist unless we overrode it.
        // Actually $this->mock binds a shared instance.

        $response2 = $this->actingAs($this->farmer, 'sanctum')
            ->getJson('/api/analytics/data-analysis');

        $response2->assertStatus(200);

        $data2 = $response2->json();
        $hasRisk2 = false;

        if (isset($data2['pests']['forecasts'])) {
            foreach ($data2['pests']['forecasts'] as $forecast) {
                foreach ($forecast['predictions'] as $prediction) {
                    if (collect($prediction['risks'])->contains('pest_name', 'Rice Blast')) {
                        $hasRisk2 = true;
                        break 2;
                    }
                }
            }
        }

        $this->assertFalse($hasRisk2, "Rice Blast warning should be suppressed after resolution.");
    }
}
