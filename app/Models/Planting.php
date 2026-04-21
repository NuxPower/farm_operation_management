<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

use Illuminate\Database\Eloquent\Factories\HasFactory;

class Planting extends Model
{
    use HasFactory;

    protected $fillable = [
        'field_id',
        'seed_planting_id',
        'rice_variety_id',
        'crop_type',
        'planting_date',
        'expected_harvest_date',
        'actual_harvest_date',
        'status',
        'planting_method',
        'seed_rate',
        'area_planted',
        'season',
        'notes',
        'weather_conditions',
        'seed_unit',
        'failure_reason',
        'failure_category',
        'failed_at',
    ];

    protected $casts = [
        'planting_date' => 'datetime',
        'expected_harvest_date' => 'datetime',
        'actual_harvest_date' => 'datetime',
        'failed_at' => 'datetime',
        'seed_rate' => 'decimal:2',
        'area_planted' => 'decimal:2',
        'weather_conditions' => 'array',
        'seed_unit' => 'string',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    /**
     * Status constants
     */
    const STATUS_PLANNED = 'planned';
    const STATUS_PLANTED = 'planted';
    const STATUS_GROWING = 'growing';
    const STATUS_READY = 'ready';
    const STATUS_HARVESTED = 'harvested';
    const STATUS_FAILED = 'failed';

    const FAILURE_CATEGORIES = [
        'pest_disease'    => 'Pest / Disease',
        'weather'         => 'Weather (General)',
        'flood'           => 'Flood',
        'drought'         => 'Drought',
        'poor_germination'=> 'Poor Germination',
        'other'           => 'Other',
    ];

    /** Scope: only failed plantings */
    public function scopeFailed($query)
    {
        return $query->where('status', self::STATUS_FAILED);
    }

    /** Scope: active (not harvested or failed) */
    public function scopeActive($query)
    {
        return $query->whereNotIn('status', [self::STATUS_HARVESTED, self::STATUS_FAILED]);
    }

    /**
     * Boot the model - add validation hooks
     */
    protected static function boot()
    {
        parent::boot();

        static::saving(function ($model) {
            // Warn if rice_variety_id is missing
            if (!$model->rice_variety_id) {
                \Illuminate\Support\Facades\Log::warning(
                    "Planting {$model->id} being saved without rice_variety_id",
                    ['field_id' => $model->field_id]
                );
            }

            // Auto-stamp failed_at when status first transitions to failed
            if ($model->isDirty('status') &&
                $model->status === self::STATUS_FAILED &&
                empty($model->failed_at)) {
                $model->failed_at = now();
            }
        });
    }

    /**
     * Get the field that owns the planting
     */
    public function field(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(Field::class);
    }

    /**
     * Get the rice variety for this planting
     */
    public function riceVariety(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(RiceVariety::class);
    }

    /**
     * Get the seed planting source
     */
    public function seedPlanting(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(SeedPlanting::class);
    }

    /**
     * Get the planting stages for this planting
     */
    public function plantingStages(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(PlantingStage::class);
    }

    /**
     * Get the harvests for this planting
     */
    public function harvests(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(Harvest::class);
    }

    /**
     * Get the tasks for this planting
     */
    public function tasks(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(Task::class);
    }

    /**
     * Get the expenses for this planting
     */
    public function expenses(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(Expense::class);
    }

    /**
     * Get the pest incidents for this planting
     */
    public function pestIncidents(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(PestIncident::class);
    }

    /**
     * Check if planting is overdue
     */
    public function isOverdue(): bool
    {
        return $this->expected_harvest_date < Carbon::now() &&
            !in_array($this->status, [self::STATUS_HARVESTED, self::STATUS_FAILED]);
    }

    /**
     * Get days until harvest
     */
    public function daysUntilHarvest(): int
    {
        return Carbon::now()->diffInDays($this->expected_harvest_date, false);
    }

    /**
     * Get total yield from harvests
     */
    public function getTotalYieldAttribute()
    {
        return $this->harvests()->sum('yield');
    }

    /**
     * Initialize planting stages based on rice growth stages
     */
    public function initializePlantingStages()
    {
        $growthStages = RiceGrowthStage::getAllStagesOrdered();

        foreach ($growthStages as $stage) {
            $this->plantingStages()->create([
                'rice_growth_stage_id' => $stage->id,
                'status' => 'pending',
            ]);
        }
    }

    /**
     * Get current growth stage
     */
    public function getCurrentStage()
    {
        return $this->plantingStages()
            ->with('riceGrowthStage')
            ->where('status', 'in_progress')
            ->first();
    }

    /**
     * Get next pending stage
     */
    public function getNextPendingStage()
    {
        return $this->plantingStages()
            ->with('riceGrowthStage')
            ->where('status', 'pending')
            ->join('rice_growth_stages', 'planting_stages.rice_growth_stage_id', '=', 'rice_growth_stages.id')
            ->orderBy('rice_growth_stages.order_sequence')
            ->select('planting_stages.*')
            ->first();
    }

    /**
     * Initialize transplanting lifecycle fast-forward to tillering
     */
    public function startTransplantingStage()
    {
        $tilleringStage = RiceGrowthStage::where('stage_code', 'stage_2_tillering')->first();

        if ($tilleringStage) {
            $tilleringPlantingStage = $this->plantingStages()
                ->where('rice_growth_stage_id', $tilleringStage->id)
                ->first();

            if ($tilleringPlantingStage) {
                $priorStageIds = RiceGrowthStage::active()
                    ->where('order_sequence', '<', $tilleringStage->order_sequence)
                    ->pluck('id')
                    ->toArray();

                if (!empty($priorStageIds)) {
                    $this->plantingStages()
                        ->whereIn('rice_growth_stage_id', $priorStageIds)
                        ->get()
                        ->each(function ($stage) {
                            if ($stage->status !== 'completed') {
                                $stage->markAsCompleted('Completed in nursery (Transplanting)');
                            }
                        });
                }

                if ($tilleringPlantingStage->status !== 'in_progress') {
                    $tilleringPlantingStage->markAsStarted();
                }

                return;
            }
        }

        // fallback: treat as stage sequence 2 for transplanting
        $stages = $this->plantingStages()
            ->join('rice_growth_stages', 'planting_stages.rice_growth_stage_id', '=', 'rice_growth_stages.id')
            ->orderBy('rice_growth_stages.order_sequence')
            ->select('planting_stages.*')
            ->get();

        if ($stages->count() >= 2) {
            if ($stages[0]->status !== 'completed') {
                $stages[0]->markAsCompleted('Completed in nursery (Transplanting)');
            }
            if ($stages[1]->status !== 'in_progress') {
                $stages[1]->markAsStarted();
            }
        } elseif ($stages->count() > 0) {
            if ($stages[0]->status !== 'in_progress') {
                $stages[0]->markAsStarted();
            }
        }
    }

    /**
     * Get progress percentage
     */
    public function getProgressPercentage()
    {
        $totalStages = $this->plantingStages()->count();
        $completedStages = $this->plantingStages()->completed()->count();

        if ($totalStages === 0) {
            return 0;
        }

        return round(($completedStages / $totalStages) * 100, 2);
    }

    /**
     * Check if planting is rice
     */
    public function isRice()
    {
        return $this->crop_type === 'rice' || $this->rice_variety_id !== null;
    }

    /**
     * Get estimated yield based on variety and area
     */
    public function getEstimatedYield()
    {
        if (!$this->riceVariety || !$this->area_planted) {
            return null;
        }

        // Convert area to hectares if needed and calculate estimated yield
        $yieldPerHectare = $this->riceVariety->average_yield_per_hectare;
        return $this->area_planted * $yieldPerHectare;
    }

    /**
     * Get days since planting
     */
    public function getDaysSincePlanting()
    {
        return $this->planting_date->diffInDays(now());
    }

    /**
     * Check if planting is in critical stage
     */
    public function isInCriticalStage()
    {
        $currentStage = $this->getCurrentStage();
        if (!$currentStage) {
            return false;
        }

        // Define critical stages (flowering, grain filling)
        $criticalStages = ['flowering', 'grain_filling', 'ripening'];
        return in_array($currentStage->riceGrowthStage->stage_code, $criticalStages);
    }
}