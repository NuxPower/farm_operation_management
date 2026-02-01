<?php

namespace App\Console\Commands;

use App\Models\Field;
use App\Services\WeatherService;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Mail;

class MonitorWeatherAlerts extends Command
{
    protected $signature = 'weather:monitor';
    protected $description = 'Monitor fields for weather alerts and send notifications';

    public function handle(WeatherService $service)
    {
        $this->info('Starting weather alert monitoring...');

        $fields = Field::whereNotNull('location')->get();
        $sentCount = 0;

        foreach ($fields as $field) {
            /** @var Field $field */
            try {
                // Get Owner User
                $user = $field->farm->user ?? null;
                if (!$user)
                    continue;

                // Check for alerts
                $alerts = $service->getWeatherAlerts($field);

                foreach ($alerts as $alert) {
                    $cacheKey = "weather_alert_{$field->id}_{$alert['type']}_{$alert['severity']}";

                    // Rate Limit: 24h
                    if (Cache::has($cacheKey)) {
                        continue;
                    }

                    // 1. Dispatch Push Notification (Websockets)
                    \App\Events\WeatherAlert::dispatch(
                        $field->id,
                        $user->id,
                        $alert['type'],
                        $alert['severity'],
                        $alert['message'],
                        $alert
                    );

                    // 2. Send Email
                    try {
                        Mail::to($user->email)->send(new \App\Mail\WeatherWarningMail($alert));
                        $this->info("Sent alert email to {$user->email}: {$alert['title']}");
                    } catch (\Exception $e) {
                        $this->error("Failed to send email: " . $e->getMessage());
                    }

                    // Cache for 24 hours to prevent spam
                    Cache::put($cacheKey, true, now()->addHours(24));
                    $sentCount++;
                }

            } catch (\Exception $e) {
                $this->error("Error monitoring field {$field->id}: " . $e->getMessage());
            }
        }

        $this->info("Weather monitoring completed. Sent {$sentCount} new alerts.");
    }
}
