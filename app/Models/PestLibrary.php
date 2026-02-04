<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class PestLibrary extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'slug',
        'type',
        'scientific_name',
        'description',
        'symptoms',
        'treatment_guidance',
        'images',
    ];

    protected $casts = [
        'images' => 'array',
    ];

    public function rules(): HasMany
    {
        return $this->hasMany(PestAnalyticsRule::class);
    }
}
