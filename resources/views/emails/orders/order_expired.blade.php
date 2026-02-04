@component('mail::message')
@if($recipientType === 'farmer')
    # Order Auto-Cancelled

    Hello {{ $order->riceProduct->farmer->name ?? 'Farmer' }},

    **Order #{{ $order->id }}** has been automatically cancelled because the buyer did not pick it up before the deadline.

    ## Order Details
    - **Product:** {{ $order->riceProduct->name ?? 'Rice Product' }}
    - **Quantity:** {{ number_format($order->quantity, 2) }} kg
    - **Total:** {{ Illuminate\Support\Number::currency($order->total_amount, in: 'PHP') }}
    - **Buyer:** {{ $order->buyer->name ?? 'N/A' }}
    - **Deadline Was:** {{ $order->pickup_deadline?->format('M d, Y h:i A') ?? 'N/A' }}

    ## ✅ Stock Restored
    The reserved quantity of **{{ number_format($order->quantity, 2) }} kg** has been restored to your product inventory and
    is now available for other buyers.

    @component('mail::button', ['url' => config('app.url') . '/farmer/orders'])
    View Orders
    @endcomponent

@else
    # Your Order Has Been Cancelled

    Hello {{ $order->buyer->name ?? 'Buyer' }},

    We regret to inform you that your **Order #{{ $order->id }}** has been cancelled because it was not picked up before the
    deadline.

    ## Order Details
    - **Product:** {{ $order->riceProduct->name ?? 'Rice Product' }}
    - **Quantity:** {{ number_format($order->quantity, 2) }} kg
    - **Total:** {{ Illuminate\Support\Number::currency($order->total_amount, in: 'PHP') }}
    - **Deadline Was:** {{ $order->pickup_deadline?->format('M d, Y h:i A') ?? 'N/A' }}

    ## What Happened?
    Orders that are marked "Ready for Pickup" must be collected within **3 days**. This policy helps ensure fair access to
    products for all buyers.

    If you still need this product, please place a new order!

    @component('mail::button', ['url' => config('app.url') . '/marketplace'])
    Browse Products
    @endcomponent

@endif

Thanks,<br>
{{ config('app.name') }}
@endcomponent