<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\RiceProduct;
use App\Models\RiceOrder;
use App\Models\Field;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class DataAnalyticsRecommendationTest extends TestCase
{
    use RefreshDatabase;

    public function test_analytics_recommendation_counts_only_pending_orders_and_has_correct_link()
    {
        // 1. Create a farmer
        $farmer = User::factory()->create(['role' => 'farmer']);

        // 2. Create a product for the farmer
        $product = RiceProduct::factory()->create([
            'farmer_id' => $farmer->id,
            'price_per_unit' => 100
        ]);

        $buyer = User::factory()->create(['role' => 'buyer']);

        // 3. Create orders with different statuses
        // 2 Pending orders (These should be counted)
        RiceOrder::create([
            'buyer_id' => $buyer->id,
            'rice_product_id' => $product->id,
            'status' => 'pending',
            'quantity' => 10,
            'total_amount' => 1000,
            'unit_price' => 100,
            'order_date' => now(),
            'payment_status' => 'pending',
            'delivery_address' => json_encode(['address' => '123 Test St']),
            'delivery_method' => 'pickup',
            'payment_method' => 'cash'
        ]);
        RiceOrder::create([
            'buyer_id' => $buyer->id,
            'rice_product_id' => $product->id,
            'status' => 'pending',
            'quantity' => 10,
            'total_amount' => 1000,
            'unit_price' => 100,
            'order_date' => now(),
            'payment_status' => 'pending',
            'delivery_address' => json_encode(['address' => '123 Test St']),
            'delivery_method' => 'pickup',
            'payment_method' => 'cash'
        ]);

        // 1 Confirmed order (This should NOT be counted)
        RiceOrder::create([
            'buyer_id' => $buyer->id,
            'rice_product_id' => $product->id,
            'status' => 'confirmed',
            'quantity' => 10,
            'total_amount' => 1000,
            'unit_price' => 100,
            'order_date' => now(),
            'payment_status' => 'paid',
            'delivery_address' => json_encode(['address' => '123 Test St']),
            'delivery_method' => 'pickup',
            'payment_method' => 'cash'
        ]);

        // 1 Delivered order (This should NOT be counted)
        RiceOrder::create([
            'buyer_id' => $buyer->id,
            'rice_product_id' => $product->id,
            'status' => 'delivered',
            'quantity' => 10,
            'total_amount' => 1000,
            'unit_price' => 100,
            'order_date' => now(),
            'payment_status' => 'paid',
            'delivery_address' => json_encode(['address' => '123 Test St']),
            'delivery_method' => 'pickup',
            'payment_method' => 'cash'
        ]);

        // Authenticate as the farmer
        $this->actingAs($farmer);

        // 4. Call the analytics endpoint
        // Note: The endpoint is /api/analytics/data-analysis
        $response = $this->getJson('/api/analytics/data-analysis');

        $response->assertStatus(200);

        // 5. Inspect the action suggestions
        $suggestions = $response->json('action_suggestions');

        // Find the "Fulfill pending marketplace orders" suggestion
        $orderSuggestion = null;
        foreach ($suggestions as $suggestion) {
            if ($suggestion['category'] === 'sales' && str_contains($suggestion['message'], 'Fulfill')) {
                $orderSuggestion = $suggestion;
                break;
            }
        }

        $this->assertNotNull($orderSuggestion, 'Sales suggestion not found');

        // 6. Assert correct count (Should be 2, not 3)
        $this->assertStringContainsString('Fulfill 2 pending marketplace orders', $orderSuggestion['message']);

        // 7. Assert correct URL
        $this->assertEquals('/farmer/orders', $orderSuggestion['action_url']);
    }
}
