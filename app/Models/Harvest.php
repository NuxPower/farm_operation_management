<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

use Illuminate\Database\Eloquent\Factories\HasFactory;

class Harvest extends Model
{
    use HasFactory;

    protected $fillable = [
        'planting_id',
        'yield',
        'harvest_date',
        'quality',
        'quantity',
        'unit',
        'quality_grade',
        'price_per_unit',
        'total_value',
        'notes',
        'harvester_share',
        'harvester_share_percentage',
    ];

    protected $casts = [
        'yield' => 'decimal:2',
        'quantity' => 'decimal:2',
        'price_per_unit' => 'decimal:2',
        'total_value' => 'decimal:2',
        'harvester_share' => 'decimal:2',
        'harvester_share_percentage' => 'decimal:2',
        'harvest_date' => 'datetime',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    /**
     * Quality constants
     */
    const QUALITY_EXCELLENT = 'excellent';
    const QUALITY_GOOD = 'good';
    const QUALITY_AVERAGE = 'average';
    const QUALITY_POOR = 'poor';

    /**
     * Get the planting that owns the harvest
     */
    public function planting(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(Planting::class);
    }

    /**
     * Get the sales for this harvest
     */
    public function sales()
    {
        return $this->hasMany(Sale::class);
    }

    /**
     * Get available quantity (not yet sold)
     */
    public function getAvailableQuantityAttribute()
    {
        $soldQuantity = $this->sales()->sum('quantity');
        return $this->yield - $soldQuantity;
    }

    /**
     * Check if harvest is fully sold
     */
    public function isFullySold(): bool
    {
        return $this->available_quantity <= 0;
    }

    /**
     * Get the post-harvest processes for this harvest
     */
    public function postHarvestProcesses(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(PostHarvestProcess::class);
    }

    /**
     * Get the latest completed process for this harvest
     */
    public function getLatestProcess()
    {
        return $this->postHarvestProcesses()
            ->where('status', PostHarvestProcess::STATUS_COMPLETED)
            ->orderByCompletionWithLogicalType('desc')
            ->first();
    }

    /**
     * Get the current processing status label for this harvest
     */
    public function getProcessingStatus(): string
    {
        $latest = $this->getLatestProcess();

        if (!$latest) {
            return 'unprocessed';
        }

        return match ($latest->process_type) {
            PostHarvestProcess::TYPE_THRESHING => 'threshed',
            PostHarvestProcess::TYPE_DRYING => 'dried',
            PostHarvestProcess::TYPE_MILLING => 'milled',
            default => 'processed',
        };
    }
}
