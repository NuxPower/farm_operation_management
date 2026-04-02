<?php

namespace Tests\Feature;

use App\Models\Farm;
use App\Models\Field;
use App\Models\Harvest;
use App\Models\InventoryItem;
use App\Models\Planting;
use App\Models\PostHarvestProcess;
use App\Models\RiceVariety;
use App\Models\Task;
use App\Models\User;
use App\Models\Expense;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class PostHarvestProcessTest extends TestCase
{
    use RefreshDatabase;

    private User $farmer;
    private Farm $farm;
    private Harvest $harvest;

    protected function setUp(): void
    {
        parent::setUp();

        $this->farmer = User::factory()->create(['role' => 'farmer']);
        
        $this->farm = Farm::factory()->create([
            'user_id' => $this->farmer->id
        ]);
        
        $field = Field::factory()->create([
            'farm_id' => $this->farm->id,
            'user_id' => $this->farmer->id,
            'size' => 2.5
        ]);

        $variety = RiceVariety::factory()->create(['name' => 'NSIC Rc222']);

        $planting = Planting::factory()->create([
            'field_id' => $field->id,
            'rice_variety_id' => $variety->id,
            'crop_type' => 'rice',
            'status' => 'harvested'
        ]);

        // Harvest 1000kg
        $this->harvest = Harvest::factory()->create([
            'planting_id' => $planting->id,
            'quantity' => 1000,
            'unit' => 'kg',
            'quality_grade' => 'A'
        ]);
        
        // Setup initial inventory that would have been created by Harvest completion
        InventoryItem::create([
            'user_id' => $this->farmer->id,
            'name' => 'NSIC Rc222 (Grade A)',
            'category' => InventoryItem::CATEGORY_PRODUCE,
            'unit' => 'kg',
            'current_stock' => 1000,
            'unit_price' => 20
        ]);
    }

    public function test_farmer_can_view_post_harvest_pipeline()
    {
        PostHarvestProcess::create([
            'harvest_id' => $this->harvest->id,
            'planting_id' => $this->harvest->planting_id,
            'user_id' => $this->farmer->id,
            'process_type' => PostHarvestProcess::TYPE_THRESHING,
            'input_quantity' => 1000,
            'input_unit' => 'kg',
            'process_date' => now(),
            'status' => PostHarvestProcess::STATUS_PENDING
        ]);

        $response = $this->actingAs($this->farmer)
            ->getJson("/api/post-harvest/harvest/{$this->harvest->id}");

        $response->assertStatus(200)
            ->assertJsonCount(1, 'processes')
            ->assertJsonPath('processes.0.process_type', 'threshing')
            ->assertJsonStructure(['summary', 'harvest']);
    }

    public function test_farmer_can_create_post_harvest_process()
    {
        $response = $this->actingAs($this->farmer)
            ->postJson('/api/post-harvest', [
                'harvest_id' => $this->harvest->id,
                'process_type' => PostHarvestProcess::TYPE_THRESHING,
                'process_date' => now()->toDateString(),
                'input_quantity' => 1000,
                'input_unit' => 'kg',
                'cost_type' => PostHarvestProcess::COST_TYPE_SERVICE_FIXED,
                'cost' => 500,
                'service_provider' => 'Juan Mill'
            ]);

        $response->assertStatus(201)
            ->assertJsonPath('process.process_type', 'threshing');

        $this->assertDatabaseHas('post_harvest_processes', [
            'harvest_id' => $this->harvest->id,
            'process_type' => 'threshing',
            'cost' => 500
        ]);
    }

    public function test_completing_process_deducts_and_adds_inventory_with_expense()
    {
        $process = PostHarvestProcess::create([
            'harvest_id' => $this->harvest->id,
            'planting_id' => $this->harvest->planting_id,
            'user_id' => $this->farmer->id,
            'process_type' => PostHarvestProcess::TYPE_DRYING,
            'input_quantity' => 1000, // Palay
            'input_unit' => 'kg',
            'process_date' => now(),
            'status' => PostHarvestProcess::STATUS_PENDING,
            'cost' => 1000, // ₱1000 fee
            'cost_type' => PostHarvestProcess::COST_TYPE_SERVICE_FIXED,
            'service_provider' => 'Solar Solar'
        ]);

        $response = $this->actingAs($this->farmer)
            ->postJson("/api/post-harvest/{$process->id}/complete", [
                'output_quantity' => 820, // 18% moisture loss
                'output_unit' => 'kg',
                'completed_date' => now()->toDateString()
            ]);

        $response->assertStatus(200);

        // Verify Database updates
        $this->assertDatabaseHas('post_harvest_processes', [
            'id' => $process->id,
            'status' => PostHarvestProcess::STATUS_COMPLETED,
            'weight_loss_percentage' => 18.00 // (1000-820)/1000
        ]);

        // Verify Source Inventory (Palay) is deducted
        $this->assertDatabaseHas('inventory_items', [
            'user_id' => $this->farmer->id,
            'name' => 'NSIC Rc222 (Grade A)',
            'current_stock' => 0 // Deducted 1000
        ]);

        // Verify Output Inventory (Dried Palay) is added
        $this->assertDatabaseHas('inventory_items', [
            'user_id' => $this->farmer->id,
            'name' => 'NSIC Rc222 - Dried (Grade A)',
            'current_stock' => 820
        ]);

        // Verify Expense created
        $this->assertDatabaseHas('expenses', [
            'user_id' => $this->farmer->id,
            'category' => Expense::CATEGORY_PROCESSING,
            'amount' => 1000,
            'related_entity_type' => 'post_harvest_process',
            'related_entity_id' => $process->id
        ]);
        
        // Verify Inventory Transactions (both IN and OUT)
        $this->assertDatabaseHas('inventory_transactions', [
            'reference_type' => 'PostHarvestProcess',
            'reference_id' => $process->id,
            'transaction_type' => 'out',
            'quantity' => 1000
        ]);
        
        $this->assertDatabaseHas('inventory_transactions', [
            'reference_type' => 'PostHarvestProcess',
            'reference_id' => $process->id,
            'transaction_type' => 'in',
            'quantity' => 820
        ]);
    }

    public function test_post_harvest_efficiency_endpoint_reported_correctly()
    {
        $process = PostHarvestProcess::create([
            'harvest_id' => $this->harvest->id,
            'planting_id' => $this->harvest->planting_id,
            'user_id' => $this->farmer->id,
            'process_type' => PostHarvestProcess::TYPE_DRYING,
            'input_quantity' => 1000,
            'input_unit' => 'kg',
            'process_date' => now(),
            'status' => PostHarvestProcess::STATUS_PENDING,
            'cost' => 1000,
            'cost_type' => PostHarvestProcess::COST_TYPE_SERVICE_FIXED,
            'service_provider' => 'Solar Solar'
        ]);

        $this->actingAs($this->farmer)
            ->postJson("/api/post-harvest/{$process->id}/complete", [
                'output_quantity' => 820,
                'output_unit' => 'kg',
                'completed_date' => now()->toDateString(),
            ])
            ->assertStatus(200);

        $response = $this->actingAs($this->farmer)
            ->getJson("/api/post-harvest/harvest/{$this->harvest->id}/efficiency");

        $response->assertStatus(200)
            ->assertJsonPath('efficiency.overall_recovery_rate', 82)
            ->assertJsonPath('efficiency.average_weight_loss_percentage', 18)
            ->assertJsonPath('efficiency.cost_per_output_unit', 1.22)
            ->assertJsonPath('efficiency.total_cost', 1000)
            ->assertJsonPath('efficiency.final_quantity', 820)
            ->assertJsonPath('efficiency.efficiency_breakdown.0.type', 'drying');
    }

    public function test_marketplace_product_creation_prefers_latest_processed_inventory_item()
    {
        $process = PostHarvestProcess::create([
            'harvest_id' => $this->harvest->id,
            'planting_id' => $this->harvest->planting_id,
            'user_id' => $this->farmer->id,
            'process_type' => PostHarvestProcess::TYPE_MILLING,
            'input_quantity' => 1000,
            'input_unit' => 'kg',
            'process_date' => now(),
            'status' => PostHarvestProcess::STATUS_PENDING,
        ]);

        $this->actingAs($this->farmer)
            ->postJson("/api/post-harvest/{$process->id}/complete", [
                'output_quantity' => 650,
                'output_unit' => 'kg',
                'completed_date' => now()->toDateString(),
            ])
            ->assertStatus(200);

        $milledInventoryId = InventoryItem::where('user_id', $this->farmer->id)
            ->where('name', 'NSIC Rc222 - Milled (Grade A)')
            ->value('id');

        $this->assertNotNull($milledInventoryId, 'Expected the milled inventory item to be created after completion.');

        $response = $this->actingAs($this->farmer)
            ->postJson('/api/rice-marketplace/products', [
                'rice_variety_id' => $this->harvest->planting->rice_variety_id,
                'harvest_id' => $this->harvest->id,
                'name' => 'Farm Fresh Rc222 Rice',
                'description' => 'Freshly processed rice ready for sale.',
                'quantity_available' => 650,
                'unit' => 'kg',
                'price_per_unit' => 48,
                'quality_grade' => 'premium',
                'processing_method' => 'milled',
            ]);

        $response->assertStatus(201)
            ->assertJsonPath('product.inventory_item_id', $milledInventoryId);
    }
}
