<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('rice_orders', function (Blueprint $table) {
            $table->date('preferred_pickup_date')->nullable()->after('delivery_method');
            $table->date('confirmed_pickup_date')->nullable()->after('preferred_pickup_date');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('rice_orders', function (Blueprint $table) {
            $table->dropColumn(['preferred_pickup_date', 'confirmed_pickup_date']);
        });
    }
};
