<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;
use App\Models\User;
use App\Models\Farm;
use App\Models\Field;
use App\Models\Planting;
use App\Models\PestIncident;
use App\Models\PlantingStage;
use App\Models\RiceGrowthStage;
use App\Models\Expense;
use Carbon\Carbon;

class PestTreatmentExpenseTest extends TestCase
{
    use RefreshDatabase;

    public function test_creating_pest_incident_with_cost_creates_expense()
    {
        $user = User::factory()->create(['role' => 'farmer']);
        $farm = Farm::factory()->create(['user_id' => $user->id]);
        $field = Field::factory()->create(['user_id' => $user->id, 'farm_id' => $farm->id]);
        $planting = Planting::factory()->create(['field_id' => $field->id, 'status' => 'growing']);

        // Ensure spray window validation passes: flowering stage + 07:00-08:00
        $floweringStage = RiceGrowthStage::firstOrCreate([
            'stage_code' => 'flowering'
        ], [
            'name' => 'Flowering',
            'description' => 'Flowering stage',
            'typical_duration_days' => 14,
            'order_sequence' => 5,
            'is_active' => true,
        ]);

        PlantingStage::create([
            'planting_id' => $planting->id,
            'rice_growth_stage_id' => $floweringStage->id,
            'status' => 'in_progress',
        ]);

        $response = $this->actingAs($user)->postJson('/api/pest-incidents', [
            'planting_id' => $planting->id,
            'pest_type' => 'insect',
            'pest_name' => 'Test Hopper',
            'severity' => 'high',
            'affected_area' => 1.5,
            'detected_date' => now()->format('Y-m-d'),
            'treatment_applied' => 'Pesticide spray',
            'treatment_date' => now()->setTime(7, 15)->toDateTimeString(),
            'treatment_cost' => 500.00,
        ]);

        $response->assertStatus(201);
        $incidentId = $response->json('incident.id');

        $this->assertDatabaseHas('expenses', [
            'user_id' => $user->id,
            'planting_id' => $planting->id,
            'amount' => 500.00,
            'category' => Expense::CATEGORY_PESTICIDE,
            'related_entity_type' => 'pest_incident',
            'related_entity_id' => $incidentId,
        ]);
    }

    public function test_updating_pest_incident_cost_updates_expense()
    {
        $user = User::factory()->create(['role' => 'farmer']);
        $farm = Farm::factory()->create(['user_id' => $user->id]);
        $field = Field::factory()->create(['farm_id' => $farm->id]);
        $planting = Planting::factory()->create(['field_id' => $field->id, 'status' => 'growing']);

        $incident = PestIncident::create([
            'user_id' => $user->id,
            'planting_id' => $planting->id,
            'pest_type' => 'disease',
            'pest_name' => 'Blast',
            'severity' => 'medium',
            'detected_date' => now(),
            'status' => 'active',
        ]);

        // Assert no expense exists yet
        $this->assertDatabaseMissing('expenses', [
            'related_entity_type' => 'pest_incident',
            'related_entity_id' => $incident->id,
        ]);

        // Update with cost
        $response = $this->actingAs($user)->putJson("/api/pest-incidents/{$incident->id}", [
            'treatment_applied' => 'Fungicide',
            'treatment_cost' => 350.50,
            'status' => 'treated',
        ]);

        $response->assertStatus(200);

        // Assert auto-expense was created
        $this->assertDatabaseHas('expenses', [
            'amount' => 350.50,
            'category' => Expense::CATEGORY_PESTICIDE,
            'related_entity_type' => 'pest_incident',
            'related_entity_id' => $incident->id,
        ]);

        // Update cost again
        $response = $this->actingAs($user)->putJson("/api/pest-incidents/{$incident->id}", [
            'treatment_cost' => 450.00,
        ]);

        $response->assertStatus(200);

        // Assert auto-expense was updated, not duplicated
        $this->assertDatabaseHas('expenses', [
            'amount' => 450.00,
            'category' => Expense::CATEGORY_PESTICIDE,
            'related_entity_type' => 'pest_incident',
            'related_entity_id' => $incident->id,
        ]);

        $this->assertEquals(1, Expense::where('related_entity_type', 'pest_incident')->where('related_entity_id', $incident->id)->count());
    }
}
