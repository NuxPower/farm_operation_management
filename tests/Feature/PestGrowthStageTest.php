<?php

namespace Tests\Feature;

use App\Services\PestPredictionService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class PestGrowthStageTest extends TestCase
{
    use RefreshDatabase;
    public function test_growth_stage_calculation()
    {
        $service = app(PestPredictionService::class);

        $this->assertEquals('vegetative', $service->getGrowthStage(0));
        $this->assertEquals('vegetative', $service->getGrowthStage(30));
        $this->assertEquals('vegetative', $service->getGrowthStage(45));
        $this->assertEquals('reproductive', $service->getGrowthStage(46));
        $this->assertEquals('reproductive', $service->getGrowthStage(60));
        $this->assertEquals('reproductive', $service->getGrowthStage(75));
        $this->assertEquals('ripening', $service->getGrowthStage(76));
        $this->assertEquals('ripening', $service->getGrowthStage(100));
    }

    public function test_growth_stage_filters_pests()
    {
        // Create a pest with vulnerable_stages set to vegetative only
        $pest = \App\Models\PestLibrary::create([
            'name' => 'Test Leafhopper',
            'slug' => 'test-leafhopper',
            'type' => 'insect',
            'description' => 'Test pest',
            'vulnerable_stages' => ['vegetative'],
        ]);

        \App\Models\PestAnalyticsRule::create([
            'pest_library_id' => $pest->id,
            'metric' => 'humidity',
            'condition' => '>',
            'value_min' => 80,
            'risk_level' => 'high',
            'risk_message' => 'High humidity triggers test pest',
            'stage_note' => 'Only affects seedlings',
        ]);

        // Create a pest with no stage restriction (should always show)
        $pestAny = \App\Models\PestLibrary::create([
            'name' => 'Test Allstage Pest',
            'slug' => 'test-allstage-pest',
            'type' => 'disease',
            'description' => 'Affects all stages',
            'vulnerable_stages' => null,
        ]);

        \App\Models\PestAnalyticsRule::create([
            'pest_library_id' => $pestAny->id,
            'metric' => 'humidity',
            'condition' => '>',
            'value_min' => 80,
            'risk_level' => 'moderate',
            'risk_message' => 'Always relevant',
        ]);

        // Simulate a day with high humidity
        $day = [
            'dt' => now()->timestamp,
            'main' => ['temp' => 28, 'humidity' => 95],
            'weather' => [['main' => 'Clear']],
            'pop' => 0.2,
            'wind' => ['speed' => 3],
        ];

        $pests = \App\Models\PestLibrary::with('rules')->whereIn('id', [$pest->id, $pestAny->id])->get();

        // Use reflection to call private analyzeDailyRisk
        $service = app(PestPredictionService::class);
        $method = new \ReflectionMethod($service, 'analyzeDailyRisk');
        $method->setAccessible(true);

        // Vegetative stage: both pests should trigger
        $risksVeg = $method->invoke($service, $day, $pests, 'vegetative');
        $pestNames = array_column($risksVeg, 'pest_name');
        $this->assertContains('Test Leafhopper', $pestNames);
        $this->assertContains('Test Allstage Pest', $pestNames);

        // Reproductive stage: only allstage pest should trigger (leafhopper filtered)
        $risksRepro = $method->invoke($service, $day, $pests, 'reproductive');
        $pestNamesRepro = array_column($risksRepro, 'pest_name');
        $this->assertNotContains('Test Leafhopper', $pestNamesRepro);
        $this->assertContains('Test Allstage Pest', $pestNamesRepro);

        // Verify stage_note is appended when growthStage is provided
        $leafhopperRisk = collect($risksVeg)->firstWhere('pest_name', 'Test Leafhopper');
        $this->assertStringContainsString('Only affects seedlings', $leafhopperRisk['description']);
        $this->assertEquals('Only affects seedlings', $leafhopperRisk['stage_note']);
    }
}
