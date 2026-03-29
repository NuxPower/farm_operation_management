<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\Field;
use App\Models\Planting;
use App\Models\RiceVariety;
use App\Models\Expense;
use App\Models\InventoryItem;
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
                'unit' => 'sacks',
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
                'unit' => 'sacks',
                'harvester_share' => 11.11,
                'harvester_share_percentage' => 11.11,
                'price_per_unit' => 25.00,
            ]);

        $response->assertStatus(201);

        // Check that inventory has the full 100 sacks, not 88.89
        $inventory = InventoryItem::where('user_id', $this->farmer->id)
            ->where('category', 'produce')
            ->where('unit', 'sacks')
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
                'unit' => 'sacks',
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
                'unit' => 'sacks',
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
}
