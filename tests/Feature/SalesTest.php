<?php

namespace Tests\Feature;

use App\Models\Harvest;
use App\Models\Planting;
use App\Models\User;
use App\Models\Field;
use App\Models\Buyer;
use App\Models\Crop;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class SalesTest extends TestCase
{
    use RefreshDatabase;

    public function test_can_record_sale_with_sacks_unit()
    {
        // 1. Create a farmer
        $farmer = User::factory()->create(['role' => 'farmer']);

        // 2. Create a buyer
        $buyer = Buyer::create([
            'user_id' => $farmer->id,
            'name' => 'Test Buyer',
            'email' => 'test@example.com',
            'phone' => '09123456789',
            'contact_info' => 'Test Contact Info',
            'address' => 'Test Address'
        ]);

        // 3. Create a Field
        $field = Field::factory()->create(['user_id' => $farmer->id]);

        // 4. Create a Planting
        $planting = Planting::factory()->create([
            'field_id' => $field->id,
            // Controller checks: $harvest->planting->field->user_id
        ]);

        // 5. Create a Harvest with 'sacks' unit
        $harvest = Harvest::factory()->create([
            'planting_id' => $planting->id,
            'quantity' => 10,
            'unit' => 'sacks',
            'quality_grade' => 'A'
        ]);

        // 6. Attempt to create a sale
        $response = $this->actingAs($farmer)->postJson('/api/sales', [
            'harvest_id' => $harvest->id,
            'buyer_id' => $buyer->id,
            'quantity' => 5, // 5 sacks
            'unit_price' => 1000,
            'total_amount' => 5000,
            'sale_date' => now()->toDateString(),
            'payment_method' => 'cash',
            'payment_status' => 'paid',
            'notes' => 'Test sale'
        ]);

        $response->assertStatus(201);
        $response->assertJsonPath('sale.quantity', '5.00');
    }

    public function test_sales_validation_failure_returns_errors()
    {
        $farmer = User::factory()->create(['role' => 'farmer']);

        // Attempt to create sale with missing data
        $response = $this->actingAs($farmer)->postJson('/api/sales', [
            // Missing all required fields
        ]);

        $response->assertStatus(422)
            ->assertJsonStructure([
                'message',
                'errors' => [
                    'harvest_id',
                    'buyer_id',
                    'quantity',
                    'unit_price',
                    'total_amount',
                    // etc
                ]
            ]);
    }
}
