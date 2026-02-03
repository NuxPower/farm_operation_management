<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use App\Models\RiceOrder;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class PickupDeadlineWarningMail extends Mailable
{
    use Queueable, SerializesModels;

    public $order;
    public $hoursRemaining;

    /**
     * Create a new message instance.
     */
    public function __construct(RiceOrder $order, int $hoursRemaining = 24)
    {
        $this->order = $order;
        $this->hoursRemaining = $hoursRemaining;
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            subject: "⚠️ Pickup Deadline Warning: Order #{$this->order->id} expires in {$this->hoursRemaining} hours",
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            markdown: 'emails.orders.deadline_warning',
        );
    }

    /**
     * Get the attachments for the message.
     *
     * @return array<int, \Illuminate\Mail\Mailables\Attachment>
     */
    public function attachments(): array
    {
        return [];
    }
}
