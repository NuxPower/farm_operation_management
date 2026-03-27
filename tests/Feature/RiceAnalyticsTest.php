<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\Farm;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;
use Illuminate\Support\Facades\Config;

class RiceAnalyticsTest extends TestCase
{
    use RefreshDatabase;

    public function test_rice_analytics_returns_200_with_farm()
    {
        $farmer = User::factory()->create(['role' => 'farmer']);

        // Create a farm so the endpoint doesn't return 404
        $farm = Farm::factory()->create(['user_id' => $farmer->id]);

        // Override config to specific known values for testing
        Config::set('rice_analytics.efficiency_benchmarks.water', 1.0);

        $response = $this->actingAs($farmer)
            ->getJson('/api/analytics/rice-farming?period=12');

        $response->assertStatus(200)
            ->assertJsonStructure([
                'analytics',
                'status',
            ]);
    }

    public function test_rice_analytics_returns_404_without_farm()
    {
        $farmer = User::factory()->create(['role' => 'farmer']);

        $response = $this->actingAs($farmer)
            ->getJson('/api/analytics/rice-farming?period=12');

        $response->assertStatus(404);
    }
}
