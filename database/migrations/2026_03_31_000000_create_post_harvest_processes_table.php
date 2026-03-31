<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('post_harvest_processes', function (Blueprint $table) {
            $table->id();

            $table->foreignId('harvest_id')->constrained('harvests')->cascadeOnDelete();
            $table->foreignId('planting_id')->constrained('plantings')->cascadeOnDelete();
            $table->foreignId('user_id')->constrained('users')->cascadeOnDelete();
            $table->foreignId('task_id')->nullable()->constrained('tasks')->nullOnDelete();
            $table->foreignId('parent_process_id')->nullable()->constrained('post_harvest_processes')->nullOnDelete();

            $table->string('process_type'); // threshing, drying, milling
            $table->string('status')->default('pending'); // pending, in_progress, completed, cancelled

            $table->decimal('input_quantity', 12, 2);
            $table->string('input_unit');
            $table->decimal('output_quantity', 12, 2)->nullable();
            $table->string('output_unit')->nullable();
            $table->decimal('weight_loss_percentage', 5, 2)->nullable();

            $table->date('process_date');
            $table->date('completed_date')->nullable();

            $table->decimal('cost', 12, 2)->default(0);
            $table->string('cost_type')->default('self'); // self, service_fixed, service_per_unit
            $table->decimal('cost_per_unit', 12, 2)->nullable();
            $table->string('service_provider')->nullable();

            $table->json('process_data')->nullable();
            $table->text('notes')->nullable();

            $table->timestamps();

            // Indexes for common queries
            $table->index(['harvest_id', 'process_type']);
            $table->index(['planting_id', 'status']);
            $table->index(['user_id', 'status']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('post_harvest_processes');
    }
};
