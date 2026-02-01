<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class WeatherWarningMail extends Mailable
{
    public $alert;
    public $title;
    public $message;
    public $severity;
    public $recommendation;
    public $severityColor;

    /**
     * Create a new message instance.
     */
    public function __construct(array $alert)
    {
        $this->alert = $alert;
        $this->title = $alert['title'];
        $this->message = $alert['message'];
        $this->severity = $alert['severity'];
        $this->recommendation = $alert['recommendation'] ?? null;

        $this->severityColor = match ($this->severity) {
            'critical' => 'red',
            'high' => 'orange',
            'medium' => 'gold',
            default => 'blue',
        };
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Weather Alert: ' . $this->title,
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            markdown: 'emails.weather.warning',
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
