<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PestAnalyticsRule extends Model
{
    use HasFactory;

    protected $fillable = [
        'pest_library_id',
        'metric',
        'condition',
        'value_min',
        'value_max',
        'duration_hours',
        'risk_level',
        'risk_message',
    ];

    public function pestLibrary(): BelongsTo
    {
        return $this->belongsTo(PestLibrary::class);
    }
}
