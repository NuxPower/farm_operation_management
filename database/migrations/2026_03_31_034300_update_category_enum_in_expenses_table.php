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
        // For PostgreSQL, Laravel creates enum columns using a check constraint.
        // The check constraint name is typically {table}_{column}_check
        if (DB::getDriverName() === 'pgsql') {
            DB::statement('ALTER TABLE expenses DROP CONSTRAINT IF EXISTS expenses_category_check');
            DB::statement("ALTER TABLE expenses ADD CONSTRAINT expenses_category_check CHECK (category::text = ANY (ARRAY['seeds'::character varying, 'fertilizer'::character varying, 'pesticide'::character varying, 'labor'::character varying, 'equipment'::character varying, 'utilities'::character varying, 'maintenance'::character varying, 'inventory_purchase'::character varying, 'processing'::character varying, 'other'::character varying]::text[]))");
        } else {
            // For other databases like MySQL/SQLite, change the column type to string or string with allowed values.
            // But since this system heavily relies on PostgreSQL, the above statement suffices.
            // Using a generic approach to modify enum definition for non-pgsql if needed in the future:
            Schema::table('expenses', function (Blueprint $table) {
                // Not strictly needed since we are on Postgres.
            });
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        if (DB::getDriverName() === 'pgsql') {
            DB::statement('ALTER TABLE expenses DROP CONSTRAINT IF EXISTS expenses_category_check');
            DB::statement("ALTER TABLE expenses ADD CONSTRAINT expenses_category_check CHECK (category::text = ANY (ARRAY['seeds'::character varying, 'fertilizer'::character varying, 'pesticide'::character varying, 'labor'::character varying, 'equipment'::character varying, 'utilities'::character varying, 'maintenance'::character varying, 'other'::character varying]::text[]))");
        }
    }
};
