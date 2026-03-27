<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\Field;
use App\Models\Planting;
use App\Models\PestIncident;
use App\Models\RiceVariety;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class PestIncidentTest extends TestCase
{
    use RefreshDatabase;

    public function test_report_pest_incident()
    {
        $farmer = User::factory()->create(['role' => 'farmer']);
        $field = Field::factory()->create(['user_id' => $farmer->id, 'field_coordinates' => [['lat' => 10, 'lng' => 120]], 'size' => 1.0]);

        $variety = RiceVariety::factory()->create();

        $planting = Planting::create([
            'user_id' => $farmer->id,
            'field_id' => $field->id,
            'rice_variety_id' => $variety->id, // Added required link
            'planting_date' => now(),
            'status' => 'planted',
            'quantity_planted' => 100,
            'expected_harvest_date' => now()->addMonths(4),
            'area_planted' => 1.5,
            'season' => 'wet' // Added required field
        ]);

        $data = [
            'planting_id' => $planting->id,
            'pest_type' => 'insect',
            'pest_name' => 'Stem Borer',
            'severity' => 'low',  // Changed from invalid 'minor'
            'detected_date' => now()->toDateString(),
            'notes' => 'Found multiple clusters'
        ];

        $response = $this->actingAs($farmer)
            ->postJson('/api/pest-incidents', $data);

        $response->assertStatus(201);
        $this->assertDatabaseHas('pest_incidents', ['pest_name' => 'Stem Borer']);
    }

    public function test_pest_analytics_endpoint()
    {
        $farmer = User::factory()->create(['role' => 'farmer']);
        $field = Field::factory()->create(['user_id' => $farmer->id, 'field_coordinates' => [['lat' => 10, 'lng' => 120]], 'size' => 1.0]);
        $variety = RiceVariety::factory()->create();

        $planting = Planting::create([
            'user_id' => $farmer->id,
            'field_id' => $field->id,
            'rice_variety_id' => $variety->id,
            'planting_date' => now()->subDays(30),
            'status' => 'growing',
            'quantity_planted' => 100,
            'expected_harvest_date' => now()->addMonths(3),
            'area_planted' => 1.5,
            'season' => 'wet'
        ]);

        // Create incidents with different types and severities
        PestIncident::create([
            'planting_id' => $planting->id,
            'user_id' => $farmer->id,
            'pest_type' => 'insect',
            'pest_name' => 'Stem Borer',
            'severity' => 'high',
            'detected_date' => now()->subDays(10),
            'status' => 'resolved',
            'treatment_applied' => 'Pesticide spray',
            'treatment_cost' => 500,
        ]);

        PestIncident::create([
            'planting_id' => $planting->id,
            'user_id' => $farmer->id,
            'pest_type' => 'disease',
            'pest_name' => 'Rice Blast',
            'severity' => 'medium',
            'detected_date' => now()->subDays(5),
            'status' => 'active',
        ]);

        $response = $this->actingAs($farmer)
            ->getJson('/api/pest-incidents/analytics');

        $response->assertStatus(200)
            ->assertJsonStructure([
                'by_type',
                'by_severity',
                'monthly_trend',
                'treatment_costs' => ['total', 'average_per_incident', 'treated_count'],
                'top_pests',
                'avg_resolution_days',
            ]);

        // Verify counts
        $data = $response->json();
        $this->assertEquals(1, $data['by_type']['insect'] ?? 0);
        $this->assertEquals(1, $data['by_type']['disease'] ?? 0);
        $this->assertEquals(1, $data['by_severity']['high'] ?? 0);
        $this->assertEquals(1, $data['by_severity']['medium'] ?? 0);
        $this->assertEquals(500, $data['treatment_costs']['total']);
        $this->assertCount(2, $data['top_pests']);
    }
}
