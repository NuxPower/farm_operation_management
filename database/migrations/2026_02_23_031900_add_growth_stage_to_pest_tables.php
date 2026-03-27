<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('pest_libraries', function (Blueprint $table) {
            $table->json('vulnerable_stages')->nullable()->after('images');
            // e.g., ["vegetative", "reproductive"]
        });

        Schema::table('pest_analytics_rules', function (Blueprint $table) {
            $table->string('stage_note')->nullable()->after('risk_message');
            // e.g., "Causes deadheart at this stage"
        });
    }

    public function down(): void
    {
        Schema::table('pest_libraries', function (Blueprint $table) {
            $table->dropColumn('vulnerable_stages');
        });

        Schema::table('pest_analytics_rules', function (Blueprint $table) {
            $table->dropColumn('stage_note');
        });
    }
};
