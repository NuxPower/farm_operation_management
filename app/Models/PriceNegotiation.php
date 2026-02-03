<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PriceNegotiation extends Model
{
    use HasFactory;

    const STATUS_PENDING = 'pending';
    const STATUS_ACCEPTED = 'accepted';
    const STATUS_REJECTED = 'rejected';
    const STATUS_SUPERSEDED = 'superseded';

    protected $fillable = [
        'rice_order_id',
        'proposer_id',
        'proposed_price',
        'status',
        'response_message',
        'responded_at',
    ];

    protected $casts = [
        'proposed_price' => 'decimal:2',
        'responded_at' => 'datetime',
    ];

    /**
     * Get the order this negotiation belongs to
     */
    public function order()
    {
        return $this->belongsTo(RiceOrder::class, 'rice_order_id');
    }

    /**
     * Get the user who proposed this price
     */
    public function proposer()
    {
        return $this->belongsTo(User::class, 'proposer_id');
    }

    /**
     * Check if negotiation is pending
     */
    public function isPending(): bool
    {
        return $this->status === self::STATUS_PENDING;
    }

    /**
     * Check if the given user can respond to this negotiation
     */
    public function canBeRespondedBy(?User $user): bool
    {
        if (!$user || !$this->isPending()) {
            return false;
        }

        // The user who proposed cannot respond to their own proposal
        if ($this->proposer_id === $user->id) {
            return false;
        }

        // Load order with product if needed
        $this->loadMissing('order.riceProduct');

        // User must be either the buyer or the farmer
        $isBuyer = $this->order->buyer_id === $user->id;
        $isFarmer = $this->order->riceProduct && $this->order->riceProduct->farmer_id === $user->id;

        return $isBuyer || $isFarmer;
    }

    /**
     * Accept this negotiation
     */
    public function accept(?string $message = null): void
    {
        $this->update([
            'status' => self::STATUS_ACCEPTED,
            'response_message' => $message,
            'responded_at' => now(),
        ]);

        // Update the order with the accepted price
        $this->order->update([
            'unit_price' => $this->proposed_price,
            'total_amount' => $this->proposed_price * $this->order->quantity,
            'status' => RiceOrder::STATUS_PENDING,
        ]);
    }

    /**
     * Reject this negotiation
     */
    public function reject(?string $message = null): void
    {
        $this->update([
            'status' => self::STATUS_REJECTED,
            'response_message' => $message,
            'responded_at' => now(),
        ]);
    }

    /**
     * Mark as superseded (when a new proposal is created)
     */
    public function supersede(): void
    {
        $this->update([
            'status' => self::STATUS_SUPERSEDED,
            'responded_at' => now(),
        ]);
    }
}
