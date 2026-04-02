<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Ensure a valid rice variety exists for backfill.
        $defaultVariety = DB::table('rice_varieties')->where('name', 'Unknown')->first();

        if (!$defaultVariety) {
            DB::table('rice_varieties')->insert([
                'name' => 'Unknown',
                'variety_code' => 'UNKNOWN',
                'description' => 'Placeholder variety created during migration to avoid null plantings',
                'maturity_days' => 90,
                'average_yield_per_hectare' => 1.00,
                'season' => 'both',
                'grain_type' => 'medium',
                'resistance_level' => 'medium',
                'characteristics' => json_encode(['notes' => 'auto-generated placeholder']),
                'is_active' => false,
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            $defaultVariety = DB::table('rice_varieties')->where('name', 'Unknown')->first();
        }

        $defaultVarietyId = $defaultVariety->id ?? DB::table('rice_varieties')->value('id');

        if (!$defaultVarietyId) {
            throw new \RuntimeException('Unable to establish a default rice_variety_id for plantings migration');
        }
        // Backfill existing plantings with null rice variety id.
        DB::table('plantings')->whereNull('rice_variety_id')->update(['rice_variety_id' => $defaultVarietyId]);

        // Enforce non-null on plantings.rice_variety_id field.
        Schema::table('plantings', function (Blueprint $table) {
            $table->unsignedBigInteger('rice_variety_id')->nullable(false)->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('plantings', function (Blueprint $table) {
            $table->unsignedBigInteger('rice_variety_id')->nullable()->change();
        });
    }
};
