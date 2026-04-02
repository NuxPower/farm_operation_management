<?php

namespace Tests\Feature;

use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;
use App\Models\User;
use App\Models\Farm;
use App\Models\Field;
use App\Models\Planting;
use App\Models\RiceVariety;

class RiceFarmingAnalyticsControllerTest extends TestCase
{
    use RefreshDatabase;

    public function test_farmer_can_access_rice_farming_analytics_endpoint()
    {
        $farmer = User::factory()->create(['role' => User::ROLE_FARMER]);

        $farm = Farm::factory()->create(['user_id' => $farmer->id]);
        $field = Field::factory()->create(['farm_id' => $farm->id]);
        $variety = RiceVariety::factory()->create();

        Planting::factory()->create([
            'field_id' => $field->id,
            'rice_variety_id' => $variety->id,
            'status' => 'growing'
        ]);

        $response = $this->actingAs($farmer, 'sanctum')
            ->getJson('/api/analytics/rice-farming');

        $response->assertStatus(200)
            ->assertJsonPath('status', 'success')
            ->assertJsonStructure(['analytics' => ['production_analytics', 'financial_analytics', 'field_performance', 'weather_impact', 'efficiency_metrics', 'data_quality', 'risk_reflex']]);
    }

    public function test_rice_farming_analytics_includes_data_quality_and_reflex_risk()
    {
        $farmer = User::factory()->create(['role' => User::ROLE_FARMER]);
        $farm = Farm::factory()->create(['user_id' => $farmer->id]);
        $field = Field::factory()->create(['farm_id' => $farm->id]);
        $variety = RiceVariety::factory()->create();

        Planting::factory()->create([
            'field_id' => $field->id,
            'rice_variety_id' => $variety->id,
            'status' => 'growing'
        ]);

        $response = $this->actingAs($farmer, 'sanctum')
            ->getJson('/api/analytics/rice-farming');

        $response->assertStatus(200)
            ->assertJsonStructure([
                'analytics' => [
                    'data_quality' => ['data_completeness', 'quality_score'],
                    'risk_reflex' => ['pest_risks', 'actions', 'score']
                ]
            ]);
    }

    public function test_rice_farming_analytics_returns_no_data_when_no_plantings()
    {
        $farmer = User::factory()->create(['role' => User::ROLE_FARMER]);
        $farm = Farm::factory()->create(['user_id' => $farmer->id]);

        $response = $this->actingAs($farmer, 'sanctum')
            ->getJson('/api/analytics/rice-farming');

        $response->assertStatus(200)
            ->assertJsonPath('status', 'success');

        $this->assertArrayHasKey('production_analytics', $response->json('analytics'));
        $this->assertEquals(0, $response->json('analytics.production_analytics.total_plantings'));
    }
}
