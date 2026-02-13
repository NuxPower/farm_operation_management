<?php

namespace App\Observers;

use App\Mail\OrderStatusChangedMail;
use App\Models\RiceOrder;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;

class RiceOrderObserver
{
    /**
     * Handle the RiceOrder "updated" event.
     */
    public function updated(RiceOrder $order): void
    {
        if ($order->isDirty('status')) {
            $newStatus = $order->status;

            // Define which statuses should trigger an email to the buyer
            $notifyStatuses = [
                RiceOrder::STATUS_CONFIRMED,
                RiceOrder::STATUS_READY_FOR_PICKUP,
                RiceOrder::STATUS_PICKED_UP,
                RiceOrder::STATUS_CANCELLED,
                RiceOrder::STATUS_REFUNDED,
                RiceOrder::STATUS_SHIPPED,
                RiceOrder::STATUS_DELIVERED,
                RiceOrder::STATUS_NEGOTIATING, // Optional: Maybe handled by specific negotiation logic, but good to have
            ];

            if (in_array($newStatus, $notifyStatuses)) {
                try {
                    // Ensure the buyer has an email
                    if ($order->buyer && $order->buyer->email) {
                        Mail::to($order->buyer->email)->send(new OrderStatusChangedMail($order));
                        Log::info("Order status email sent to {$order->buyer->email} for Order #{$order->id} (Status: {$newStatus})");
                    }
                } catch (\Exception $e) {
                    Log::error("Failed to send order status email for Order #{$order->id}: " . $e->getMessage());
                }
            }
        }
    }
}
