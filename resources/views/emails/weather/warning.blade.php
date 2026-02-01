@component('mail::message')
# {{ $title }}

**Severity:** <span style="color: {{ $severityColor }}">{{ ucfirst($severity) }}</span>

{{ $message }}

@if(!empty($recommendation))
    ## Recommended Action
    {{ $recommendation }}
@endif

@component('mail::button', ['url' => config('app.url') . '/dashboard'])
View Dashboard
@endcomponent

Stay Safe,<br>
{{ config('app.name') }}
@endcomponent