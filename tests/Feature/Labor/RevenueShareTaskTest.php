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

    public function test_completing_share_task_creates_revenue_share_expense()
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

        // Verify Expense
        $this->assertDatabaseHas('expenses', [
            'user_id' => $this->farmer->id,
            'amount' => 15.00,
            'category' => 'labor',
            'payment_method' => 'revenue_share',
            'related_entity_type' => 'task',
            'related_entity_id' => $task->id
        ]);

        // Verify LaborWage
        $this->assertDatabaseHas('labor_wages', [
            'laborer_id' => $this->laborer->id,
            'task_id' => $task->id,
            'wage_amount' => 15.00
        ]);
    }
}
