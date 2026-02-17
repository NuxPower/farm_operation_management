<?php

namespace Tests\Feature;

use App\Models\Field;
use App\Models\Laborer;
use App\Models\Planting;
use App\Models\Task;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class TaskExpenseReproductionTest extends TestCase
{
    use RefreshDatabase;

    public function test_creating_completed_task_does_not_generate_expense()
    {
        $user = User::factory()->create();
        $this->actingAs($user);

        $field = Field::factory()->create(['user_id' => $user->id]);
        $planting = Planting::factory()->create(['field_id' => $field->id]);
        $laborer = Laborer::factory()->create(['rate' => 500, 'rate_type' => 'per_day']);

        $response = $this->postJson('/api/tasks', [
            'planting_id' => $planting->id,
            'task_type' => Task::TYPE_WEEDING,
            'due_date' => now()->toDateString(),
            'description' => 'Test Weeding',
            'status' => 'completed', // Immediately completed
            'assigned_to' => $laborer->id,
            'payment_type' => 'wage',
        ]);

        $response->assertStatus(201);

        $taskId = $response->json('task.id');
        $this->assertDatabaseHas('tasks', [
            'id' => $taskId,
            'status' => 'completed',
        ]);

        // This assertion is expected to FAIL if the bug exists
        $this->assertDatabaseHas('expenses', [
            'related_entity_type' => 'task',
            'related_entity_id' => $taskId,
            'amount' => 500,
        ]);
    }
}
