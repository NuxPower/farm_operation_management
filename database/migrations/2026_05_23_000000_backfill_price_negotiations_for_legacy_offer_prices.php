<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        if (!DB::getSchemaBuilder()->hasTable('price_negotiations')) {
            return;
        }

        $orders = DB::table('rice_orders')
            ->select(['id', 'buyer_id', 'offer_price', 'created_at', 'updated_at'])
            ->where('status', 'negotiating')
            ->whereNotNull('offer_price')
            ->whereNotExists(function ($query) {
                $query->select(DB::raw(1))
                    ->from('price_negotiations')
                    ->whereColumn('price_negotiations.rice_order_id', 'rice_orders.id');
            })
            ->get();

        foreach ($orders as $order) {
            DB::table('price_negotiations')->insert([
                'rice_order_id' => $order->id,
                'proposer_id' => $order->buyer_id,
                'proposed_price' => $order->offer_price,
                'status' => 'pending',
                'response_message' => null,
                'responded_at' => null,
                'created_at' => $order->created_at ?? now(),
                'updated_at' => $order->updated_at ?? now(),
            ]);
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Intentionally left empty: generated negotiations represent real order history.
    }
};
