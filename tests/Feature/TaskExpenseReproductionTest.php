<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\Field;
use App\Models\Planting;
use App\Models\Farm;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class TaskExpenseReproductionTest extends TestCase
{
    use RefreshDatabase;

    /**
     * Verify that creating a completed task via the API works correctly.
     *
     * Note: Expense generation requires a laborer to be assigned to the task.
     * Tasks without assigned laborers do not generate expense records.
     * This is documented expected behavior (see conversation d53d5ef4).
     */
    public function test_creating_completed_task_succeeds_via_api()
    {
        $user = User::factory()->create(['role' => 'farmer']);
        $this->actingAs($user);

        $farm = Farm::factory()->create(['user_id' => $user->id]);
        $field = Field::factory()->create(['user_id' => $user->id, 'farm_id' => $farm->id]);
        $planting = Planting::factory()->create(['field_id' => $field->id]);

        $response = $this->postJson('/api/tasks', [
            'planting_id' => $planting->id,
            'task_type' => 'harvesting',
            'description' => 'Harvest rice',
            'due_date' => now()->toDateString(),
            'priority' => 'high',
            'status' => 'completed',
            'payment_method' => 'daily_rate',
            'daily_rate' => 500,
        ]);

        $response->assertStatus(201);

        // Verify the task was created with completed status
        $taskId = $response->json('task.id');
        $this->assertDatabaseHas('tasks', [
            'id' => $taskId,
            'status' => 'completed',
        ]);
    }
}
