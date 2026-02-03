<?php

namespace App\Console\Commands;

use App\Models\RiceOrder;
use App\Mail\PickupDeadlineWarningMail;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Mail;
use Carbon\Carbon;

class SendPickupDeadlineWarnings extends Command
{
    protected $signature = 'orders:send-deadline-warnings';

    protected $description = 'Send warning emails to farmers about orders with pickup deadlines expiring in 24 hours';

    public function handle()
    {
        // Find orders that are ready_for_pickup with deadline in the next 24 hours
        // but more than 1 hour away (to avoid duplicate warnings)
        $expiringOrders = RiceOrder::where('status', RiceOrder::STATUS_READY_FOR_PICKUP)
            ->whereNotNull('pickup_deadline')
            ->where('pickup_deadline', '>', now())
            ->where('pickup_deadline', '<=', now()->addHours(24))
            ->with(['riceProduct.farmer', 'buyer'])
            ->get();

        $count = 0;
        foreach ($expiringOrders as $order) {
            $farmer = $order->riceProduct->farmer ?? null;

            if ($farmer && $farmer->email) {
                $hoursRemaining = now()->diffInHours($order->pickup_deadline);

                try {
                    Mail::to($farmer->email)->send(
                        new PickupDeadlineWarningMail($order, max(1, $hoursRemaining))
                    );
                    $count++;
                    $this->info("Sent warning for Order #{$order->id} to {$farmer->email}");
                } catch (\Exception $e) {
                    $this->error("Failed to send warning for Order #{$order->id}: {$e->getMessage()}");
                }
            }
        }

        $this->info("Sent {$count} deadline warning emails.");

        return 0;
    }
}
