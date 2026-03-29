<?php

namespace Tests\Feature\Labor;

use App\Models\User;
use App\Models\Laborer;
use App\Models\Field;
use App\Models\Planting;
use App\Models\RiceVariety;
use App\Models\Task;
use App\Models\Expense;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;

class RevenueShareTaskTest extends TestCase
{
    use DatabaseTransactions;

    protected $farmer;
    protected $laborer;
    protected $planting;

    protected function setUp(): void
    {
        parent::setUp();
        $this->farmer = User::factory()->create(['role' => 'farmer']);

        $field = Field::factory()->create(['user_id' => $this->farmer->id]);
        $variety = RiceVariety::factory()->create();

        $this->planting = Planting::create([
            'field_id' => $field->id,
            'rice_variety_id' => $variety->id,
            'planting_date' => now(),
            'expected_harvest_date' => now()->addDays(120),
            'status' => 'planted',
            'planting_method' => 'transplanting',
            'area_planted' => 1.5,
            'crop_type' => 'rice',
            'season' => 'dry',
        ]);

        $this->laborer = Laborer::factory()->create([
            'user_id' => $this->farmer->id,
            'rate' => 500,
            'rate_type' => 'daily'
        ]);
    }

    /**
     * Completing a share-based task should NOT create an expense or labor wage.
     * Crop-share compensation is handled by HarvestController when the harvest
     * is recorded, since only then do we know the actual quantity and price.
     */
    public function test_completing_share_task_does_not_create_expense()
    {
        $task = Task::create([
            'planting_id' => $this->planting->id,
            'task_type' => 'harvesting',
            'due_date' => now(),
            'description' => 'Harvesting task with revenue share',
            'assigned_to' => $this->laborer->id,
            'payment_type' => 'share',
            'revenue_share_percentage' => 15.00,
            'status' => 'pending'
        ]);

        $response = $this->actingAs($this->farmer)
            ->postJson("/api/tasks/{$task->id}/complete");

        $response->assertStatus(200);

        $this->assertEquals('completed', $task->fresh()->status);

        // Share-based tasks should NOT generate expenses at task-completion time.
        $this->assertDatabaseMissing('expenses', [
            'related_entity_type' => 'task',
            'related_entity_id' => $task->id,
        ]);

        // No LaborWage either
        $this->assertDatabaseMissing('labor_wages', [
            'task_id' => $task->id,
        ]);
    }

    /**
     * Non-share tasks (wage-based) should still create expenses as before.
     */
    public function test_completing_wage_task_still_creates_expense()
    {
        $task = Task::create([
            'planting_id' => $this->planting->id,
            'task_type' => 'weeding',
            'due_date' => now(),
            'description' => 'Weeding task with daily wage',
            'assigned_to' => $this->laborer->id,
            'payment_type' => 'wage',
            'wage_amount' => 500,
            'status' => 'pending'
        ]);

        $response = $this->actingAs($this->farmer)
            ->postJson("/api/tasks/{$task->id}/complete");

        $response->assertStatus(200);

        // Wage-based tasks should still generate expenses
        $this->assertDatabaseHas('expenses', [
            'related_entity_type' => 'task',
            'related_entity_id' => $task->id,
            'amount' => 500,
            'category' => 'labor',
        ]);

        $this->assertDatabaseHas('labor_wages', [
            'task_id' => $task->id,
            'wage_amount' => 500,
        ]);
    }
}
