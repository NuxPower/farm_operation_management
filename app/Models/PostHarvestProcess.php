<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class PostHarvestProcess extends Model
{
    use HasFactory;

    protected $fillable = [
        'harvest_id',
        'planting_id',
        'user_id',
        'task_id',
        'parent_process_id',
        'process_type',
        'status',
        'input_quantity',
        'input_unit',
        'output_quantity',
        'output_unit',
        'weight_loss_percentage',
        'process_date',
        'completed_date',
        'cost',
        'cost_type',
        'cost_per_unit',
        'service_provider',
        'process_data',
        'notes',
    ];

    protected $casts = [
        'input_quantity' => 'decimal:2',
        'output_quantity' => 'decimal:2',
        'weight_loss_percentage' => 'decimal:2',
        'cost' => 'decimal:2',
        'cost_per_unit' => 'decimal:2',
        'process_date' => 'date',
        'completed_date' => 'date',
        'process_data' => 'array',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    /**
     * Process type constants
     */
    const TYPE_THRESHING = 'threshing';
    const TYPE_DRYING = 'drying';
    const TYPE_MILLING = 'milling';

    const PROCESS_TYPES = [
        self::TYPE_THRESHING,
        self::TYPE_DRYING,
        self::TYPE_MILLING,
    ];

    /**
     * Status constants
     */
    const STATUS_PENDING = 'pending';
    const STATUS_IN_PROGRESS = 'in_progress';
    const STATUS_COMPLETED = 'completed';
    const STATUS_CANCELLED = 'cancelled';

    const STATUSES = [
        self::STATUS_PENDING,
        self::STATUS_IN_PROGRESS,
        self::STATUS_COMPLETED,
        self::STATUS_CANCELLED,
    ];

    /**
     * Cost type constants
     */
    const COST_TYPE_SELF = 'self';
    const COST_TYPE_SERVICE_FIXED = 'service_fixed';
    const COST_TYPE_SERVICE_PER_UNIT = 'service_per_unit';

    const COST_TYPES = [
        self::COST_TYPE_SELF,
        self::COST_TYPE_SERVICE_FIXED,
        self::COST_TYPE_SERVICE_PER_UNIT,
    ];

    /**
     * Default recovery rates for Philippine rice farming (%)
     */
    const DEFAULT_RECOVERY_RATES = [
        self::TYPE_THRESHING => 95.0,  // ~5% loss (chaff, spillage)
        self::TYPE_DRYING => 82.0,     // ~18% moisture loss
        self::TYPE_MILLING => 65.0,    // ~35% loss (husk, bran)
    ];

    // ─── Relationships ───

    public function harvest(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(Harvest::class);
    }

    public function planting(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(Planting::class);
    }

    public function user(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function task(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(Task::class);
    }

    public function parentProcess(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(self::class, 'parent_process_id');
    }

    public function childProcess(): \Illuminate\Database\Eloquent\Relations\HasOne
    {
        return $this->hasOne(self::class, 'parent_process_id');
    }

    // ─── Scopes ───

    public function scopeByType($query, string $type)
    {
        return $query->where('process_type', $type);
    }

    public function scopeByStatus($query, string $status)
    {
        return $query->where('status', $status);
    }

    public function scopeForHarvest($query, int $harvestId)
    {
        return $query->where('harvest_id', $harvestId);
    }

    public function scopeCompleted($query)
    {
        return $query->where('status', self::STATUS_COMPLETED);
    }

    // ─── Helpers ───

    /**
     * Get actual recovery rate (output / input * 100)
     */
    public function getRecoveryRate(): ?float
    {
        if (!$this->output_quantity || !$this->input_quantity || $this->input_quantity == 0) {
            return null;
        }

        return round(($this->output_quantity / $this->input_quantity) * 100, 2);
    }

    /**
     * Get typical expected recovery rate for this process type
     */
    public function getExpectedRecoveryRate(): float
    {
        return self::DEFAULT_RECOVERY_RATES[$this->process_type] ?? 100.0;
    }

    /**
     * Get human-readable label for the output product form
     */
    public function getOutputProductForm(): string
    {
        return match ($this->process_type) {
            self::TYPE_THRESHING => 'Palay',
            self::TYPE_DRYING => 'Dried Palay',
            self::TYPE_MILLING => 'Milled Rice',
            default => 'Processed Rice',
        };
    }

    /**
     * Get the expected input unit label for this process type.
     */
    public static function getInputUnitLabel(string $processType): string
    {
        return match ($processType) {
            self::TYPE_THRESHING => 'bushels',
            self::TYPE_DRYING => 'sacks_palay',
            self::TYPE_MILLING => 'dried palay',
            default => 'bushels',
        };
    }

    /**
     * Get the expected output unit label for this process type.
     */
    public static function getOutputUnitLabel(string $processType): string
    {
        return match ($processType) {
            self::TYPE_THRESHING => 'sacks_palay',
            self::TYPE_DRYING => 'dried palay',
            self::TYPE_MILLING => 'sacks_rice',
            default => 'sacks_palay',
        };
    }

    /**
     * Get human-readable display label for a unit identifier.
     */
    public static function humanReadableUnit(string $unit): string
    {
        return match ($unit) {
            'sacks_palay' => 'sacks',
            'sacks_rice' => 'sacks',
            default => $unit,
        };
    }

    /**
     * Get the required predecessor process type (fixed pipeline order).
     * Returns null if this is the first step (threshing).
     */
    public static function getRequiredPredecessor(string $processType): ?string
    {
        return match ($processType) {
            self::TYPE_THRESHING => null,
            self::TYPE_DRYING => self::TYPE_THRESHING,
            self::TYPE_MILLING => self::TYPE_DRYING,
            default => null,
        };
    }

    /**
     * Get the next process type in the fixed pipeline.
     * Returns null if this is the last step (milling).
     */
    public static function getNextStep(string $processType): ?string
    {
        return match ($processType) {
            self::TYPE_THRESHING => self::TYPE_DRYING,
            self::TYPE_DRYING => self::TYPE_MILLING,
            self::TYPE_MILLING => null,
            default => null,
        };
    }

    /**
     * Fixed pipeline order.
     */
    const PIPELINE_ORDER = [
        self::TYPE_THRESHING,
        self::TYPE_DRYING,
        self::TYPE_MILLING,
    ];

    /**
     * Check if this process can be completed (has required data)
     */
    public function canComplete(): bool
    {
        return in_array($this->status, [self::STATUS_PENDING, self::STATUS_IN_PROGRESS]);
    }

    /**
     * Check if this process can be deleted
     */
    public function canDelete(): bool
    {
        return in_array($this->status, [self::STATUS_PENDING, self::STATUS_CANCELLED]);
    }

    /**
     * Human-readable process type label
     */
    public function getProcessLabelAttribute(): string
    {
        return ucfirst($this->process_type);
    }
}
