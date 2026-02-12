<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\Farm;
use App\Services\WeatherService;
use Mockery\MockInterface;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;

class WeatherTest extends TestCase
{
    use DatabaseTransactions;

    protected $farmer;
    protected $farm;
    protected $weatherService;

    protected function setUp(): void
    {
        parent::setUp();
        $this->farmer = User::factory()->create(['role' => 'farmer']);

        $this->farm = Farm::factory()->create([
            'user_id' => $this->farmer->id,
            'name' => 'Weather Test Farm',
            'farm_coordinates' => ['lat' => 14.5995, 'lon' => 120.9842] // Manila
        ]);
    }

    public function test_can_get_current_weather()
    {
        // Mock ColorfulCloudsWeatherService (avoid real instantiation)
        $this->mock(\App\Services\ColorfulCloudsWeatherService::class, function (MockInterface $mock) {
            // No strict expectations, just don't crash
        });

        // Mock WeatherService
        $this->mock(WeatherService::class, function (MockInterface $mock) {
            $mock->shouldReceive('getCurrentWeather')
                ->once()
                ->with(14.5995, 120.9842)
                ->andReturn([
                    'main' => ['temp' => 30, 'humidity' => 70],
                    'weather' => [['main' => 'Clear', 'description' => 'sunny']],
                    'wind' => ['speed' => 5],
                    'dt' => time(),
                    'rain' => ['1h' => 0]
                ]);

            $mock->shouldReceive('updateFarmWeather')
                ->once()
                ->andReturn(new \App\Models\WeatherLog([
                    'farm_id' => $this->farm->id,
                    'temperature' => 30,
                    'humidity' => 70,
                    'wind_speed' => 18, // 5 m/s * 3.6
                    'conditions' => 'clear',
                    'recorded_at' => now(),
                    'rainfall' => 0
                ]));

            $mock->shouldReceive('formatWeatherLog')
                ->andReturn([
                    'temperature' => 30,
                    'conditions' => 'clear',
                    'humidity' => 70,
                    'wind_speed' => 18,
                    'rainfall' => 0
                ]);

            $mock->shouldReceive('getWeatherAlerts')
                ->andReturn([]);
        });

        $response = $this->actingAs($this->farmer)
            ->getJson("/api/weather/farms/{$this->farm->id}/current");

        $response->assertStatus(200)
            ->assertJsonPath('weather.temperature', 30)
            ->assertJsonPath('weather.conditions', 'clear');
    }
}
