<?php

namespace App\Notifications;

use App\Models\Planting;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;

class PlantingFailedNotification extends Notification
{
    use Queueable;

    protected Planting $planting;
    protected float $cropLossAmount;

    public function __construct(Planting $planting, float $cropLossAmount = 0)
    {
        $this->planting = $planting;
        $this->cropLossAmount = $cropLossAmount;
    }

    public function via(object $notifiable): array
    {
        return ['database'];
    }

    public function toArray(object $notifiable): array
    {
        $planting = $this->planting;
        $variety  = $planting->riceVariety?->name ?? $planting->crop_type ?? 'Planting';
        $field    = $planting->field?->name ?? 'Unknown Field';
        $reason   = $planting->failure_reason ?? 'No reason specified';
        $category = Planting::FAILURE_CATEGORIES[$planting->failure_category] ?? null;

        $message = "Your planting of {$variety} on {$field} has been marked as failed.";
        if ($category) {
            $message .= " Category: {$category}.";
        }
        $message .= " Reason: {$reason}.";
        if ($this->cropLossAmount > 0) {
            $message .= ' A crop loss expense of ₱' . number_format($this->cropLossAmount, 2) . ' has been automatically recorded.';
        }

        return [
            'type'             => 'planting_failed',
            'planting_id'      => $planting->id,
            'field_name'       => $field,
            'variety'          => $variety,
            'failure_reason'   => $reason,
            'failure_category' => $planting->failure_category,
            'failed_at'        => $planting->failed_at?->toIso8601String(),
            'crop_loss_amount' => $this->cropLossAmount,
            'message'          => $message,
            'url'              => '/plantings/' . $planting->id,
        ];
    }
}
