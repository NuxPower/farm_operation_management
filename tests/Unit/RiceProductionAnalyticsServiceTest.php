<?php

namespace Tests\Unit;

use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;
use App\Services\Analytics\RiceProductionAnalyticsService;
use App\Models\Planting;
use App\Models\Field;
use App\Models\RiceVariety;
use App\Models\WeatherLog;

class RiceProductionAnalyticsServiceTest extends TestCase
{
    use RefreshDatabase;

    public function test_calculate_yield_gap_without_rice_variety_returns_incomplete_data()
    {
        $planting = Planting::factory()->make([
            'field_id' => Field::factory()->create()->id,
            'rice_variety_id' => null,
            'area_planted' => 2,
            'status' => 'harvested',
            'planting_date' => now()->subDays(90),
            'expected_harvest_date' => now()->addDays(20),
        ]);

        $planting->setRelation('harvests', collect());
        $planting->setRelation('riceVariety', null);

        $result = (new RiceProductionAnalyticsService())->calculateYieldGap($planting);

        $this->assertSame('incomplete_data', $result['status']);
        $this->assertSame(0, $result['gap_kg_ha']);
        $this->assertSame(0, $result['gap_percentage']);
    }

    public function test_track_growth_stages_with_no_weather_returns_zero_and_unknown_stage()
    {
        $field = Field::factory()->create();
        $planting = Planting::factory()->create([
            'field_id' => $field->id,
            'planting_date' => now()->subDays(30),
            'expected_harvest_date' => now()->addDays(30),
            'status' => 'growing',
        ]);

        $result = (new RiceProductionAnalyticsService())->trackGrowthStages($planting);

        $this->assertEquals(0, $result['accumulated_gdd']);
        $this->assertEquals('Vegetative', $result['estimated_biological_stage']);
        $this->assertEquals(0, $result['records_count']);
    }

    public function test_calculate_fertilizer_efficiency_with_no_tasks_returns_low_rating()
    {
        $planting = Planting::factory()->create();

        $result = (new RiceProductionAnalyticsService())->calculateFertilizerEfficiency($planting);

        $this->assertSame('ok', $result['status']);
        $this->assertSame(0.0, $result['pfp_efficiency']);
        $this->assertSame('low', $result['rating']);
    }
}
