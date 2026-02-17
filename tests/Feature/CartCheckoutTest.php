<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\InventoryItem;
use App\Models\RiceProduct;
use App\Models\RiceVariety;
use App\Models\CartItem;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class CartCheckoutTest extends TestCase
{
    use RefreshDatabase;

    protected $farmer;
    protected $buyer;
    protected $inventoryItem;
    protected $product;

    protected function setUp(): void
    {
        parent::setUp();

        // Create farmer and buyer
        $this->farmer = User::factory()->create(['role' => 'farmer']);
        $this->buyer = User::factory()->create(['role' => 'buyer']);

        // Create Rice Variety
        $variety = RiceVariety::factory()->create();

        // Create Inventory Item (100kg available)
        $this->inventoryItem = InventoryItem::create([
            'user_id' => $this->farmer->id,
            'name' => 'Test Rice',
            'category' => InventoryItem::CATEGORY_PRODUCE,
            'current_stock' => 100,
            'unit_price' => 50,
            'unit' => 'kg'
        ]);

        // Create Rice Product linked to Inventory Item (50kg for sale)
        $this->product = RiceProduct::create([
            'farmer_id' => $this->farmer->id,
            'rice_variety_id' => $variety->id,
            'inventory_item_id' => $this->inventoryItem->id,
            'name' => 'Test Rice Product',
            'description' => 'A test description',
            'quantity_available' => 50,
            'price_per_unit' => 60,
            'unit' => 'kg',
            'quality_grade' => RiceProduct::GRADE_PREMIUM,
            'production_status' => RiceProduct::STATUS_AVAILABLE,
            'is_available' => true,
            'harvest_date' => now()->subDays(10), // Add potentially required date
        ]);
    }

    /** @test */
    public function checkout_deducts_inventory_stock()
    {
        // Add item to cart
        CartItem::create([
            'buyer_id' => $this->buyer->id,
            'rice_product_id' => $this->product->id,
            'quantity' => 10
        ]);

        // Access as buyer
        $response = $this->actingAs($this->buyer)
            ->postJson('/api/rice-marketplace/cart/checkout', [
                'delivery_address' => ['address' => '123 Buyer St'],
                'delivery_method' => 'pickup',
                'payment_method' => 'cash',
                'notes' => 'Test order'
            ]);

        $response->assertStatus(200);

        // Assert Product quantity is reduced (50 - 10 = 40)
        $this->assertEquals(40, $this->product->fresh()->quantity_available, 'Product quantity should be reduced');

        // Assert Inventory Item stock is reduced (100 - 10 = 90)
        // THIS IS EXPECTED TO FAIL CURRENTLY
        $this->assertEquals(90, $this->inventoryItem->fresh()->current_stock, 'Inventory stock should be reduced');
    }
}
