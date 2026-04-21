<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('plantings', function (Blueprint $table) {
            $table->string('failure_reason', 500)->nullable()->after('notes');
            $table->enum('failure_category', [
                'pest_disease',
                'weather',
                'flood',
                'drought',
                'poor_germination',
                'other',
            ])->nullable()->after('failure_reason');
            $table->timestamp('failed_at')->nullable()->after('failure_category');
        });
    }

    public function down(): void
    {
        Schema::table('plantings', function (Blueprint $table) {
            $table->dropColumn(['failure_reason', 'failure_category', 'failed_at']);
        });
    }
};
