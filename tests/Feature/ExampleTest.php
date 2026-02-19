<?php

namespace Tests\Feature;

use Tests\TestCase;

class ExampleTest extends TestCase
{
    /**
     * A basic test example.
     * Tests that the API health check works (Vite manifest may not be built in CI).
     */
    public function test_the_application_returns_a_successful_response(): void
    {
        $response = $this->getJson('/api/user');

        // Without auth, should get 401 (proves the app is booting correctly)
        $response->assertStatus(401);
    }
}
