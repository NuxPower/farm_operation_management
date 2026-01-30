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
        Schema::table('sales', function (Blueprint $table) {
            $table->unsignedBigInteger('harvest_id')->nullable()->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // We cannot easily revert this to not null without checking data integrity first,
        // but strictly speaking the reverse operation is making it not null again.
        // For safety in this dev environment, we will attempt to make it not null.
        Schema::table('sales', function (Blueprint $table) {
            $table->unsignedBigInteger('harvest_id')->nullable(false)->change();
        });
    }
};
