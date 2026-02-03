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
        Schema::create('price_negotiations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('rice_order_id')->constrained('rice_orders')->onDelete('cascade');
            $table->foreignId('proposer_id')->constrained('users')->onDelete('cascade');
            $table->decimal('proposed_price', 10, 2);
            $table->enum('status', ['pending', 'accepted', 'rejected', 'superseded'])->default('pending');
            $table->text('response_message')->nullable();
            $table->timestamp('responded_at')->nullable();
            $table->timestamps();

            $table->index(['rice_order_id', 'status']);
            $table->index(['rice_order_id', 'created_at']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('price_negotiations');
    }
};
