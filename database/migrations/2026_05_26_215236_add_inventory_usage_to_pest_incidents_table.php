<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('pest_incidents', function (Blueprint $table) {
            $table->foreignId('inventory_item_id')
                ->nullable()
                ->after('treatment_cost')
                ->constrained('inventory_items')
                ->nullOnDelete();
            $table->decimal('inventory_quantity_used', 10, 2)
                ->nullable()
                ->after('inventory_item_id');
        });
    }

    public function down(): void
    {
        Schema::table('pest_incidents', function (Blueprint $table) {
            $table->dropConstrainedForeignId('inventory_item_id');
            $table->dropColumn('inventory_quantity_used');
        });
    }
};
