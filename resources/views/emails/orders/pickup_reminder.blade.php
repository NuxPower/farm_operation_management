@component('mail::message')
# Reminder: Pickup Tomorrow

Hi {{ $order->buyer->name }},

This is a friendly reminder that your order **#{{ $order->id }}** matches the scheduled date for tomorrow.

**Product:** {{ $order->riceProduct->name }}
**Amount:** {{ $order->total_amount }}

Please ensure you are ready to pick it up or receive delivery.

@component('mail::button', ['url' => config('app.url') . '/buyer/orders/' . $order->id])
View Order
@endcomponent

Thanks,<br>
{{ config('app.name') }}
@endcomponent