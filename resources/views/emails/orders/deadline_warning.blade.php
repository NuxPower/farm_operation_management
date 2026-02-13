@component('mail::message')
# Pickup Deadline Warning

Hello {{ $order->riceProduct->farmer->name ?? 'Farmer' }},

**Order #{{ $order->id }}** has a pickup deadline expiring soon!

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

@component('mail::button', ['url' => config('app.url') . '/farmer/orders/' . $order->id])
View Order
@endcomponent

---

**Why this matters:**
Based on research from major retailers (Target, Walmart) and fresh produce e-commerce studies, pickup deadlines help
protect farmers from potential scammers who reserve products indefinitely without picking them up.

Thanks,<br>
{{ config('app.name') }}
@endcomponent