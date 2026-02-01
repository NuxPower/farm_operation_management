@component('mail::message')
# Great News! Your Pre-Order is Available

Hi {{ $order->buyer->name }},

We are excited to inform you that your pre-ordered item **{{ $order->riceProduct->name }}** is now produced and ready!

**Order ID:** #{{ $order->id }}
**Quantity:** {{ $order->quantity }}kg

Please check your dashboard for pickup/delivery details.

@component('mail::button', ['url' => config('app.url') . '/buyer/orders/' . $order->id])
View Order
@endcomponent

Thanks,<br>
{{ config('app.name') }}
@endcomponent