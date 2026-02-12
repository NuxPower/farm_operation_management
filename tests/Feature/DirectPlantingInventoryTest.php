<?php

namespace Tests\Feature;

use App\Models\Field;
use App\Models\InventoryItem;
use App\Models\RiceVariety;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class DirectPlantingInventoryTest extends TestCase
{
    use RefreshDatabase;

    protected $user;
    protected $field;
    protected $variety;
    protected $inventoryItem;

    protected function setUp(): void
    {
        parent::setUp();
        $this->user = User::factory()->create(['role' => 'farmer']);
        $this->field = Field::factory()->create(['user_id' => $this->user->id]);
        $this->variety = RiceVariety::factory()->create();

        // Create an inventory item (seeds)
        $this->inventoryItem = InventoryItem::factory()->create([
            'user_id' => $this->user->id,
            'category' => 'seeds',
            'name' => 'Test Seeds',
            'current_stock' => 100,
            'unit' => 'kg',
            'cost_per_unit' => 50
        ]);
    }

    public function test_direct_planting_deducts_inventory()
    {
        $payload = [
            'field_id' => $this->field->id,
            'rice_variety_id' => $this->variety->id,
            'planting_date' => now()->toDateString(),
            'planting_method' => 'direct_seeding',
            'area_planted' => 1,
            'seed_rate' => 20, // 20kg
            'seed_unit' => 'kg',
            'inventory_item_id' => $this->inventoryItem->id, // Frontend sends this
            'notes' => 'Test Direct Planting'
        ];

        $response = $this->actingAs($this->user)
            ->postJson('/api/plantings', $payload);

        $response->assertStatus(201);

        // Check if planting was created
        $this->assertDatabaseHas('plantings', [
            'field_id' => $this->field->id,
            'rice_variety_id' => $this->variety->id,
            'seed_rate' => 20,
        ]);

        // Check if inventory was deducted (Should contain 80)
        $this->assertDatabaseHas('inventory_items', [
            'id' => $this->inventoryItem->id,
            'current_stock' => 80,
        ]);

        // Check if transaction was recorded
        $this->assertDatabaseHas('inventory_transactions', [
            'inventory_item_id' => $this->inventoryItem->id,
            'transaction_type' => 'out',
            'quantity' => 20,
            'reference_type' => 'Planting',
        ]);
    }

    public function test_planting_fails_if_insufficient_stock()
    {
        // Try to consume 150kg (only 100 available)
        $payload = [
            'field_id' => $this->field->id,
            'rice_variety_id' => $this->variety->id,
            'planting_date' => now()->toDateString(),
            'planting_method' => 'direct_seeding',
            'area_planted' => 1,
            'seed_rate' => 150,
            'seed_unit' => 'kg',
            'inventory_item_id' => $this->inventoryItem->id,
        ];

        $response = $this->actingAs($this->user)
            ->postJson('/api/plantings', $payload);

        // Expect validation error or 422
        $response->assertStatus(422);

        // Stock should remain 100
        $this->assertDatabaseHas('inventory_items', [
            'id' => $this->inventoryItem->id,
            'current_stock' => 100,
        ]);
    }
}
