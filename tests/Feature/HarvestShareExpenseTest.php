<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\Field;
use App\Models\Planting;
use App\Models\RiceVariety;
use App\Models\Expense;
use App\Models\InventoryItem;
use App\Models\PostHarvestProcess;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;

class HarvestShareExpenseTest extends TestCase
{
    use DatabaseTransactions;

    protected $farmer;
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
            'planting_date' => now()->subDays(120),
            'expected_harvest_date' => now(),
            'status' => 'growing',
            'planting_method' => 'transplanting',
            'area_planted' => 1.0,
            'crop_type' => 'rice',
            'season' => 'dry',
        ]);
    }

    /**
     * Creating a harvest with harvester_share and price_per_unit
     * should generate a properly valued peso expense.
     */
    public function test_harvest_creates_accurate_peso_expense_for_share()
    {
        $response = $this->actingAs($this->farmer)
            ->postJson('/api/harvests', [
                'planting_id' => $this->planting->id,
                'harvest_date' => now()->toDateString(),
                'quantity' => 100,
                'unit' => 'bushels',
                'harvester_share' => 11.11,
                'harvester_share_percentage' => 11.11,
                'price_per_unit' => 25.00,
            ]);

        $response->assertStatus(201);
        $harvest = $response->json('harvest');

        // Expense should be: 11.11 sacks × ₱25.00 = ₱277.75
        $this->assertDatabaseHas('expenses', [
            'related_entity_type' => 'harvest',
            'related_entity_id' => $harvest['id'],
            'category' => 'labor',
            'payment_method' => 'crop_share',
        ]);

        $expense = Expense::where('related_entity_type', 'harvest')
            ->where('related_entity_id', $harvest['id'])
            ->first();

        $this->assertNotNull($expense);
        $this->assertEquals(277.75, (float) $expense->amount);
    }

    /**
     * Inventory should receive the FULL GROSS quantity, not net.
     */
    public function test_inventory_receives_gross_quantity()
    {
        $response = $this->actingAs($this->farmer)
            ->postJson('/api/harvests', [
                'planting_id' => $this->planting->id,
                'harvest_date' => now()->toDateString(),
                'quantity' => 100,
                'unit' => 'bushels',
                'harvester_share' => 11.11,
                'harvester_share_percentage' => 11.11,
                'price_per_unit' => 25.00,
            ]);

        $response->assertStatus(201);

        // Check that inventory has the full 100 sacks, not 88.89
        $inventory = InventoryItem::where('user_id', $this->farmer->id)
            ->where('category', 'produce')
            ->where('unit', 'bushels')
            ->first();

        $this->assertNotNull($inventory);
        $this->assertEquals(100, (float) $inventory->current_stock);
    }

    /**
     * When price_per_unit is not set, expense amount should be 0
     * and notes should contain a warning.
     */
    public function test_expense_is_zero_when_price_not_set()
    {
        $response = $this->actingAs($this->farmer)
            ->postJson('/api/harvests', [
                'planting_id' => $this->planting->id,
                'harvest_date' => now()->toDateString(),
                'quantity' => 100,
                'unit' => 'bushels',
                'harvester_share' => 11.11,
                'harvester_share_percentage' => 11.11,
                // price_per_unit intentionally omitted
            ]);

        $response->assertStatus(201);
        $harvest = $response->json('harvest');

        $expense = Expense::where('related_entity_type', 'harvest')
            ->where('related_entity_id', $harvest['id'])
            ->first();

        $this->assertNotNull($expense);
        $this->assertEquals(0, (float) $expense->amount);
        $this->assertStringContainsString('WARNING', $expense->notes);
    }

    /**
     * No expense should be created when there's no harvester share.
     */
    public function test_no_expense_when_no_share()
    {
        $response = $this->actingAs($this->farmer)
            ->postJson('/api/harvests', [
                'planting_id' => $this->planting->id,
                'harvest_date' => now()->toDateString(),
                'quantity' => 100,
                'unit' => 'bushels',
                'price_per_unit' => 25.00,
                // no harvester_share
            ]);

        $response->assertStatus(201);
        $harvest = $response->json('harvest');

        $this->assertDatabaseMissing('expenses', [
            'related_entity_type' => 'harvest',
            'related_entity_id' => $harvest['id'],
        ]);
    }

    public function test_updating_harvest_quantity_syncs_inventory_delta()
    {
        $response = $this->actingAs($this->farmer)
            ->postJson('/api/harvests', [
                'planting_id' => $this->planting->id,
                'harvest_date' => now()->toDateString(),
                'quantity' => 100,
                'unit' => 'bushels',
                'price_per_unit' => 25.00,
            ]);

        $response->assertStatus(201);
        $harvest = $response->json('harvest');

        $this->actingAs($this->farmer)
            ->putJson("/api/harvests/{$harvest['id']}", [
                'harvest_date' => now()->toDateString(),
                'quantity' => 130,
                'unit' => 'bushels',
                'price_per_unit' => 25.00,
            ])
            ->assertStatus(200);

        $inventory = InventoryItem::where('user_id', $this->farmer->id)
            ->where('category', 'produce')
            ->where('unit', 'bushels')
            ->first();

        $this->assertNotNull($inventory);
        $this->assertEquals(130, (float) $inventory->fresh()->current_stock);

        $this->assertDatabaseHas('inventory_transactions', [
            'inventory_item_id' => $inventory->id,
            'reference_type' => 'Harvest',
            'reference_id' => $harvest['id'],
            'transaction_type' => 'in',
            'quantity' => '30.00',
        ]);
    }

    public function test_updating_harvester_share_syncs_crop_share_expense()
    {
        $response = $this->actingAs($this->farmer)
            ->postJson('/api/harvests', [
                'planting_id' => $this->planting->id,
                'harvest_date' => now()->toDateString(),
                'quantity' => 100,
                'unit' => 'bushels',
                'harvester_share' => 10,
                'harvester_share_percentage' => 10,
                'price_per_unit' => 20.00,
            ]);

        $response->assertStatus(201);
        $harvest = $response->json('harvest');

        $this->actingAs($this->farmer)
            ->putJson("/api/harvests/{$harvest['id']}", [
                'harvest_date' => now()->toDateString(),
                'quantity' => 100,
                'unit' => 'bushels',
                'harvester_share' => 15,
                'harvester_share_percentage' => 15,
                'price_per_unit' => 30.00,
            ])
            ->assertStatus(200);

        $expenses = Expense::where('related_entity_type', 'harvest')
            ->where('related_entity_id', $harvest['id'])
            ->where('payment_method', 'crop_share')
            ->get();

        $this->assertCount(1, $expenses);
        $this->assertEquals(450, (float) $expenses->first()->amount);
    }

    public function test_delete_harvest_reverses_inventory_and_expense()
    {
        $response = $this->actingAs($this->farmer)
            ->postJson('/api/harvests', [
                'planting_id' => $this->planting->id,
                'harvest_date' => now()->toDateString(),
                'quantity' => 100,
                'unit' => 'bushels',
                'harvester_share' => 10,
                'harvester_share_percentage' => 10,
                'price_per_unit' => 20.00,
            ]);

        $response->assertStatus(201);
        $harvest = $response->json('harvest');

        $inventory = InventoryItem::where('user_id', $this->farmer->id)
            ->where('category', 'produce')
            ->where('unit', 'bushels')
            ->first();

        $this->actingAs($this->farmer)
            ->deleteJson("/api/harvests/{$harvest['id']}")
            ->assertStatus(200);

        $this->assertEquals(0, (float) $inventory->fresh()->current_stock);
        $this->assertDatabaseMissing('expenses', [
            'related_entity_type' => 'harvest',
            'related_entity_id' => $harvest['id'],
            'payment_method' => 'crop_share',
        ]);
        $this->assertDatabaseHas('inventory_transactions', [
            'inventory_item_id' => $inventory->id,
            'reference_type' => 'Harvest',
            'reference_id' => $harvest['id'],
            'transaction_type' => 'out',
            'quantity' => '100.00',
        ]);
    }

    public function test_delete_harvest_is_blocked_when_processing_records_exist()
    {
        $response = $this->actingAs($this->farmer)
            ->postJson('/api/harvests', [
                'planting_id' => $this->planting->id,
                'harvest_date' => now()->toDateString(),
                'quantity' => 100,
                'unit' => 'bushels',
            ]);

        $response->assertStatus(201);
        $harvest = $response->json('harvest');

        PostHarvestProcess::create([
            'harvest_id' => $harvest['id'],
            'planting_id' => $this->planting->id,
            'user_id' => $this->farmer->id,
            'process_type' => PostHarvestProcess::TYPE_THRESHING,
            'status' => PostHarvestProcess::STATUS_PENDING,
            'input_quantity' => 100,
            'input_unit' => 'bushels',
            'process_date' => now()->toDateString(),
        ]);

        $this->actingAs($this->farmer)
            ->deleteJson("/api/harvests/{$harvest['id']}")
            ->assertStatus(422);
    }

    public function test_update_rejects_harvester_share_greater_than_quantity()
    {
        $response = $this->actingAs($this->farmer)
            ->postJson('/api/harvests', [
                'planting_id' => $this->planting->id,
                'harvest_date' => now()->toDateString(),
                'quantity' => 100,
                'unit' => 'bushels',
            ]);

        $response->assertStatus(201);
        $harvest = $response->json('harvest');

        $this->actingAs($this->farmer)
            ->putJson("/api/harvests/{$harvest['id']}", [
                'quantity' => 100,
                'unit' => 'bushels',
                'harvester_share' => 101,
                'harvester_share_percentage' => 50,
            ])
            ->assertStatus(422)
            ->assertJsonValidationErrors('harvester_share');
    }
}
