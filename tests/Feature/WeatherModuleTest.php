<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\Farm;
use App\Models\Field;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;
use App\Services\WeatherService;

class WeatherModuleTest extends TestCase
{
    use RefreshDatabase;

    protected $farmer;
    protected $farm;
    protected $field;

    protected function setUp(): void
    {
        parent::setUp();
        // Create Farmer
        $this->farmer = User::factory()->create(['role' => 'farmer']);

        $this->farm = Farm::factory()->create([
            'user_id' => $this->farmer->id,
            'name' => 'Test Farm',
            'farm_coordinates' => ['lat' => 10, 'lon' => 120]
        ]);

        $this->field = Field::factory()->create([
            'user_id' => $this->farmer->id,
            'farm_id' => $this->farm->id,
            'name' => 'Test Field',
            'size' => 1.5
        ]);
    }

    public function test_can_fetch_farm_weather_dashboard()
    {
        // Mocking the WeatherService
        $this->mock(WeatherService::class, function ($mock) {
            $mock->shouldReceive('getCurrentWeather')
                ->andReturn([
                    'main' => [
                        'temp' => 30,
                        'humidity' => 70
                    ],
                    'weather' => [
                        [
                            'main' => 'Sunny',
                            'description' => 'Clear sky',
                            'icon' => '01d'
                        ]
                    ],
                    'dt' => time(),
                    'wind' => ['speed' => 5],
                    'rain' => ['1h' => 0]
                ]);

            $mock->shouldReceive('updateFarmWeather')
                ->withAnyArgs()
                ->andReturn(new \App\Models\WeatherLog([
                    'farm_id' => $this->farm->id,
                    'temperature' => 30,
                    'humidity' => 70,
                    'conditions' => 'clear',
                    'wind_speed' => 18,
                    'rainfall' => 0,
                    'recorded_at' => now()
                ]));
            $mock->shouldReceive('formatWeatherLog')
                ->withAnyArgs()
                ->andReturn(['temperature' => 30, 'conditions' => 'clear']);
            $mock->shouldReceive('getWeatherAlerts')
                ->withAnyArgs()
                ->andReturn([]);
        });

        $response = $this->actingAs($this->farmer)
            ->getJson("/api/weather/farms/{$this->farm->id}/current");

        if ($response->status() !== 200) {
            dump($response->json());
        }
        $response->assertStatus(200)
            ->assertJsonPath('weather.temperature', 30);
    }

    public function test_rice_specific_weather_analytics()
    {
        // Mock essential methods for analytics
        $this->mock(WeatherService::class, function ($mock) {
            $mock->shouldReceive('getRiceWeatherAnalytics')
                ->andReturn(['suitability_score' => 85]);
            $mock->shouldReceive('getRiceFarmingRecommendations')
                ->andReturn(['Irrigate now']);
        });

        $response = $this->actingAs($this->farmer)
            ->getJson("/api/weather/farms/{$this->farm->id}/rice-analytics");

        $response->assertStatus(200);
    }
}
