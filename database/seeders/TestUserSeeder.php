<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class TestUserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $email = 'test@example.com';

        if (!User::where('email', $email)->exists()) {
            User::create([
                'name' => 'Test User',
                'first_name' => 'Test',
                'last_name' => 'User',
                'email' => $email,
                'password' => Hash::make('password'),
                'role' => 'buyer',
                'phone' => '09123456789',
                'phone_verified_at' => now(),
            ]);
            $this->command->info("User {$email} created.");
        } else {
            $this->command->info("User {$email} already exists.");
        }
    }
}
