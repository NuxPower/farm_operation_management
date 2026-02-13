<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class ReseedSeeder extends Seeder
{
    /**
     * Run the database seeds in the correct dependency order.
     */
    public function run(): void
    {
        // 1. Core Lookups
        $this->call([
            RiceVarietySeeder::class,
            RiceGrowthStageSeeder::class,
            PestLibrarySeeder::class,
        ]);

        // 2. User & Farm Structure
        $this->call([
            AnibukidUserSeeder::class,
        ]);

        // 3. Operational Data (Weather)
        // Depends on Farm existing (created by AnibukidUserSeeder)
        $this->call([
            WeatherSeeder::class,
        ]);
    }
}
