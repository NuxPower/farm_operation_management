@component('mail::message')
# Pickup Deadline Warning

Hello {{ $order->buyer->name ?? 'Buyer' }},

Your **Order #{{ $order->id }}** has a pickup deadline expiring soon!

## Order Details
- **Product:** {{ $order->riceProduct->name ?? 'Rice Product' }}
- **Quantity:** {{ number_format($order->quantity, 2) }} kg
- **Total:** PHP {{ number_format($order->total_amount, 2) }}
- **Buyer:** {{ $order->buyer->name ?? 'N/A' }}

## ⚠️ Deadline Warning
**Time Remaining:** {{ $hoursRemaining }} hours

If the buyer doesn't pick up by
**{{ $order->pickup_deadline ? $order->pickup_deadline->format('M d, Y h:i A') : 'the deadline' }}**, this order will be
**automatically cancelled** and the reserved stock will be released.

@component('mail::button', ['url' => config('app.url') . '/orders/' . $order->id])
View Order
@endcomponent

---

**Important:**
If you fail to pick up your order by the deadline, it will be automatically cancelled so the stock can be made available to other customers.

Thanks,<br>
{{ config('app.name') }}
@endcomponent