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

        $farms = \App\Models\Farm::whereNotNull('weather_coordinates')->get();
        $sentCount = 0;

        foreach ($farms as $farm) {
            /** @var \App\Models\Farm $farm */
            try {
                // Get Owner User
                $user = $farm->user;
                if (!$user)
                    continue;

                // Check for alerts
                $alerts = $service->getWeatherAlerts($farm);

                foreach ($alerts as $alert) {
                    $cacheKey = "weather_alert_{$farm->id}_{$alert['type']}_{$alert['severity']}";

                    // Rate Limit: 24h
                    if (Cache::has($cacheKey)) {
                        continue;
                    }

                    // 1. Dispatch Push Notification (Websockets)
                    \App\Events\WeatherAlert::dispatch(
                        $farm->id,
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
                $this->error("Error monitoring farm {$farm->id}: " . $e->getMessage());
            }
        }

        $this->info("Weather monitoring completed. Sent {$sentCount} new alerts.");
    }
}
