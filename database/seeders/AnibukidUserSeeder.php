<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Farm;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class AnibukidUserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // 1. Create User (Anibukid Farm)
        // Using updateOrCreate to ensure idempotency
        $user = User::updateOrCreate(
            ['email' => 'anibukidfarm@gmail.com'],
            [
                'name' => 'Anibukid Farm',
                'first_name' => 'Anibukid',
                'last_name' => 'Farm',
                'email_verified_at' => now(),
                // Password hash from user request (bcrypt hash for 'password' or similar, assuming it's valid)
                // If this hash is for a known password, great. If not, this might lock them out if they don't know the source.
                // However, I will use the hash provided.
                'password' => '$2y$12$t9vqtpYuVhzpchLYaHRfrOfxZpbXl2ihecc3D1py8MGqhg4SnObyS',
                'role' => 'farmer',
                'phone' => '(+63) 997 516 2375',
                'address' => [
                    'farm_location' => 'Managok, City of Malaybalay, Bukidnon',
                    'total_area' => 10,
                    'rice_area' => 10,
                    'farming_experience' => 40
                ],
                'phone_verified_at' => now(),
                'bio' => 'Rice farm in Managok, Malaybalay City, Bukidnon',
            ]
        );

        echo "User 'Anibukid Farm' seeded.\n";

        // 2. Create Farm Record (Required for WeatherSeeder)
        // WeatherSeeder iterates farms to get coordinates.
        Farm::updateOrCreate(
            ['user_id' => $user->id],
            [
                'name' => 'Anibukid Farm',
                'location' => 'Managok, Malaybalay City, Bukidnon',
                // Coordinates for Managok, Malaybalay
                'farm_coordinates' => ['lat' => 8.0276, 'lon' => 125.1885],
                'total_area' => 10.0,
                'cultivated_area' => 10.0,
                'description' => 'Rice farm in Managok, Malaybalay City, Bukidnon',
                'is_setup_complete' => true,
            ]
        );

        echo "Farm 'Anibukid Farm' record seeded with coordinates.\n";
    }
}
