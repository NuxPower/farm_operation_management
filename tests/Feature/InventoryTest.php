<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\InventoryItem;
use App\Models\InventoryTransaction;
use App\Models\Expense;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class InventoryTest extends TestCase
{
    use RefreshDatabase;

    protected $farmer;

    protected function setUp(): void
    {
        parent::setUp();
        // Create a farmer user
        $this->farmer = User::factory()->create(['role' => 'farmer']);
    }

    protected function tearDown(): void
    {
        if ($this->farmer) {
            // Clean up created items
            InventoryItem::where('user_id', $this->farmer->id)->delete();
            Expense::where('user_id', $this->farmer->id)->delete();
            $this->farmer->delete();
        }
        parent::tearDown();
    }

    public function test_can_create_inventory_item()
    {
        $itemData = [
            'name' => 'Test Fertilizer',
            'category' => 'fertilizer',
            'unit' => 'bag',
            'current_stock' => 10,
            'unit_price' => 500,
            'supplier' => 'Test Supplier',
        ];

        $response = $this->actingAs($this->farmer)
            ->postJson('/api/inventory', $itemData);

        $response->assertStatus(201)
            ->assertJsonPath('inventory_item.name', 'Test Fertilizer')
            ->assertJsonPath('inventory_item.current_stock', '10.00'); // DB returns string for decimal

        // Verify Expense created for initial stock
        $this->assertDatabaseHas('expenses', [
            'user_id' => $this->farmer->id,
            'amount' => 5000, // 10 * 500
            'description' => 'Initial Stock: Test Fertilizer (10 packets)', // 'bag' normalized to 'packets' in controller? let's check controller logic
            // Controller mapping: 'bag' -> 'packets'.
        ]);

        // Actually, let's just check the amount and user_id, description might vary slightly
        // Controller: 'Initial Stock: {$inventoryItem->name} ({$currentStock} {$inventoryItem->unit})'
    }

    public function test_can_list_items()
    {
        InventoryItem::factory()->create(['user_id' => $this->farmer->id, 'name' => 'Item A']);
        InventoryItem::factory()->create(['user_id' => $this->farmer->id, 'name' => 'Item B']);

        $response = $this->actingAs($this->farmer)
            ->getJson('/api/inventory');

        $response->assertStatus(200)
            ->assertJsonCount(2, 'inventory_items');
    }

    public function test_can_add_stock_API()
    {
        $item = InventoryItem::factory()->create([
            'user_id' => $this->farmer->id,
            'current_stock' => 5,
            'unit_price' => 100
        ]);

        $response = $this->actingAs($this->farmer)
            ->postJson("/api/inventory/{$item->id}/add-stock", [
                'quantity' => 10,
                'unit_cost' => 120,
                'create_expense' => true,
                'expense_category' => 'other' // Changed to a likely safe value
            ]);

        $response->assertStatus(200);

        $this->assertEquals(15, $item->fresh()->current_stock, 'Stock should increase');

        $this->assertDatabaseHas('expenses', [
            'user_id' => $this->farmer->id,
            'amount' => 1200, // 10 * 120
            'related_entity_id' => $item->id
        ]);
    }

    public function test_can_remove_stock_and_log_transaction()
    {
        $item = InventoryItem::factory()->create([
            'user_id' => $this->farmer->id,
            'category' => InventoryItem::CATEGORY_TOOLS,
            'current_stock' => 10,
            'unit_price' => 50,
        ]);

        $response = $this->actingAs($this->farmer)
            ->postJson("/api/inventory/{$item->id}/remove-stock", [
                'quantity' => 4,
            ]);

        $response->assertStatus(200)
            ->assertJsonPath('inventory_item.current_stock', '6.00');

        $this->assertDatabaseHas('inventory_transactions', [
            'inventory_item_id' => $item->id,
            'user_id' => $this->farmer->id,
            'transaction_type' => 'out',
            'quantity' => 4,
            'reference_type' => 'Manual',
            'notes' => 'Manual stock removal',
        ]);
    }

    public function test_remove_stock_blocks_insufficient_stock()
    {
        $item = InventoryItem::factory()->create([
            'user_id' => $this->farmer->id,
            'current_stock' => 3,
        ]);

        $response = $this->actingAs($this->farmer)
            ->postJson("/api/inventory/{$item->id}/remove-stock", [
                'quantity' => 4,
            ]);

        $response->assertStatus(422)
            ->assertJsonPath('message', "Insufficient stock. Available: {$item->current_stock} {$item->unit}");

        $this->assertEquals(3, (float) $item->fresh()->current_stock);
        $this->assertSame(0, InventoryTransaction::where('inventory_item_id', $item->id)->count());
    }

    public function test_tools_are_treated_as_low_stock_inventory()
    {
        InventoryItem::factory()->create([
            'user_id' => $this->farmer->id,
            'category' => InventoryItem::CATEGORY_TOOLS,
            'name' => 'Pruning Shears',
            'current_stock' => 1,
            'minimum_stock' => 2,
        ]);

        InventoryItem::factory()->create([
            'user_id' => $this->farmer->id,
            'category' => InventoryItem::CATEGORY_PRODUCE,
            'name' => 'Milled Rice',
            'current_stock' => 1,
            'minimum_stock' => 2,
        ]);

        $response = $this->actingAs($this->farmer)
            ->getJson('/api/inventory/alerts/low-stock');

        $response->assertStatus(200)
            ->assertJsonCount(1, 'low_stock_items')
            ->assertJsonPath('low_stock_items.0.category', InventoryItem::CATEGORY_TOOLS);
    }
}
