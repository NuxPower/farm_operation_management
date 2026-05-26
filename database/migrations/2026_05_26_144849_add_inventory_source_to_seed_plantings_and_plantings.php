<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('seed_plantings', function (Blueprint $table) {
            if (!Schema::hasColumn('seed_plantings', 'inventory_item_id')) {
                $table->foreignId('inventory_item_id')
                    ->nullable()
                    ->after('rice_variety_id')
                    ->constrained('inventory_items')
                    ->nullOnDelete();
            }
        });

        Schema::table('plantings', function (Blueprint $table) {
            if (!Schema::hasColumn('plantings', 'inventory_item_id')) {
                $table->foreignId('inventory_item_id')
                    ->nullable()
                    ->after('seed_planting_id')
                    ->constrained('inventory_items')
                    ->nullOnDelete();
            }
        });
    }

    public function down(): void
    {
        Schema::table('plantings', function (Blueprint $table) {
            if (Schema::hasColumn('plantings', 'inventory_item_id')) {
                $table->dropForeign(['inventory_item_id']);
                $table->dropColumn('inventory_item_id');
            }
        });

        Schema::table('seed_plantings', function (Blueprint $table) {
            if (Schema::hasColumn('seed_plantings', 'inventory_item_id')) {
                $table->dropForeign(['inventory_item_id']);
                $table->dropColumn('inventory_item_id');
            }
        });
    }
};
