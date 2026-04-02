<?php

namespace Tests\Unit;

use App\Models\Farm;
use App\Models\Planting;
use App\Models\Field;
use App\Models\RiceVariety;
use App\Services\Traits\AnalyticsValidationTrait;
use App\Exceptions\WeatherServiceException;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AnalyticsValidationTraitTest extends TestCase
{
    use RefreshDatabase;

    /**
     * Helper to create a concrete class that uses the trait
     */
    private function getTraitObject()
    {
        return new class {
            use AnalyticsValidationTrait;
        };
    }

    /** @test */
    public function it_validates_farm_with_valid_coordinates()
    {
        $farm = Farm::factory()->create([
            'farm_coordinates' => ['lat' => 14.5995, 'lon' => 120.9842],
        ]);

        $validator = $this->getTraitObject();
        
        $result = $validator->validateWeatherCoordinates($farm);
        $this->assertTrue($result);
    }

    /** @test */
    public function it_throws_exception_when_coordinates_are_null()
    {
        $farm = Farm::factory()->create([
            'farm_coordinates' => null,
        ]);

        $validator = $this->getTraitObject();
        
        $this->expectException(WeatherServiceException::class);
        $validator->validateWeatherCoordinates($farm);
    }

    /** @test */
    public function it_throws_exception_when_coordinates_are_incomplete()
    {
        $farm = Farm::factory()->create([
            'farm_coordinates' => ['lat' => 14.5995], // Missing lon
        ]);

        $validator = $this->getTraitObject();
        
        $this->expectException(WeatherServiceException::class);
        $validator->validateWeatherCoordinates($farm);
    }

    /** @test */
    public function it_throws_exception_when_latitude_is_invalid()
    {
        $farm = Farm::factory()->create([
            'farm_coordinates' => ['lat' => 95.0, 'lon' => 120.9842], // lat > 90
        ]);

        $validator = $this->getTraitObject();
        
        $this->expectException(WeatherServiceException::class);
        $validator->validateWeatherCoordinates($farm);
    }

    /** @test */
    public function it_throws_exception_when_longitude_is_invalid()
    {
        $farm = Farm::factory()->create([
            'farm_coordinates' => ['lat' => 14.5995, 'lon' => 200.0], // lon > 180
        ]);

        $validator = $this->getTraitObject();
        
        $this->expectException(WeatherServiceException::class);
        $validator->validateWeatherCoordinates($farm);
    }

    /** @test */
    public function safe_validation_returns_array_with_valid_coordinates()
    {
        $farm = Farm::factory()->create([
            'farm_coordinates' => ['lat' => 14.5995, 'lon' => 120.9842],
        ]);

        $validator = $this->getTraitObject();
        
        $result = $validator->validateWeatherCoordinatesSafe($farm);
        
        $this->assertTrue($result['valid']);
        $this->assertTrue($result['has_coordinates']);
        $this->assertArrayHasKey('coordinates', $result);
        $this->assertEquals(14.5995, $result['coordinates']['lat']);
    }

    /** @test */
    public function safe_validation_returns_false_for_null_coordinates()
    {
        $farm = Farm::factory()->create([
            'farm_coordinates' => null,
        ]);

        $validator = $this->getTraitObject();
        
        $result = $validator->validateWeatherCoordinatesSafe($farm);
        
        $this->assertFalse($result['valid']);
        $this->assertFalse($result['has_coordinates']);
        $this->assertStringContainsString('not configured', $result['issue']);
    }

    /** @test */
    public function it_validates_planting_with_rice_variety()
    {
        $variety = RiceVariety::factory()->create();
        $field = Field::factory()->create();
        $planting = Planting::factory()->create([
            'field_id' => $field->id,
            'rice_variety_id' => $variety->id,
            'planting_date' => now(),
            'area_planted' => 2.5,
        ]);

        $validator = $this->getTraitObject();
        
        $result = $validator->validateRiceVariety($planting);
        $this->assertTrue($result);
    }

    /** @test */
    public function it_throws_exception_when_planting_missing_rice_variety()
    {
        $field = Field::factory()->create();
        $planting = new Planting([
            'field_id' => $field->id,
            'rice_variety_id' => null,
            'planting_date' => now(),
            'area_planted' => 1.0,
        ]);

        // Set relation to avoid undefined property when accessing field
        $planting->setRelation('field', $field);

        $validator = $this->getTraitObject();
        
        $this->expectException(\Exception::class);
        $validator->validateRiceVariety($planting);
    }

    /** @test */
    public function validate_planting_for_analytics_returns_all_issues()
    {
        $farm = Farm::factory()->create();
        
        // Create a planting with multiple issues
        $planting = new Planting();
        $planting->id = 999;
        $planting->rice_variety_id = null;
        $planting->field_id = null;
        $planting->planting_date = null;
        $planting->area_planted = 0;

        $validator = $this->getTraitObject();
        
        $result = $validator->validatePlantingForAnalytics($planting);
        
        $this->assertFalse($result['valid']);
        $this->assertCount(4, $result['issues']);
        $this->assertContains('Missing rice variety reference', $result['issues']);
        $this->assertContains('Missing field reference', $result['issues']);
    }

    /** @test */
    public function validate_planting_for_analytics_passes_when_valid()
    {
        $variety = RiceVariety::factory()->create();
        $field = Field::factory()->create();
        $farm = Farm::factory()->create();
        $field->update(['farm_id' => $farm->id]);
        
        $planting = Planting::factory()->create([
            'field_id' => $field->id,
            'rice_variety_id' => $variety->id,
            'planting_date' => now(),
            'area_planted' => 2.5,
        ]);

        $validator = $this->getTraitObject();
        
        $result = $validator->validatePlantingForAnalytics($planting);
        
        $this->assertTrue($result['valid']);
        $this->assertCount(0, $result['issues']);
    }
}
