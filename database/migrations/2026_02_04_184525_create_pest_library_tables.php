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
        Schema::create('pest_libraries', function (Blueprint $table) {
            $table->id();
            $table->string('name'); // e.g., "Rice Blast"
            $table->string('slug')->unique();
            $table->string('type'); // insect, disease, weed, etc.
            $table->string('scientific_name')->nullable();
            $table->text('description')->nullable();
            $table->text('symptoms')->nullable();
            $table->text('treatment_guidance')->nullable();
            $table->json('images')->nullable(); // Reference URLs
            $table->timestamps();
        });

        Schema::create('pest_analytics_rules', function (Blueprint $table) {
            $table->id();
            $table->foreignId('pest_library_id')->constrained()->onDelete('cascade');
            $table->string('metric'); // temperature, humidity, rainfall, wind_speed, lunar_phase
            $table->string('condition'); // >, <, between, equals
            $table->decimal('value_min', 8, 2)->nullable();
            $table->decimal('value_max', 8, 2)->nullable();
            $table->integer('duration_hours')->nullable(); // For conditions like "16h of high humidity"
            $table->string('risk_level'); // low, moderate, high
            $table->text('risk_message'); // "High humidity favors spore germination"
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pest_analytics_rules');
        Schema::dropIfExists('pest_libraries');
    }
};
