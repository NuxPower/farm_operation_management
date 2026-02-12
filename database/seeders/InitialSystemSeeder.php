<?php

namespace Database\Seeders;

use App\Models\Farm;
use App\Models\WeatherLog;
use App\Models\User;
use App\Models\RiceGrowthStage;
use App\Models\RiceVariety;
use App\Models\PestLibrary;
use App\Models\PestAnalyticsRule;
use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class InitialSystemSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $this->seedMinimalUser();
        $this->seedRiceVarieties();
        $this->seedRiceGrowthStages();
        $this->seedPestLibrary();
        $this->seedWeatherData();
    }

    /**
     * Seed Minimal User (John Farmer)
     */
    private function seedMinimalUser(): void
    {
        User::updateOrCreate(
            ['email' => 'john@farmops.com'],
            [
                'first_name' => 'John',
                'last_name' => 'Farmer',
                'name' => 'John Farmer',
                'password' => Hash::make('john123'),
                'role' => 'farmer',
                'phone' => '+1-555-0101',
                'phone_verified_at' => now(),
                'address' => [],
            ]
        );

        echo "Seeded John Farmer credentials.\n";
    }

    /**
     * Seed Rice Varieties
     */
    private function seedRiceVarieties(): void
    {
        $varieties = [
            ['variety_code' => 'RICE-IR64', 'name' => 'IR64', 'description' => 'High-yielding, semi-dwarf Indica variety widely planted in SE Asia.', 'maturity_days' => 120, 'average_yield_per_hectare' => 5.6, 'season' => 'wet', 'grain_type' => 'long', 'resistance_level' => 'medium', 'notes' => 'Performs best in irrigated lowland fields with good fertility.'],
            ['variety_code' => 'RICE-JASMINE', 'name' => 'Thai Jasmine', 'description' => 'Premium fragrant rice valued for aroma and soft texture.', 'maturity_days' => 110, 'average_yield_per_hectare' => 4.9, 'season' => 'dry', 'grain_type' => 'long', 'resistance_level' => 'medium', 'notes' => 'Requires consistent irrigation and well-drained fields.'],
            ['variety_code' => 'RICE-BASMATI', 'name' => 'Basmati 370', 'description' => 'Traditional aromatic Basmati with elongated grains.', 'maturity_days' => 135, 'average_yield_per_hectare' => 4.3, 'season' => 'dry', 'grain_type' => 'long', 'resistance_level' => 'medium', 'notes' => 'Prefers cool nights; suited for river-fed plains.'],
            ['variety_code' => 'RICE-STICKY', 'name' => 'Glutinous Sticky Rice', 'description' => 'Round-grain sticky rice used for traditional delicacies.', 'maturity_days' => 105, 'average_yield_per_hectare' => 4.6, 'season' => 'wet', 'grain_type' => 'short', 'resistance_level' => 'high', 'notes' => 'Can tolerate temporary flooding; harvest promptly to retain stickiness.'],
            ['variety_code' => 'RICE-BROWN', 'name' => 'Wholegrain Brown Rice', 'description' => 'Nutritious variety harvested and milled for brown rice.', 'maturity_days' => 125, 'average_yield_per_hectare' => 5.1, 'season' => 'wet', 'grain_type' => 'medium', 'resistance_level' => 'medium', 'notes' => 'Responds well to organic fertilisation; ideal for health-conscious markets.'],
            ['variety_code' => 'RICE-SWARNA', 'name' => 'Swarna', 'description' => 'High-yielding variety with strong disease resistance.', 'maturity_days' => 130, 'average_yield_per_hectare' => 6.3, 'season' => 'wet', 'grain_type' => 'medium', 'resistance_level' => 'high', 'notes' => 'Handles flood-prone paddies; staple in South Asian production.'],
            ['variety_code' => 'RICE-RED', 'name' => 'Heirloom Red Cargo', 'description' => 'Deep-red wholegrain rice prized for antioxidants.', 'maturity_days' => 140, 'average_yield_per_hectare' => 3.9, 'season' => 'dry', 'grain_type' => 'medium', 'resistance_level' => 'medium', 'notes' => 'Requires careful drying; fetches premium prices in niche markets.'],
            ['variety_code' => 'RICE-KOSHI', 'name' => 'Koshihikari', 'description' => 'Short-grain Japanese rice with excellent eating quality.', 'maturity_days' => 118, 'average_yield_per_hectare' => 5.3, 'season' => 'dry', 'grain_type' => 'short', 'resistance_level' => 'high', 'notes' => 'Best grown in cooler climates; top choice for sushi-grade rice.'],
            ['variety_code' => 'RICE-NSIC-RC222', 'name' => 'NSIC Rc 222 (Tubigan 18)', 'description' => 'High-yielding variety capable of surviving flash floods, also known as Tubigan 18.', 'maturity_days' => 114, 'average_yield_per_hectare' => 6.1, 'season' => 'wet', 'grain_type' => 'long', 'resistance_level' => 'high', 'notes' => 'Resistant to stem borer and green leafhopper. Moderate resistance to brown planthopper.'],
            ['variety_code' => 'RICE-NSIC-RC216', 'name' => 'NSIC Rc 216 (Tubigan 17)', 'description' => 'Popular inbred variety known for good eating quality and high yield potential.', 'maturity_days' => 112, 'average_yield_per_hectare' => 6.0, 'season' => 'dry', 'grain_type' => 'long', 'resistance_level' => 'medium', 'notes' => 'Moderately resistant to brown planthopper and green leafhopper.'],
            ['variety_code' => 'RICE-NSIC-RC160', 'name' => 'NSIC Rc 160 (Tubigan 14)', 'description' => 'Known for its premium eating quality, soft and moist when cooked.', 'maturity_days' => 122, 'average_yield_per_hectare' => 5.6, 'season' => 'wet', 'grain_type' => 'long', 'resistance_level' => 'medium', 'notes' => 'Highly favored by millers and traders due to high head rice recovery.'],
            ['variety_code' => 'RICE-DINORADO', 'name' => 'Dinorado', 'description' => 'Indigenous upland rice variety from Mindanao, known for its pinkish grain and aroma.', 'maturity_days' => 130, 'average_yield_per_hectare' => 3.5, 'season' => 'dry', 'grain_type' => 'medium', 'resistance_level' => 'low', 'notes' => 'Aromatic and sticky when cooked. Often grown in upland areas.'],
            ['variety_code' => 'RICE-SINANDOMENG', 'name' => 'Sinandomeng', 'description' => 'Traditional variety popular for domestic consumption, soft and white.', 'maturity_days' => 115, 'average_yield_per_hectare' => 4.5, 'season' => 'wet', 'grain_type' => 'long', 'resistance_level' => 'medium', 'notes' => 'Good eating quality, remains soft even when cold.'],
        ];

        foreach ($varieties as $v) {
            RiceVariety::updateOrCreate(
                ['variety_code' => $v['variety_code']],
                [
                    'name' => $v['name'],
                    'description' => $v['description'],
                    'maturity_days' => $v['maturity_days'],
                    'average_yield_per_hectare' => $v['average_yield_per_hectare'],
                    'season' => $v['season'],
                    'grain_type' => $v['grain_type'],
                    'resistance_level' => $v['resistance_level'],
                    'characteristics' => ['notes' => $v['notes']],
                    'is_active' => true,
                ]
            );
        }

        echo "Seeded " . count($varieties) . " rice varieties.\n";
    }

    /**
     * Seed Rice Growth Stages
     */
    private function seedRiceGrowthStages(): void
    {
        $stages = [
            [
                'name' => 'Germination & Seedling',
                'stage_code' => 'stage_1_seedling',
                'description' => 'From soaking seeds to transplanting.',
                'typical_duration_days' => 20,
                'order_sequence' => 1,
            ],
            [
                'name' => 'Tillering',
                'stage_code' => 'stage_2_tillering',
                'description' => 'Development of tillers.',
                'typical_duration_days' => 30,
                'order_sequence' => 2,
            ],
            [
                'name' => 'Panicle Initiation',
                'stage_code' => 'stage_3_panicle',
                'description' => 'Start of reproductive phase.',
                'typical_duration_days' => 15,
                'order_sequence' => 3,
            ],
            [
                'name' => 'Flowering',
                'stage_code' => 'stage_4_flowering',
                'description' => 'Pollination and grain formation.',
                'typical_duration_days' => 15,
                'order_sequence' => 4,
            ],
            [
                'name' => 'Ripening',
                'stage_code' => 'stage_5_ripening',
                'description' => 'Grain filling and maturation.',
                'typical_duration_days' => 30,
                'order_sequence' => 5,
            ],
        ];

        foreach ($stages as $stageData) {
            RiceGrowthStage::firstOrCreate(
                ['stage_code' => $stageData['stage_code']],
                array_merge($stageData, [
                    'is_active' => true,
                    'key_activities' => ['watering'],
                    'weather_requirements' => ['warm'],
                ])
            );
        }

        echo "Seeded " . count($stages) . " rice growth stages.\n";
    }

    /**
     * Seed Pest Library and Rules
     */
    private function seedPestLibrary(): void
    {
        // Rice Blast
        $blast = PestLibrary::firstOrCreate(
            ['slug' => Str::slug('Rice Blast')],
            [
                'name' => 'Rice Blast',
                'type' => 'disease',
                'description' => 'A fungal disease affecting all parts of the rice plant, causing spindle-shaped lesions.',
                'symptoms' => 'Diamond/spindle-shaped lesions with gray centers on leaves; neck rot causing panicles to fall over.',
                'treatment_guidance' => 'Use fungicides (e.g., Tricyclazole, Isoprothiolane). Avoid excessive nitrogen fertilizer. Keep field flooded.',
                'images' => ['https://www.irri.org/sites/default/files/styles/science_standard/public/Rice%20blast%20symptoms%20on%20leaves.jpg']
            ]
        );

        $this->createPestRule($blast->id, 'humidity', '>', 90, null, 'high', 'High humidity (>90%) strongly favors Rice Blast spore germination.');
        $this->createPestRule($blast->id, 'temperature', 'between', 25, 28, 'high', 'Temperatures between 25-28°C are optimal for Rice Blast development.');
        $this->createPestRule($blast->id, 'rainfall', '>', 80, null, 'moderate', 'Frequent rainfall can spread blast spores.');

        // Brown Plant Hopper
        $bph = PestLibrary::firstOrCreate(
            ['slug' => Str::slug('Brown Plant Hopper')],
            [
                'name' => 'Brown Plant Hopper',
                'type' => 'insect',
                'scientific_name' => 'Nilaparvata lugens',
                'description' => 'Sucking pests that remove plant sap, causing "hopper burn" where plants turn brown and die.',
                'symptoms' => 'Yellowing and browning of leaves (Hopper burn), sooty mold at base of stems.',
                'treatment_guidance' => 'Drain field for 3-4 days. Use resistant varieties. Avoid indiscriminant insecticide use which kills natural enemies.',
                'images' => ['https://live.staticflickr.com/65535/51234567890_abcdef1234_b.jpg']
            ]
        );

        $this->createPestRule($bph->id, 'temperature', 'between', 28, 30, 'high', 'Temperatures of 28-30°C accelerate BPH reproduction.');
        $this->createPestRule($bph->id, 'humidity', '>', 80, null, 'high', 'High humidity (>80%) at plant base supports BPH survival.');

        // Yellow Stem Borer
        $ysb = PestLibrary::firstOrCreate(
            ['slug' => Str::slug('Yellow Stem Borer')],
            [
                'name' => 'Yellow Stem Borer',
                'type' => 'insect',
                'scientific_name' => 'Scirpophaga incertulas',
                'description' => 'Larvae bore into stems, causing "Deadheart" in vegetative stage and "Whitehead" in reproductive stage.',
                'symptoms' => 'Deadhearts (drying central shoot) and Whiteheads (empty, white panicles).',
                'treatment_guidance' => 'Install pheromone traps. Biological control (Trichogramma). Early planting.',
                'images' => ['https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Stem_borer_adult.jpg/640px-Stem_borer_adult.jpg']
            ]
        );

        $this->createPestRule($ysb->id, 'temperature', 'between', 28, 32, 'high', 'Warm temperatures (28-32°C) favor Stem Borer moth activity.');
        $this->createPestRule($ysb->id, 'humidity', '>', 90, null, 'moderate', 'High humidity increases egg hatching rates for stem borers.');

        // Green Leafhopper
        $glh = PestLibrary::firstOrCreate(
            ['slug' => Str::slug('Green Leafhopper')],
            [
                'name' => 'Green Leafhopper',
                'type' => 'insect',
                'scientific_name' => 'Nephotettix virescens',
                'description' => 'Major vector for Rice Tungro Virus. Feeds on sap.',
                'symptoms' => 'Stunted growth, yellowing leaves. Main damage is virus transmission.',
                'treatment_guidance' => 'Use resistant varieties. Manage weeds. Light traps.',
                'images' => ['https://knowledgebank.irri.org/images/stories/pests-and-diseases/insects/glh/GLH_adult.jpg']
            ]
        );

        $this->createPestRule($glh->id, 'temperature', 'between', 32, 34, 'high', 'Hot temperatures (32-34°C) trigger peak GLH population.');
        $this->createPestRule($glh->id, 'humidity', '>', 90, null, 'high', 'Morning humidity >90% favors GLH activity.');

        // Rice Tungro Virus
        $tungro = PestLibrary::firstOrCreate(
            ['slug' => Str::slug('Rice Tungro Virus')],
            [
                'name' => 'Rice Tungro Virus',
                'type' => 'disease',
                'description' => 'Most destructive virus disease of rice in SE Asia. Transmitted by Green Leafhopper.',
                'symptoms' => 'Stunted plants, yellow to orange-red discoloration of leaves, twisting of leaves.',
                'treatment_guidance' => 'Control the vector (GLH). Rogue infected plants immediately. Synchronous planting.',
                'images' => ['https://knowledgebank.irri.org/images/stories/pests-and-diseases/diseases/tungro/tungro1.jpg']
            ]
        );

        $this->createPestRule($tungro->id, 'temperature', 'between', 24, 32, 'high', 'Temperatures of 24-32°C facilitate rapid Tungro Virus transmission.');
        $this->createPestRule($tungro->id, 'humidity', '>', 85, null, 'moderate', 'Humid conditions support the vector (GLH) lifespan.');

        // Rice Black Bug
        $rbb = PestLibrary::firstOrCreate(
            ['slug' => Str::slug('Rice Black Bug')],
            [
                'name' => 'Rice Black Bug',
                'type' => 'insect',
                'scientific_name' => 'Scotinophara coarctata',
                'description' => 'Sapsucking bugs that attack base of stems. Cause "bugburn". Strongly attracted to light during full moon.',
                'symptoms' => 'Reddish-brown leaves, dead plants, empty grains.',
                'treatment_guidance' => 'Light traps during full moon. Raise water level to submerge eggs. Biological controls (Metarhizium).',
                'images' => ['https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_x_example_check_url']
            ]
        );

        $this->createPestRule($rbb->id, 'lunar_phase', 'equals', null, null, 'high', 'Full Moon phase triggers massive Rice Black Bug flight activity.');
        $this->createPestRule($rbb->id, 'humidity', '>', 85, null, 'moderate', 'High humidity increases RBB survival.');

        echo "Seeded pest library and analytics rules.\n";
    }

    /**
     * Helper to create pest rules
     */
    private function createPestRule($pestId, $metric, $condition, $min, $max, $riskLevel, $message): void
    {
        PestAnalyticsRule::firstOrCreate(
            [
                'pest_library_id' => $pestId,
                'metric' => $metric,
                'condition' => $condition,
                'value_min' => $min,
                'value_max' => $max,
            ],
            [
                'risk_level' => $riskLevel,
                'risk_message' => $message
            ]
        );
    }

    /**
     * Seed Weather Data (Fetch from API)
     */
    private function seedWeatherData(): void
    {
        $farms = Farm::whereNotNull('farm_coordinates')->get();

        if ($farms->isEmpty()) {
            echo "No farms with coordinates found. Skipping weather seeding.\n";
            return;
        }

        $endDate = Carbon::now();
        $startDate = Carbon::create(2023, 1, 1);
        $startDateStr = $startDate->format('Y-m-d');
        $endDateStr = $endDate->format('Y-m-d');

        foreach ($farms as $farm) {
            $coordinates = $farm->farm_coordinates;
            $lat = $coordinates['lat'] ?? 8.0276;
            $lon = $coordinates['lon'] ?? $coordinates['lng'] ?? 125.1885;

            echo "Fetching weather data for farm '{$farm->farm_name}' ({$lat}, {$lon})...\n";

            try {
                $response = Http::get("https://archive-api.open-meteo.com/v1/archive", [
                    'latitude' => $lat,
                    'longitude' => $lon,
                    'start_date' => $startDateStr,
                    'end_date' => $endDateStr,
                    'hourly' => 'temperature_2m,relative_humidity_2m,wind_speed_10m,precipitation,weather_code',
                    'timezone' => 'Asia/Manila'
                ]);

                if (!$response->successful()) {
                    echo "Failed to fetch Open-Meteo data: " . $response->body() . "\n";
                    continue;
                }

                $data = $response->json();
                $hourly = $data['hourly'];
                $count = 0;

                foreach ($hourly['time'] as $index => $time) {
                    $recordedAt = Carbon::parse($time);
                    if ($recordedAt->isAfter(now()) || $recordedAt->hour % 6 !== 0) {
                        continue;
                    }

                    WeatherLog::updateOrCreate(
                        ['farm_id' => $farm->id, 'recorded_at' => $recordedAt],
                        [
                            'temperature' => $hourly['temperature_2m'][$index],
                            'humidity' => $hourly['relative_humidity_2m'][$index],
                            'wind_speed' => $hourly['wind_speed_10m'][$index],
                            'rainfall' => $hourly['precipitation'][$index],
                            'conditions' => $this->mapWmoCode($hourly['weather_code'][$index]),
                        ]
                    );
                    $count++;
                }
                echo "Seeded {$count} weather logs for farm '{$farm->farm_name}'.\n";
            } catch (\Exception $e) {
                echo "Error seeding weather for '{$farm->farm_name}': " . $e->getMessage() . "\n";
                Log::error("WeatherSeeder Error: " . $e->getMessage());
            }
        }
    }

    /**
     * Map WMO Weather Codes
     */
    private function mapWmoCode(int $code): string
    {
        return match (true) {
            $code === 0 => 'clear',
            in_array($code, [1, 2, 3]) => 'cloudy',
            in_array($code, [45, 48]) => 'foggy',
            in_array($code, [51, 53, 55, 61, 63, 65, 80, 81, 82]) => 'rainy',
            in_array($code, [71, 73, 75, 77, 85, 86]) => 'snowy',
            in_array($code, [95, 96, 99]) => 'stormy',
            default => 'clear',
        };
    }
}
