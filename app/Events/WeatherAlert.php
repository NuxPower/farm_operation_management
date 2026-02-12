<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class WeatherAlert implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $farmId;
    public $userId;
    public $alertType;
    public $severity;
    public $message;
    public $weatherData;

    /**
     * Create a new event instance.
     */
    public function __construct($farmId, $userId, $alertType, $severity, $message, $weatherData = [])
    {
        $this->farmId = $farmId;
        $this->userId = $userId;
        $this->alertType = $alertType;
        $this->severity = $severity;
        $this->message = $message;
        $this->weatherData = $weatherData;
    }

    /**
     * Get the channels the event should broadcast on.
     *
     * @return array<int, \Illuminate\Broadcasting\Channel>
     */
    public function broadcastOn(): array
    {
        return [
            new PrivateChannel('weather-alerts.' . $this->userId),
        ];
    }

    /**
     * Get the data to broadcast.
     *
     * @return array
     */
    public function broadcastWith(): array
    {
        return [
            'farm_id' => $this->farmId,
            'alert_type' => $this->alertType,
            'severity' => $this->severity,
            'message' => $this->message,
            'weather_data' => $this->weatherData,
            'created_at' => now()->toISOString(),
        ];
    }

    /**
     * The event's broadcast name.
     *
     * @return string
     */
    public function broadcastAs(): string
    {
        return 'weather-alert';
    }

    /**
     * Create weather alert instances for different conditions
     */
    public static function createHeavyRainAlert($farmId, $userId, $rainfallData)
    {
        return new self(
            $farmId,
            $userId,
            'heavy_rain',
            'high',
            "Heavy rainfall detected: {$rainfallData['rainfall']}mm in the last hour. Consider postponing outdoor activities.",
            $rainfallData
        );
    }

    public static function createDroughtAlert($farmId, $userId, $weatherData)
    {
        return new self(
            $farmId,
            $userId,
            'drought',
            'critical',
            "Drought conditions detected. No rainfall for {$weatherData['days_without_rain']} days. Consider irrigation.",
            $weatherData
        );
    }

    public static function createTyphoonAlert($farmId, $userId, $weatherData)
    {
        return new self(
            $farmId,
            $userId,
            'typhoon',
            'critical',
            "Typhoon warning: Strong winds ({$weatherData['wind_speed']} km/h) detected. Secure farm equipment and protect crops.",
            $weatherData
        );
    }

    public static function createExtremeTemperatureAlert($farmId, $userId, $weatherData)
    {
        $severity = $weatherData['temperature'] > 35 || $weatherData['temperature'] < 5 ? 'critical' : 'high';
        $message = $weatherData['temperature'] > 35
            ? "Extreme heat warning: {$weatherData['temperature']}°C. Ensure adequate irrigation and crop protection."
            : "Freezing temperature warning: {$weatherData['temperature']}°C. Protect sensitive crops from frost damage.";

        return new self(
            $farmId,
            $userId,
            'extreme_temperature',
            $severity,
            $message,
            $weatherData
        );
    }
}
