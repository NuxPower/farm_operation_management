<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use App\Models\RiceOrder;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class OrderExpiredMail extends Mailable
{
    use Queueable, SerializesModels;

    public $order;
    public $recipientType; // 'farmer' or 'buyer'

    /**
     * Create a new message instance.
     */
    public function __construct(RiceOrder $order, string $recipientType = 'buyer')
    {
        $this->order = $order;
        $this->recipientType = $recipientType;
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        $subject = $this->recipientType === 'farmer'
            ? "Order #{$this->order->id} Auto-Cancelled: Pickup Deadline Expired"
            : "Your Order #{$this->order->id} Has Been Cancelled";

        return new Envelope(
            subject: $subject,
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            markdown: 'emails.orders.order_expired',
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
