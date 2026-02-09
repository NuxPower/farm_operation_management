<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\RiceProduct;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class GuestMarketplaceBrowsingTest extends TestCase
{
    use RefreshDatabase;

    public function test_guest_can_view_product_list()
    {
        $product = RiceProduct::factory()->create();

        $response = $this->getJson('/api/rice-marketplace/products');

        $response->assertStatus(200);
    }

    public function test_guest_can_view_product_detail()
    {
        $product = RiceProduct::factory()->create();

        $response = $this->getJson("/api/rice-marketplace/products/{$product->id}");

        $response->assertStatus(200);
    }

    public function test_guest_can_view_product_reviews()
    {
        $product = RiceProduct::factory()->create();

        $response = $this->getJson("/api/rice-marketplace/products/{$product->id}/reviews");

        $response->assertStatus(200);
    }

    public function test_guest_can_view_marketplace_stats()
    {
        $response = $this->getJson('/api/rice-marketplace/stats');

        $response->assertStatus(200);
    }

    public function test_guest_cannot_add_to_cart()
    {
        $product = RiceProduct::factory()->create();

        $response = $this->postJson('/api/rice-marketplace/cart', [
            'rice_product_id' => $product->id,
            'quantity' => 1
        ]);

        $response->assertStatus(401);
    }

    public function test_guest_cannot_add_to_favorites()
    {
        $product = RiceProduct::factory()->create();

        $response = $this->postJson('/api/rice-marketplace/favorites', [
            'rice_product_id' => $product->id
        ]);

        $response->assertStatus(401);
    }

    public function test_authenticated_buyer_can_add_to_cart()
    {
        $buyer = User::factory()->create(['role' => 'buyer']);
        $product = RiceProduct::factory()->create();

        $response = $this->actingAs($buyer)
            ->postJson('/api/rice-marketplace/cart', [
                'rice_product_id' => $product->id,
                'quantity' => 2
            ]);

        $response->assertStatus(200);
    }
}
