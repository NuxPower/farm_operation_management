@component('mail::message')
# Order Status Update

Hello {{ $order->buyer->name }},

The status of your order **#{{ $order->id }}** has changed to **{{ ucfirst(str_replace('_', ' ', $order->status)) }}**.

## Order Details
- **Product:** {{ $order->riceProduct->name }}
- **Quantity:** {{ number_format($order->quantity, 2) }} kg
- **Total:** PHP {{ number_format($order->total_amount, 2) }}
- **Farmer:** {{ $order->riceProduct->farmer->name }}

@if($order->status === 'ready_for_pickup')
    ## 📍 Ready for Pickup
    Your order is ready! Please pick it up by **{{ $order->pickup_deadline?->format('F j, Y') }}**.
@endif

@if($order->status === 'cancelled')
    ## ⚠️ Cancellation Reason
    {{ $order->farmer_notes ?? $order->dispute_reason ?? 'No reason provided.' }}
@endif

@component('mail::button', ['url' => config('app.url') . "/orders/{$order->id}"])
View Order
@endcomponent

Thanks,<br>
{{ config('app.name') }}
@endcomponent