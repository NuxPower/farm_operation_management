<?php

namespace Tests\Feature\Labor;

use App\Models\User;
use App\Models\Field;
use App\Models\Laborer;
use App\Models\LaborerGroup;
use App\Models\LaborWage;
use App\Models\Planting;
use App\Models\RiceVariety;
use App\Models\Task;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class LaborerTest extends TestCase
{
    use RefreshDatabase;

    protected $farmer;
    protected Planting $planting;

    protected function setUp(): void
    {
        parent::setUp();
        $this->farmer = User::factory()->create(['role' => 'farmer']);

        $field = Field::factory()->create(['user_id' => $this->farmer->id]);
        $variety = RiceVariety::factory()->create();

        $this->planting = Planting::factory()->create([
            'field_id' => $field->id,
            'rice_variety_id' => $variety->id,
            'crop_type' => 'rice',
        ]);
    }

    public function test_can_create_laborer()
    {
        $data = [
            'name' => 'John Doe',
            'phone' => '09171234567',
            'skill_level' => 'intermediate',
            'rate_type' => 'daily',
            'rate' => 500,
            'status' => 'active',
            'hire_date' => now()->toDateString(),
        ];

        $response = $this->actingAs($this->farmer)
            ->postJson('/api/laborers', $data);

        $response->assertStatus(201)
            ->assertJsonPath('laborer.name', 'John Doe');

        $this->assertDatabaseHas('laborers', [
            'name' => 'John Doe',
            'user_id' => $this->farmer->id
        ]);
    }

    public function test_can_update_laborer()
    {
        $laborer = Laborer::factory()->create(['user_id' => $this->farmer->id]);

        $response = $this->actingAs($this->farmer)
            ->putJson("/api/laborers/{$laborer->id}", [
                'name' => 'Jane Doe',
                'status' => 'inactive'
            ]);

        $response->assertStatus(200);

        $this->assertEquals('Jane Doe', $laborer->fresh()->name);
        $this->assertEquals('inactive', $laborer->fresh()->status);
    }

    public function test_can_delete_laborer()
    {
        $laborer = Laborer::factory()->create(['user_id' => $this->farmer->id]);

        $response = $this->actingAs($this->farmer)
            ->deleteJson("/api/laborers/{$laborer->id}");

        $response->assertStatus(200);

        $this->assertDatabaseMissing('laborers', ['id' => $laborer->id]);
    }

    public function test_cannot_delete_laborer_with_task_history()
    {
        $laborer = Laborer::factory()->create(['user_id' => $this->farmer->id]);

        Task::create([
            'planting_id' => $this->planting->id,
            'task_type' => Task::TYPE_MAINTENANCE,
            'due_date' => now(),
            'status' => Task::STATUS_PENDING,
            'assigned_to' => $laborer->id,
        ]);

        $response = $this->actingAs($this->farmer)
            ->deleteJson("/api/laborers/{$laborer->id}");

        $response->assertStatus(422)
            ->assertJsonPath('message', 'This laborer has task or wage history. Set the laborer status to inactive instead of deleting.');

        $this->assertDatabaseHas('laborers', ['id' => $laborer->id]);
    }

    public function test_laborer_groups_must_belong_to_current_farmer()
    {
        $otherFarmer = User::factory()->create(['role' => 'farmer']);
        $otherGroup = LaborerGroup::create([
            'name' => 'Other Farm Team',
            'user_id' => $otherFarmer->id,
        ]);

        $response = $this->actingAs($this->farmer)
            ->postJson('/api/laborers', [
                'name' => 'Group Leak Test',
                'phone' => '09171234567',
                'skill_level' => 'intermediate',
                'rate_type' => 'daily',
                'rate' => 500,
                'status' => 'active',
                'hire_date' => now()->toDateString(),
                'groups' => [$otherGroup->id],
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors('groups');
    }

    public function test_laborer_show_includes_group_assigned_tasks()
    {
        $laborer = Laborer::factory()->create(['user_id' => $this->farmer->id]);
        $group = LaborerGroup::create([
            'name' => 'Harvest Team',
            'user_id' => $this->farmer->id,
        ]);
        $group->laborers()->attach($laborer);

        $task = Task::create([
            'planting_id' => $this->planting->id,
            'task_type' => Task::TYPE_MAINTENANCE,
            'due_date' => now(),
            'status' => Task::STATUS_PENDING,
            'laborer_group_id' => $group->id,
        ]);

        $response = $this->actingAs($this->farmer)
            ->getJson("/api/laborers/{$laborer->id}");

        $response->assertStatus(200)
            ->assertJsonPath('laborer.tasks.0.id', $task->id);
    }

    public function test_group_daily_cost_counts_daily_rate_members_only()
    {
        $group = LaborerGroup::create([
            'name' => 'Mixed Rate Team',
            'user_id' => $this->farmer->id,
        ]);

        $dailyLaborer = Laborer::factory()->create([
            'user_id' => $this->farmer->id,
            'rate_type' => 'daily',
            'rate' => 500,
        ]);

        $perJobLaborer = Laborer::factory()->create([
            'user_id' => $this->farmer->id,
            'rate_type' => 'per_job',
            'rate' => 2000,
        ]);

        $shareLaborer = Laborer::factory()->create([
            'user_id' => $this->farmer->id,
            'rate_type' => 'share',
            'rate' => 10,
        ]);

        $group->laborers()->attach([$dailyLaborer->id, $perJobLaborer->id, $shareLaborer->id]);

        $response = $this->actingAs($this->farmer)
            ->getJson("/api/laborers/groups/{$group->id}");

        $response->assertStatus(200)
            ->assertJsonPath('group.stats.total_daily_cost', 500);
    }

    public function test_laborer_performance_uses_wage_amount()
    {
        $laborer = Laborer::factory()->create(['user_id' => $this->farmer->id]);
        $task = Task::create([
            'planting_id' => $this->planting->id,
            'task_type' => Task::TYPE_MAINTENANCE,
            'due_date' => now(),
            'status' => Task::STATUS_COMPLETED,
            'assigned_to' => $laborer->id,
        ]);

        LaborWage::create([
            'laborer_id' => $laborer->id,
            'task_id' => $task->id,
            'hours_worked' => 8,
            'wage_amount' => 750,
            'date' => now(),
        ]);

        $controller = app(\App\Http\Controllers\Labor\LaborerController::class);
        $request = request();
        $request->setUserResolver(fn () => $this->farmer);

        $response = $controller->performance($request, $laborer);
        $payload = $response->getData(true);

        $this->assertSame(750, (int) $payload['performance']['total_wages']);
        $this->assertSame(1, $payload['performance']['total_tasks']);
        $this->assertSame(1, $payload['performance']['completed_tasks']);
    }

    public function test_cannot_access_other_farmers_laborers()
    {
        $otherFarmer = User::factory()->create(['role' => 'farmer']);
        $laborer = Laborer::factory()->create(['user_id' => $otherFarmer->id]);

        $response = $this->actingAs($this->farmer)
            ->getJson("/api/laborers/{$laborer->id}");

        $response->assertStatus(403);
    }
}
