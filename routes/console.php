<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Schedule;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');

// Schedule pre-order notifications to run daily at 9 AM
Schedule::command('pre-orders:send-notifications')
    ->dailyAt('09:00')
    ->timezone('Asia/Manila')
    ->withoutOverlapping();

// Schedule inventory expiry check to run daily at 8 AM
Schedule::command('inventory:check-expiry')
    ->dailyAt('08:00')
    ->timezone('Asia/Manila')
    ->withoutOverlapping();

// Schedule reports to be sent hourly (checks frequency internally)
Schedule::command('reports:send-scheduled')
    ->hourly()
    ->timezone('Asia/Manila')
    ->withoutOverlapping();

// Schedule pickup deadline warnings to run daily at 8 AM
// Sends email to farmers about orders expiring in 24 hours
Schedule::command('orders:send-deadline-warnings')
    ->dailyAt('08:00')
    ->timezone('Asia/Manila')
    ->withoutOverlapping();

// Schedule auto-cancel expired pickups to run hourly
// Cancels orders past deadline, restores inventory, notifies buyer+farmer

Schedule::command('orders:cancel-expired-pickups')
    ->hourly()
    ->timezone('Asia/Manila')
    ->withoutOverlapping();

// Schedule weather monitoring to run hourly
// Checks fields for critical conditions and triggers alerts
Schedule::command('weather:monitor')
    ->hourly()
    ->timezone('Asia/Manila')
    ->withoutOverlapping();

// Schedule due task processing to run daily at 10 AM
// Auto-completes overdue tasks and generates labor wages/expenses
Schedule::command('tasks:process-due')
    ->dailyAt('10:00')
    ->timezone('Asia/Manila')
    ->withoutOverlapping();


