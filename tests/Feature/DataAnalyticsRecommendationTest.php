<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\RiceProduct;
use App\Models\RiceOrder;
use App\Models\Farm;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class DataAnalyticsRecommendationTest extends TestCase
{
    use RefreshDatabase;

    public function test_analytics_recommendations_are_generated_for_farmer()
    {
        // 1. Create a farmer with a farm (required for analytics)
        $farmer = User::factory()->create(['role' => 'farmer']);
        Farm::factory()->create(['user_id' => $farmer->id]);

        // 2. Authenticate as the farmer
        $this->actingAs($farmer);

        // 3. Call the analytics endpoint
        $response = $this->getJson('/api/analytics/data-analysis');

        $response->assertStatus(200);

        // 4. Verify action_suggestions are present
        $suggestions = $response->json('action_suggestions');
        $this->assertIsArray($suggestions);
        $this->assertNotEmpty($suggestions, 'Action suggestions should always be generated');

        // 5. Each suggestion should have the required structure
        foreach ($suggestions as $suggestion) {
            $this->assertArrayHasKey('icon', $suggestion);
            $this->assertArrayHasKey('category', $suggestion);
            $this->assertArrayHasKey('message', $suggestion);
            $this->assertArrayHasKey('priority', $suggestion);
            $this->assertArrayHasKey('action_url', $suggestion);
        }
    }
}
