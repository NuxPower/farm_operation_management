<?php

namespace Tests\Feature;

use App\Models\RiceOrder;
use App\Models\RiceProduct;
use App\Models\User;
use App\Models\CartItem;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;

class OrderBatchTest extends TestCase
{
    use DatabaseTransactions;

    public function test_checkout_creates_orders_with_same_group_id()
    {
        // 1. Setup Data
        $farmer = User::factory()->create(['role' => 'farmer']);
        $buyer = User::factory()->create(['role' => 'buyer']);

        // Create 2 products
        $product1 = RiceProduct::factory()->create([
            'farmer_id' => $farmer->id,
            'quantity_available' => 100,
            'price_per_unit' => 10,
            'is_available' => true,
        ]);

        $product2 = RiceProduct::factory()->create([
            'farmer_id' => $farmer->id,
            'quantity_available' => 100,
            'price_per_unit' => 20,
            'is_available' => true,
        ]);

        // Add both to cart
        CartItem::create([
            'buyer_id' => $buyer->id,
            'rice_product_id' => $product1->id,
            'quantity' => 5,
        ]);

        CartItem::create([
            'buyer_id' => $buyer->id,
            'rice_product_id' => $product2->id,
            'quantity' => 2,
        ]);

        // 2. Act: Checkout
        $response = $this->actingAs($buyer)->postJson('/api/rice-marketplace/cart/checkout', [
            'delivery_address' => ['street' => '123 Test St', 'city' => 'Test', 'country' => 'PH'],
            'delivery_method' => 'pickup',
            'payment_method' => 'cod',
        ]);

        // 3. Assert
        $response->assertStatus(200);

        // Get the orders created
        $orders = RiceOrder::where('buyer_id', $buyer->id)->get();

        $this->assertCount(2, $orders);

        $groupId = $orders[0]->checkout_group_id;
        $this->assertNotNull($groupId, "Checkout group ID should not be null");
        $this->assertEquals($groupId, $orders[1]->checkout_group_id, "Both orders should have the same checkout group ID");

        // Verify response contains group info if creating from API structure
    }
}
