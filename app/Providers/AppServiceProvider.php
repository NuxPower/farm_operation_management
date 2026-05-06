<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Auth\Notifications\ResetPassword;
use Symfony\Component\Mailer\Bridge\Brevo\Transport\BrevoTransportFactory;
use Symfony\Component\Mailer\Transport\Dsn;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        // Register Brevo Mail API Transport
        $this->app['mail.manager']->extend('brevo', function ($config) {
            return (new BrevoTransportFactory)->create(
                new Dsn('brevo+api', 'default', config('services.brevo.key'))
            );
        });

        ResetPassword::createUrlUsing(function (object $notifiable, string $token) {
            return config('app.url') . '/password/reset/' . $token . '?email=' . urlencode($notifiable->getEmailForPasswordReset());
        });
    }
}
