<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Drop the three unused legacy marketplace tables.
     * These were superseded by rice_products, rice_orders, and product_reviews.
     * Drop order respects FK dependencies: reviews → orders → listings.
     */
    public function up(): void
    {
        Schema::dropIfExists('marketplace_reviews');
        Schema::dropIfExists('marketplace_orders');
        Schema::dropIfExists('marketplace_listings');
    }

    /**
     * Restore the tables if the migration is rolled back.
     */
    public function down(): void
    {
        Schema::create('marketplace_listings', function (Blueprint $table) {
            $table->id();
            $table->foreignId('farmer_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('harvest_id')->nullable()->constrained()->onDelete('set null');
            $table->foreignId('rice_variety_id')->constrained()->onDelete('cascade');
            $table->string('title');
            $table->text('description');
            $table->decimal('quantity_available', 10, 2);
            $table->decimal('price_per_kg', 8, 2);
            $table->string('unit')->default('kg');
            $table->enum('quality_grade', ['premium', 'grade_a', 'grade_b', 'standard']);
            $table->decimal('moisture_content', 5, 2)->nullable();
            $table->json('harvest_details')->nullable();
            $table->json('images')->nullable();
            $table->enum('status', ['draft', 'active', 'sold_out', 'expired', 'suspended'])->default('draft');
            $table->datetime('available_from')->nullable();
            $table->datetime('available_until')->nullable();
            $table->string('location');
            $table->json('delivery_options')->nullable();
            $table->decimal('minimum_order', 8, 2)->default(1.00);
            $table->text('terms_conditions')->nullable();
            $table->boolean('is_featured')->default(false);
            $table->integer('views_count')->default(0);
            $table->timestamps();
        });

        Schema::create('marketplace_orders', function (Blueprint $table) {
            $table->id();
            $table->string('order_number')->unique();
            $table->foreignId('buyer_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('farmer_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('listing_id')->constrained('marketplace_listings')->onDelete('cascade');
            $table->decimal('quantity', 10, 2);
            $table->decimal('unit_price', 8, 2);
            $table->decimal('total_amount', 10, 2);
            $table->enum('status', ['pending', 'confirmed', 'preparing', 'ready_for_pickup', 'in_transit', 'delivered', 'cancelled', 'disputed'])->default('pending');
            $table->enum('payment_status', ['pending', 'paid', 'refunded', 'failed'])->default('pending');
            $table->enum('delivery_method', ['pickup', 'delivery', 'shipping']);
            $table->json('delivery_address')->nullable();
            $table->text('buyer_notes')->nullable();
            $table->text('farmer_notes')->nullable();
            $table->datetime('requested_delivery_date')->nullable();
            $table->datetime('confirmed_at')->nullable();
            $table->datetime('delivered_at')->nullable();
            $table->json('tracking_info')->nullable();
            $table->timestamps();
        });

        Schema::create('marketplace_reviews', function (Blueprint $table) {
            $table->id();
            $table->foreignId('order_id')->constrained('marketplace_orders')->onDelete('cascade');
            $table->foreignId('buyer_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('farmer_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('listing_id')->constrained('marketplace_listings')->onDelete('cascade');
            $table->integer('rating')->check('rating >= 1 AND rating <= 5');
            $table->text('review_text')->nullable();
            $table->json('review_categories')->nullable();
            $table->json('images')->nullable();
            $table->boolean('is_verified_purchase')->default(true);
            $table->text('farmer_response')->nullable();
            $table->datetime('farmer_responded_at')->nullable();
            $table->boolean('is_featured')->default(false);
            $table->unique('order_id');
            $table->timestamps();
        });
    }
};
