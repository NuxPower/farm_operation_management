<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration {
    /**
     * Run the migrations.
     * Switches weather_logs from field_id to farm_id.
     */
    public function up(): void
    {
        // 1. Add nullable farm_id column
        Schema::table('weather_logs', function (Blueprint $table) {
            $table->unsignedBigInteger('farm_id')->nullable()->after('id');
        });

        // 2. Populate farm_id from fields → farms
        DB::statement('
            UPDATE weather_logs
            SET farm_id = fields.farm_id
            FROM fields
            WHERE weather_logs.field_id = fields.id
        ');

        // 3. For any orphaned rows (field deleted), remove them
        DB::table('weather_logs')->whereNull('farm_id')->delete();

        // 4. Drop old field_id FK and column, make farm_id non-nullable, add new FK
        Schema::table('weather_logs', function (Blueprint $table) {
            $table->dropForeign(['field_id']);
            $table->dropColumn('field_id');

            $table->unsignedBigInteger('farm_id')->nullable(false)->change();
            $table->foreign('farm_id')->references('id')->on('farms')->onDelete('cascade');
            $table->index(['farm_id', 'recorded_at']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('weather_logs', function (Blueprint $table) {
            $table->dropIndex(['farm_id', 'recorded_at']);
            $table->dropForeign(['farm_id']);
            $table->dropColumn('farm_id');

            $table->foreignId('field_id')->constrained()->onDelete('cascade');
        });
    }
};
