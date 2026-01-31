<?php

namespace Tests\Feature;

use App\Models\Harvest;
use App\Models\Planting;
use App\Models\User;
use App\Models\Field;
use App\Models\Buyer;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class SalesTest extends TestCase
{
    use RefreshDatabase;

    public function test_can_create_buyer_and_record_sale()
    {
        // 1. Create a farmer
        $farmer = User::factory()->create(['role' => 'farmer']);

        // 2. Create the necessary farm data
        $field = Field::factory()->create(['user_id' => $farmer->id]);
        $planting = Planting::factory()->create([
            'field_id' => $field->id,
        ]);
        $harvest = Harvest::factory()->create([
            'planting_id' => $planting->id,
            'quantity' => 100,
            'unit' => 'sacks',
            'quality_grade' => 'A'
        ]);

        // 3. Step 1: Create Buyer via API (mimicking frontend "Quick Add Buyer")
        $buyerData = [
            'name' => 'New API Buyer',
            'phone' => '09123456789',
            'type' => 'individual',
            'address' => '123 Farm Lane',
            'status' => 'active'
        ];

        $buyerResponse = $this->actingAs($farmer)->postJson('/api/buyers', $buyerData);

        $buyerResponse->assertStatus(201);
        $buyerId = $buyerResponse->json('buyer.id');
        $this->assertNotNull($buyerId);

        // 4. Step 2: Record Sale using the new Buyer ID
        $saleData = [
            'harvest_id' => $harvest->id,
            'buyer_id' => $buyerId,
            'quantity' => 10,
            'unit_price' => 500,
            'total_amount' => 5000,
            'sale_date' => now()->toDateString(),
            'payment_method' => 'cash',
            'payment_status' => 'paid',
            'notes' => 'Sold to new API buyer'
        ];

        $saleResponse = $this->actingAs($farmer)->postJson('/api/sales', $saleData);

        if ($saleResponse->status() !== 201) {
            $saleResponse->dump();
        }

        $saleResponse->assertStatus(201);
        $saleResponse->assertJsonPath('sale.buyer_id', $buyerId);
    }

    public function test_validates_missing_fields()
    {
        $farmer = User::factory()->create(['role' => 'farmer']);

        $response = $this->actingAs($farmer)->postJson('/api/sales', []);

        $response->assertStatus(422);
        $response->assertJsonValidationErrors(['harvest_id', 'buyer_id', 'quantity', 'unit_price']);
    }
}
