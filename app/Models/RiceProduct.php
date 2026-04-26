<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class RiceProduct extends Model
{
    use HasFactory;

    protected $fillable = [
        'farmer_id',
        'rice_variety_id',
        'harvest_id',
        'inventory_item_id',
        'name',
        'description',
        'quantity_available',
        'unit',
        'price_per_unit',
        'quality_grade',
        'moisture_content',
        'purity_percentage',
        'harvest_date',
        'processing_method',
        'storage_conditions',
        'certification',
        'images',
        'location',
        'is_organic',
        'is_available',
        'production_status',
        'available_from',
        'minimum_order_quantity',
        'packaging_options',
        'delivery_options',
        'payment_terms',
        'contact_info',
        'notes',
    ];

    protected $casts = [
        'quantity_available' => 'decimal:2',
        'price_per_unit' => 'decimal:2',
        'moisture_content' => 'decimal:2',
        'purity_percentage' => 'decimal:2',
        'minimum_order_quantity' => 'decimal:2',
        'harvest_date' => 'date',
        'available_from' => 'date',
        'images' => 'array',
        'location' => 'array',
        'packaging_options' => 'array',
        'delivery_options' => 'array',
        'contact_info' => 'array',
        'is_organic' => 'boolean',
        'is_available' => 'boolean',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    /**
     * Get the images attribute with normalized URLs.
     * Converts legacy full URLs to relative paths for cross-environment compatibility.
     *
     * @param mixed $value
     * @return array|null
     */
    public function getImagesAttribute($value): ?array
    {
        if (empty($value)) {
            return null;
        }

        // Decode JSON if it's a string
        $images = is_string($value) ? json_decode($value, true) : $value;

        if (!is_array($images)) {
            return null;
        }

        // Normalize each image URL
        return array_map(function ($url) {
            if (empty($url)) {
                return null;
            }

            // If already a relative path, return as-is
            if (str_starts_with($url, '/storage/')) {
                return $url;
            }

            // Extract relative path from full URL (legacy data)
            // Handles URLs like "http://127.0.0.1:8000/storage/products/file.jpg"
            if (preg_match('#/storage/(products/[^?]+)#', $url, $matches)) {
                return '/storage/' . $matches[1];
            }

            // Fallback: return original if we can't parse it
            return $url;
        }, $images);
    }


    /**
     * Quality grade constants
     */
    const GRADE_PREMIUM = 'premium';
    const GRADE_GRADE_A = 'grade_a';
    const GRADE_GRADE_B = 'grade_b';
    const GRADE_COMMERCIAL = 'commercial';

    /**
     * Processing method constants
     */
    const PROCESSING_MILLED = 'milled';
    const PROCESSING_ORGANIC = 'organic';

    /**
     * Unit constants
     */
    const UNIT_KG = 'kg';
    const UNIT_TONS = 'tons';
    const UNIT_BAGS = 'bags';
    const UNIT_SACKS = 'sacks';

    /**
     * Production status constants
     */
    const STATUS_AVAILABLE = 'available';
    const STATUS_IN_PRODUCTION = 'in_production';
    const STATUS_OUT_OF_STOCK = 'out_of_stock';

    /**
     * Get the farmer who owns this product
     */
    public function farmer()
    {
        return $this->belongsTo(User::class, 'farmer_id');
    }

    /**
     * Get the rice variety for this product
     */
    public function riceVariety()
    {
        return $this->belongsTo(RiceVariety::class);
    }

    /**
     * Get the harvest this product came from
     */
    public function harvest()
    {
        return $this->belongsTo(Harvest::class);
    }

    /**
     * Get the inventory item for this product
     */
    public function inventoryItem()
    {
        return $this->belongsTo(InventoryItem::class);
    }

    /**
     * Attempt to find a matching inventory item for this product
     */
    public function findMatchingInventoryItem()
    {
        // 1. Return explicitly linked item if exists
        if ($this->inventory_item_id) {
            return $this->inventoryItem;
        }

        $baseQuery = InventoryItem::where('user_id', $this->farmer_id)
            ->where('category', InventoryItem::CATEGORY_PRODUCE)
            ->where('unit', $this->unit);

        // 2. Prefer inventory generated from the linked harvest's latest processed output
        foreach ($this->preferredInventoryNames() as $candidateName) {
            $match = (clone $baseQuery)->where('name', $candidateName)->first();
            if ($match) {
                return $match;
            }

            $match = (clone $baseQuery)->where('name', 'ILIKE', $candidateName)->first();
            if ($match) {
                return $match;
            }
        }

        // 3. Try to find by exact name match for this farmer
        $match = (clone $baseQuery)->where('name', $this->name)->first();
        if ($match) {
            return $match;
        }

        // 4. Try case-insensitive exact name match
        $match = (clone $baseQuery)->where('name', 'ILIKE', $this->name)->first();
        if ($match) {
            return $match;
        }

        // 5. Try partial match — product name contained in inventory item name
        //    e.g., product "IR64" matches inventory "IR64 (Premium)"
        $match = (clone $baseQuery)->where('name', 'ILIKE', $this->name . '%')->first();
        if ($match) {
            return $match;
        }

        // 6. Try partial match — inventory item name contained in product name
        //    e.g., inventory "IR64" matches product "IR64 Premium Rice"
        $match = (clone $baseQuery)->whereRaw('? ILIKE name || \'%\'', [$this->name])->first();
        if ($match) {
            return $match;
        }

        // 7. Try variety name with (Grade X) suffix (common pattern in HarvestController)
        $varietyName = $this->riceVariety?->name;
        if ($varietyName) {
            $match = (clone $baseQuery)->where('name', 'ILIKE', $varietyName . '%')->first();
            if ($match) {
                return $match;
            }
        }

        return null;
    }

    /**
     * Build the preferred inventory item names based on the linked harvest
     * and the latest completed post-harvest output.
     */
    private function preferredInventoryNames(): array
    {
        if (!$this->harvest_id) {
            return [];
        }

        $harvest = $this->relationLoaded('harvest')
            ? $this->harvest
            : Harvest::with('planting.riceVariety')->find($this->harvest_id);

        if (!$harvest) {
            return [];
        }

        $varietyName = $harvest->planting?->riceVariety?->name
            ?? $harvest->planting?->crop_type
            ?? $this->riceVariety?->name;

        if (!$varietyName) {
            return [];
        }

        $gradeSuffix = $harvest->quality_grade
            ? ' (Grade ' . $harvest->quality_grade . ')'
            : '';

        $candidates = [];
        $latestProcess = $harvest->getLatestProcess();

        if ($latestProcess) {
            $processSuffix = match ($latestProcess->process_type) {
                PostHarvestProcess::TYPE_THRESHING => ' - Threshed',
                PostHarvestProcess::TYPE_DRYING => ' - Dried',
                PostHarvestProcess::TYPE_MILLING => ' - Milled',
                default => null,
            };

            if ($processSuffix) {
                $candidates[] = $varietyName . $processSuffix . $gradeSuffix;
            }
        }

        if ($this->processing_method === self::PROCESSING_MILLED) {
            $candidates[] = $varietyName . ' - Milled' . $gradeSuffix;
        }

        $candidates[] = $varietyName . $gradeSuffix;

        return array_values(array_unique(array_filter($candidates)));
    }

    /**
     * Get the orders for this product
     */
    public function orders()
    {
        return $this->hasMany(RiceOrder::class, 'rice_product_id');
    }

    /**
     * Get the reviews for this product
     */
    public function reviews()
    {
        return $this->hasMany(ProductReview::class, 'rice_product_id');
    }

    /**
     * Scope to get available products
     */
    public function scopeAvailable($query)
    {
        return $query->where('is_available', true)
            ->where('quantity_available', '>', 0);
    }

    /**
     * Scope to get products in production
     */
    public function scopeInProduction($query)
    {
        return $query->where('production_status', self::STATUS_IN_PRODUCTION);
    }

    /**
     * Scope to get products that are available or can be pre-ordered
     */
    public function scopeAvailableOrPreOrder($query)
    {
        return $query->where('is_available', true)
            ->where(function ($q) {
                $q->where('production_status', self::STATUS_AVAILABLE)
                    ->orWhere('production_status', self::STATUS_IN_PRODUCTION);
            });
    }

    /**
     * Check if product is in production
     */
    public function isInProduction(): bool
    {
        return $this->production_status === self::STATUS_IN_PRODUCTION;
    }

    /**
     * Check if product can be pre-ordered
     */
    public function canBePreOrdered(): bool
    {
        return $this->production_status === self::STATUS_IN_PRODUCTION && $this->available_from !== null;
    }

    /**
     * Scope to filter by quality grade
     */
    public function scopeByGrade($query, $grade)
    {
        return $query->where('quality_grade', $grade);
    }

    /**
     * Scope to filter by rice variety
     */
    public function scopeByVariety($query, $varietyId)
    {
        return $query->where('rice_variety_id', $varietyId);
    }

    /**
     * Scope to filter by organic
     */
    public function scopeOrganic($query)
    {
        return $query->where('is_organic', true);
    }

    /**
     * Scope to filter by location
     */
    public function scopeNearLocation($query, $latitude, $longitude, $radiusKm = 50)
    {
        return $query->whereRaw(
            "(6371 * acos(cos(radians(?)) * cos(radians(JSON_EXTRACT(location, '$.latitude'))) * cos(radians(JSON_EXTRACT(location, '$.longitude')) - radians(?)) + sin(radians(?)) * sin(radians(JSON_EXTRACT(location, '$.latitude'))))) < ?",
            [$latitude, $longitude, $latitude, $radiusKm]
        );
    }

    /**
     * Scope to filter by price range
     */
    public function scopePriceRange($query, $minPrice, $maxPrice)
    {
        return $query->whereBetween('price_per_unit', [$minPrice, $maxPrice]);
    }

    /**
     * Get average rating
     */
    public function getAverageRatingAttribute()
    {
        return $this->reviews()->avg('rating') ?? 0;
    }

    /**
     * Get total reviews count
     */
    public function getReviewsCountAttribute()
    {
        return $this->reviews()->count();
    }

    /**
     * Check if product has sufficient quantity
     */
    public function hasSufficientQuantity($requestedQuantity)
    {
        return $this->quantity_available >= $requestedQuantity;
    }

    /**
     * Reserve quantity for an order
     */
    public function reserveQuantity($quantity)
    {
        // Use a transaction and lockForUpdate to ensure atomicity and prevent race conditions
        \Illuminate\Support\Facades\DB::transaction(function () use ($quantity) {
            // Re-fetch the product with a lock
            $freshProduct = self::where('id', $this->id)->lockForUpdate()->first();

            if (!$freshProduct->hasSufficientQuantity($quantity)) {
                throw new \Exception('Insufficient quantity available');
            }

            // Decrement on the locked instance
            $freshProduct->decrement('quantity_available', $quantity);

            // Mark as unavailable if no quantity left (using the fresh instance)
            if ($freshProduct->quantity_available <= 0) {
                $freshProduct->update(['is_available' => false]);
            }

            // Sync current instance with fresh data to reflect changes in the calling scope
            $this->quantity_available = $freshProduct->quantity_available;
            $this->is_available = $freshProduct->is_available;
        });
    }

    /**
     * Release reserved quantity (e.g., when order is cancelled)
     */
    public function releaseQuantity($quantity)
    {
        $this->increment('quantity_available', $quantity);

        // Mark as available if quantity is restored
        if ($this->quantity_available > 0) {
            $this->update(['is_available' => true]);
        }
    }

    /**
     * Get quality score based on various factors
     */
    public function getQualityScore()
    {
        $score = 0;

        // Grade scoring
        switch ($this->quality_grade) {
            case self::GRADE_PREMIUM:
                $score += 40;
                break;
            case self::GRADE_GRADE_A:
                $score += 30;
                break;
            case self::GRADE_GRADE_B:
                $score += 20;
                break;
            case self::GRADE_COMMERCIAL:
                $score += 10;
                break;
        }

        // Moisture content scoring (optimal 12-14%)
        if ($this->moisture_content >= 12 && $this->moisture_content <= 14) {
            $score += 20;
        } elseif ($this->moisture_content >= 10 && $this->moisture_content <= 16) {
            $score += 15;
        } else {
            $score += 5;
        }

        // Purity percentage scoring
        if ($this->purity_percentage >= 95) {
            $score += 20;
        } elseif ($this->purity_percentage >= 90) {
            $score += 15;
        } elseif ($this->purity_percentage >= 85) {
            $score += 10;
        } else {
            $score += 5;
        }

        // Organic bonus
        if ($this->is_organic) {
            $score += 10;
        }

        // Certification bonus
        if ($this->certification) {
            $score += 10;
        }

        return min(100, $score);
    }

    /**
     * Get freshness indicator based on harvest date
     */
    public function getFreshnessIndicator()
    {
        if (!$this->harvest_date) {
            return 'unknown';
        }

        $daysSinceHarvest = $this->harvest_date->diffInDays(now());

        if ($daysSinceHarvest <= 30) {
            return 'very_fresh';
        } elseif ($daysSinceHarvest <= 90) {
            return 'fresh';
        } elseif ($daysSinceHarvest <= 180) {
            return 'good';
        } elseif ($daysSinceHarvest <= 365) {
            return 'acceptable';
        } else {
            return 'old';
        }
    }

    /**
     * Get estimated delivery time based on location
     */
    public function getEstimatedDeliveryTime($buyerLocation = null)
    {
        if (!$buyerLocation || !$this->location) {
            return 'contact_seller';
        }

        // Simple distance-based estimation
        $distance = $this->calculateDistance(
            $this->location['latitude'] ?? 0,
            $this->location['longitude'] ?? 0,
            $buyerLocation['latitude'] ?? 0,
            $buyerLocation['longitude'] ?? 0
        );

        if ($distance <= 50) {
            return '1-2 days';
        } elseif ($distance <= 200) {
            return '2-4 days';
        } elseif ($distance <= 500) {
            return '4-7 days';
        } else {
            return '1-2 weeks';
        }
    }

    /**
     * Calculate distance between two points
     */
    private function calculateDistance($lat1, $lon1, $lat2, $lon2)
    {
        $earthRadius = 6371; // km

        $dLat = deg2rad($lat2 - $lat1);
        $dLon = deg2rad($lon2 - $lon1);

        $a = sin($dLat / 2) * sin($dLat / 2) + cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * sin($dLon / 2) * sin($dLon / 2);
        $c = 2 * atan2(sqrt($a), sqrt(1 - $a));

        return $earthRadius * $c;
    }

    /**
     * Deduct quantity from linked inventory item
     * 
     * @param float $quantity Quantity to deduct
     * @param int|null $orderId Order ID for transaction reference
     * @return bool True if deduction was successful
     */
    public function deductFromInventory($quantity, $orderId = null)
    {
        // Find matching inventory item
        $inventoryItem = $this->findMatchingInventoryItem();

        if (!$inventoryItem) {
            \Log::warning('Inventory deduction failed: no matching inventory item found', [
                'product_id' => $this->id,
                'product_name' => $this->name,
                'farmer_id' => $this->farmer_id,
                'inventory_item_id' => $this->inventory_item_id,
                'order_id' => $orderId,
                'quantity' => $quantity,
            ]);
            return false;
        }

        // Lock the inventory item for update to prevent race conditions
        // We use a fresh query to get the lock
        $inventoryItem = \App\Models\InventoryItem::where('id', $inventoryItem->id)->lockForUpdate()->first();

        if ($inventoryItem && $inventoryItem->removeStock($quantity)) {
            // Log transaction
            \App\Models\InventoryTransaction::create([
                'inventory_item_id' => $inventoryItem->id,
                'user_id' => $this->farmer_id,
                'transaction_type' => 'out',
                'quantity' => $quantity,
                'unit_cost' => $inventoryItem->unit_price,
                'total_cost' => $quantity * ($inventoryItem->unit_price ?? 0),
                'reference_type' => 'RiceOrder',
                'reference_id' => $orderId,
                'notes' => "Sold via Marketplace Product: {$this->name}",
                'transaction_date' => now(),
            ]);

            // Auto-link ID if missing for future performance
            if (!$this->inventory_item_id) {
                $this->update(['inventory_item_id' => $inventoryItem->id]);
            }

            return true;
        }

        return false;
    }
}