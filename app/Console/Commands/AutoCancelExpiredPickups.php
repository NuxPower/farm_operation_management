<?php

namespace App\Console\Commands;

use App\Models\RiceOrder;
use App\Models\Notification;
use App\Mail\OrderExpiredMail;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Mail;
use Carbon\Carbon;

class AutoCancelExpiredPickups extends Command
{
    protected $signature = 'orders:cancel-expired-pickups';

    protected $description = 'Auto-cancel orders with expired pickup deadlines and notify both buyer and farmer';

    public function handle()
    {
        // Find orders that are ready_for_pickup with expired deadlines
        $expiredOrders = RiceOrder::where('status', RiceOrder::STATUS_READY_FOR_PICKUP)
            ->whereNotNull('pickup_deadline')
            ->where('pickup_deadline', '<', now())
            ->with(['riceProduct.farmer', 'buyer'])
            ->get();

        $count = 0;
        foreach ($expiredOrders as $order) {
            try {
                // Cancel the order (this also releases the reserved quantity)
                $order->cancel('Pickup deadline expired - order auto-cancelled');
                $count++;

                $farmer = $order->riceProduct->farmer ?? null;
                $buyer = $order->buyer ?? null;

                // Notify buyer via email
                if ($buyer && $buyer->email) {
                    try {
                        Mail::to($buyer->email)->send(
                            new OrderExpiredMail($order, 'buyer')
                        );
                        $this->info("Notified buyer {$buyer->email} about cancelled Order #{$order->id}");
                    } catch (\Exception $e) {
                        $this->error("Failed to email buyer: {$e->getMessage()}");
                    }
                }

                // Notify farmer via email
                if ($farmer && $farmer->email) {
                    try {
                        Mail::to($farmer->email)->send(
                            new OrderExpiredMail($order, 'farmer')
                        );
                        $this->info("Notified farmer {$farmer->email} about cancelled Order #{$order->id}");
                    } catch (\Exception $e) {
                        $this->error("Failed to email farmer: {$e->getMessage()}");
                    }
                }

                // Create in-app notification for buyer
                if ($buyer) {
                    Notification::notify(
                        $buyer->id,
                        Notification::TYPE_ORDER_STATUS,
                        'Order Cancelled',
                        "Your order #{$order->id} was cancelled - pickup deadline expired",
                        ['order_id' => $order->id],
                        "/orders/{$order->id}"
                    );
                }

                // Create in-app notification for farmer
                if ($farmer) {
                    Notification::notify(
                        $farmer->id,
                        Notification::TYPE_ORDER_STATUS,
                        'Order Auto-Cancelled',
                        "Order #{$order->id} was cancelled - buyer did not pick up before deadline. Stock restored.",
                        ['order_id' => $order->id],
                        "/farmer/orders/{$order->id}"
                    );
                }

                $this->info("Cancelled and notified for Order #{$order->id}");

            } catch (\Exception $e) {
                $this->error("Failed to cancel Order #{$order->id}: {$e->getMessage()}");
            }
        }

        $this->info("Auto-cancelled {$count} expired orders.");

        return 0;
    }
}
