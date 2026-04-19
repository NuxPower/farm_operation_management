<?php

namespace Database\Seeders;

use App\Models\Farm;
use App\Models\WeatherLog;
use App\Models\User;
use App\Models\RiceGrowthStage;
use App\Models\RiceVariety;
use App\Models\PestLibrary;
use App\Models\PestAnalyticsRule;
use App\Models\Field;
use App\Models\Laborer;
use App\Models\Planting;
use App\Models\PlantingStage;
use App\Models\Task;
use App\Models\Harvest;
use App\Models\InventoryItem;
use App\Models\InventoryTransaction;
use App\Models\Expense;
use App\Models\RiceProduct;
use App\Models\PostHarvestProcess;
use App\Models\Sale;
use App\Models\Buyer;
use App\Models\RiceOrder;
use App\Models\SeedPlanting;
use App\Models\PestIncident;
use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class LargeDataSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $this->seedMinimalUser();
        $this->seedFarm();
        $this->seedRiceVarieties();
        $this->seedRiceGrowthStages();
        $this->seedPestLibrary();
        $this->seedWeatherData();
        
        $this->seedLargeAmountsOfData();
    }

    /**
     * Seed Large amounts of data for testing purposes
     */
    private function seedLargeAmountsOfData(): void
    {
        $farmer = User::where('email', 'john@farmops.com')->first();
        if (!$farmer) return;

        $farm = Farm::where('user_id', $farmer->id)->first();
        if (!$farm) return;

        $varieties = RiceVariety::all();
        if ($varieties->isEmpty()) return;

        echo "\n--- Seeding Large Amounts of Data ---\n";

        // ─── 1. Buyers (off-platform customers) ───────────────────────────
        $buyerTypes = ['individual', 'restaurant', 'wholesaler', 'retailer', 'exporter'];
        $buyers = collect();
        for ($i = 0; $i < 20; $i++) {
            $buyers->push(Buyer::create([
                'user_id'        => $farmer->id,
                'name'           => fake()->company(),
                'contact_person' => fake()->name(),
                'email'          => fake()->unique()->safeEmail(),
                'phone'          => fake()->phoneNumber(),
                'address'        => fake()->address(),
                'type'           => fake()->randomElement($buyerTypes),
                'status'         => 'active',
                'payment_terms'  => fake()->randomElement(['cod', 'net_15', 'net_30']),
                'credit_limit'   => fake()->randomFloat(2, 5000, 50000),
                'notes'          => fake()->sentence(),
                'contact_info'   => json_encode([
                    'email'   => fake()->safeEmail(),
                    'phone'   => fake()->phoneNumber(),
                    'address' => fake()->address(),
                ]),
            ]));
        }
        echo "Seeded 20 Buyers.\n";

        // ─── 2. Laborers ──────────────────────────────────────────────────
        $laborers = Laborer::factory()->count(50)->create([
            'user_id' => $farmer->id,
        ]);
        echo "Seeded 50 Laborers.\n";

        // ─── 3. Fields ────────────────────────────────────────────────────
        $fields = Field::factory()->count(40)->create([
            'user_id' => $farmer->id,
            'farm_id' => $farm->id,
        ]);
        echo "Seeded 40 Fields.\n";

        // ─── 4. Seedbeds (SeedPlanting) ───────────────────────────────────
        $seedStatuses = [
            SeedPlanting::STATUS_SOWN,
            SeedPlanting::STATUS_GERMINATING,
            SeedPlanting::STATUS_READY,
            SeedPlanting::STATUS_TRANSPLANTED,
        ];
        for ($i = 0; $i < 30; $i++) {
            SeedPlanting::create([
                'user_id'                  => $farmer->id,
                'rice_variety_id'          => $varieties->random()->id,
                'planting_date'            => now()->subDays(rand(5, 45)),
                'expected_transplant_date' => now()->addDays(rand(5, 25)),
                'quantity'                 => fake()->randomFloat(2, 1, 20),
                'unit'                     => 'kg',
                'status'                   => fake()->randomElement($seedStatuses),
                'notes'                    => fake()->optional()->sentence(),
                'batch_id'                 => 'BATCH-' . strtoupper(Str::random(6)),
            ]);
        }
        echo "Seeded 30 Seedbeds.\n";

        // ─── 5. Inventory Items with proper pricing & transactions ─────────
        $inventorySpecs = [
            // [name, category, unit, price_min, price_max, min_stock, stock_min, stock_max]
            ['Urea Fertilizer 46-0-0',       'fertilizer', 'kg',     18,  28,  50, 100, 800],
            ['Complete Fertilizer 14-14-14', 'fertilizer', 'kg',     22,  35,  50, 100, 600],
            ['Organic Compost',              'fertilizer', 'bags',    5,  12,  20,  30, 200],
            ['NPK 16-20-0',                  'fertilizer', 'kg',     20,  30,  40, 100, 500],
            ['Tricyclazole Fungicide',        'pesticide', 'liters', 250, 400,   5,  10,  80],
            ['Isoprothiolane Fungicide',      'pesticide', 'liters', 200, 350,   5,  10,  60],
            ['Buprofezin Insecticide',        'pesticide', 'liters', 180, 300,   5,   8,  50],
            ['Cartap Hydrochloride',          'pesticide', 'kg',     150, 280,   5,   5,  40],
            ['Glyphosate Herbicide',          'pesticide', 'liters', 120, 200,   5,  10,  60],
            ['NSIC Rc 222 Seeds',             'seeds',     'kg',      50,  90,  20,  50, 300],
            ['Dinorado Seeds',               'seeds',     'kg',      70, 120,  20,  30, 200],
            ['IR64 Seeds',                   'seeds',     'kg',      45,  80,  20,  50, 250],
            ['Thai Jasmine Seeds',           'seeds',     'kg',      60, 100,  15,  30, 180],
            ['Hand Tractor',                 'equipment', 'units', 45000, 80000, 1,  1,   5],
            ['Mechanical Thresher',          'equipment', 'units', 35000, 65000, 1,  1,   4],
            ['Water Pump (2 inch)',           'equipment', 'units',  3500,  7000, 2,  2,  10],
            ['Sprayer (Backpack 16L)',        'equipment', 'units',  1200,  2500, 3,  3,  15],
            ['Sickle',                       'tools',     'pieces',   80,  180, 10,  20,  80],
            ['Rake',                         'tools',     'pieces',   60,  130, 10,  15,  60],
            ['Shovel',                       'tools',     'pieces',  120,  220, 10,  15,  50],
            ['Hoe (Asarol)',                 'tools',     'pieces',   90,  180, 10,  20,  70],
            ['Milled Rice – IR64',           'produce',   'kg',       42,   52,  0, 100,1000],
            ['Milled Rice – Dinorado',       'produce',   'kg',       68,   85,  0,  50, 500],
            ['Milled Rice – Jasmine',        'produce',   'kg',       58,   72,  0,  50, 600],
            ['Palay (Threshed)',             'produce',   'sacks',    15,   25,  0,  50, 400],
            ['Dried Palay',                  'produce',   'sacks',    18,   28,  0,  50, 400],
        ];
        $inventoryItems = collect();
        foreach ($inventorySpecs as $spec) {
            [$iname, $cat, $unit, $pmin, $pmax, $minStock, $smin, $smax] = $spec;
            $unitPrice    = fake()->randomFloat(2, $pmin, $pmax);
            $currentStock = fake()->randomFloat(2, $smin, $smax);
            $item = InventoryItem::create([
                'user_id'       => $farmer->id,
                'name'          => $iname,
                'category'      => $cat,
                'unit'          => $unit,
                'unit_price'    => $unitPrice,
                'current_stock' => $currentStock,
                'minimum_stock' => $minStock,
                'supplier'      => fake()->company(),
                'notes'         => fake()->optional()->sentence(),
            ]);
            $inventoryItems->push($item);

            // Purchase transaction
            InventoryTransaction::create([
                'inventory_item_id' => $item->id,
                'user_id'           => $farmer->id,
                'transaction_type'  => 'in',
                'quantity'          => $currentStock,
                'unit_cost'         => $unitPrice,
                'total_cost'        => round($currentStock * $unitPrice, 2),
                'notes'             => 'Initial stock purchase',
                'transaction_date'  => now()->subDays(rand(30, 180)),
                'reference_type'    => 'purchase',
            ]);

            // Purchase expense
            Expense::create([
                'user_id'             => $farmer->id,
                'description'         => "Purchase: {$iname}",
                'amount'              => round($currentStock * $unitPrice, 2),
                'category'            => 'inventory_purchase',
                'date'                => now()->subDays(rand(30, 180)),
                'payment_method'      => fake()->randomElement(['cash', 'bank_transfer', 'gcash']),
                'related_entity_type' => Expense::ENTITY_TYPE_INVENTORY_ITEM,
                'related_entity_id'   => $item->id,
            ]);
        }
        echo "Seeded " . count($inventorySpecs) . " Inventory Items with pricing and purchase expenses.\n";

        // ─── 6. Plantings, Tasks, Pest Incidents, Harvests, Post-Harvest ──
        $allPlantings = collect();
        $allHarvests  = collect();
        $allProcesses = collect();

        foreach ($fields as $field) {
            $plantings = Planting::factory()->count(rand(3, 5))->create([
                'field_id'        => $field->id,
                'rice_variety_id' => $varieties->random()->id,
            ]);
            $allPlantings = $allPlantings->merge($plantings);

            foreach ($plantings as $planting) {
                Task::factory()->count(rand(5, 10))->create([
                    'planting_id' => $planting->id,
                    'assigned_to' => $laborers->random()->id,
                ]);

                // Pest incidents (0-3 per planting)
                for ($p = 0; $p < rand(0, 3); $p++) {
                    $pestType     = fake()->randomElement(PestIncident::TYPES);
                    $severity     = fake()->randomElement(PestIncident::SEVERITIES);
                    $treatCost    = fake()->randomFloat(2, 200, 3000);
                    $detectedDate = now()->subDays(rand(5, 90));
                    PestIncident::create([
                        'planting_id'       => $planting->id,
                        'user_id'           => $farmer->id,
                        'pest_type'         => $pestType,
                        'pest_name'         => fake()->randomElement([
                            'Rice Blast', 'Brown Plant Hopper', 'Yellow Stem Borer',
                            'Green Leafhopper', 'Rice Tungro Virus', 'Rice Black Bug',
                            'Bacterial Blight', 'Sheath Blight',
                        ]),
                        'severity'          => $severity,
                        'affected_area'     => fake()->randomFloat(2, 0.1, 5.0),
                        'detected_date'     => $detectedDate,
                        'symptoms'          => fake()->sentence(),
                        'treatment_applied' => fake()->randomElement([
                            'Fungicide spray', 'Insecticide application',
                            'Drain field', 'Light traps', 'Biological control',
                        ]),
                        'treatment_date'    => $detectedDate->copy()->addDays(rand(1, 7)),
                        'treatment_cost'    => $treatCost,
                        'status'            => fake()->randomElement([
                            PestIncident::STATUS_ACTIVE,
                            PestIncident::STATUS_TREATED,
                            PestIncident::STATUS_RESOLVED,
                        ]),
                    ]);
                    // Pest treatment expense
                    Expense::create([
                        'user_id'             => $farmer->id,
                        'description'         => "Pest treatment ({$pestType}) on {$field->name}",
                        'amount'              => $treatCost,
                        'category'            => 'pesticide',
                        'date'                => $detectedDate->copy()->addDays(rand(1, 7)),
                        'payment_method'      => fake()->randomElement(['cash', 'gcash']),
                        'planting_id'         => $planting->id,
                        'related_entity_type' => Expense::ENTITY_TYPE_PLANTING,
                        'related_entity_id'   => $planting->id,
                    ]);
                }

                // Harvest most plantings
                if (rand(0, 3) > 0) {
                    $qty     = fake()->randomFloat(2, 200, 1200);
                    $harvest = Harvest::factory()->create([
                        'planting_id' => $planting->id,
                        'quantity'    => $qty,
                        'yield'       => $qty,
                    ]);
                    $allHarvests->push($harvest);

                    // Harvest labour expense
                    Expense::create([
                        'user_id'             => $farmer->id,
                        'description'         => "Harvest labour on {$field->name}",
                        'amount'              => fake()->randomFloat(2, 500, 5000),
                        'category'            => 'labor',
                        'date'                => $harvest->harvest_date ?? now()->subDays(rand(1, 30)),
                        'payment_method'      => 'cash',
                        'planting_id'         => $planting->id,
                        'related_entity_type' => Expense::ENTITY_TYPE_HARVEST,
                        'related_entity_id'   => $harvest->id,
                    ]);

                    // Post-harvest pipeline: threshing → drying → milling
                    $pipeline = [
                        ['type' => PostHarvestProcess::TYPE_THRESHING, 'in_unit' => 'bushels',    'out_unit' => 'sacks_palay', 'rate' => 0.95],
                        ['type' => PostHarvestProcess::TYPE_DRYING,    'in_unit' => 'sacks_palay', 'out_unit' => 'dried palay', 'rate' => 0.82],
                        ['type' => PostHarvestProcess::TYPE_MILLING,   'in_unit' => 'dried palay', 'out_unit' => 'sacks_rice',  'rate' => 0.65],
                    ];
                    $prevProcess = null;
                    $curQty      = $qty;
                    for ($step = 0; $step < rand(1, 3); $step++) {
                        $s    = $pipeline[$step];
                        $oQty = $curQty * $s['rate'];
                        $cost = fake()->randomFloat(2, 300, 2500);
                        $proc = PostHarvestProcess::create([
                            'harvest_id'        => $harvest->id,
                            'planting_id'       => $planting->id,
                            'user_id'           => $farmer->id,
                            'parent_process_id' => $prevProcess?->id,
                            'process_type'      => $s['type'],
                            'process_date'      => now()->subDays(rand(3, 20)),
                            'completed_date'    => now()->subDays(rand(1, 3)),
                            'status'            => PostHarvestProcess::STATUS_COMPLETED,
                            'input_quantity'    => $curQty,
                            'input_unit'        => $s['in_unit'],
                            'output_quantity'   => $oQty,
                            'output_unit'       => $s['out_unit'],
                            'cost'              => $cost,
                            'cost_type'         => PostHarvestProcess::COST_TYPE_SERVICE_FIXED,
                            'notes'             => 'Completed ' . $s['type'],
                        ]);
                        $allProcesses->push($proc);
                        Expense::create([
                            'user_id'             => $farmer->id,
                            'description'         => ucfirst($s['type']) . ' processing cost',
                            'amount'              => $cost,
                            'category'            => 'processing',
                            'date'                => now()->subDays(rand(1, 20)),
                            'payment_method'      => fake()->randomElement(['cash', 'gcash']),
                            'planting_id'         => $planting->id,
                            'related_entity_type' => Expense::ENTITY_TYPE_POST_HARVEST_PROCESS,
                            'related_entity_id'   => $proc->id,
                        ]);
                        $prevProcess = $proc;
                        $curQty      = $oQty;
                    }
                }
            }
        }
        echo "Seeded Plantings, Tasks, Pest Incidents, Harvests, and Post-Harvest Processes.\n";

        // ─── 7. Monthly labor + farm expenses (12 months) ─────────────────
        $expenseCategories = Expense::getCategories();
        for ($m = 0; $m < 12; $m++) {
            $baseDate = now()->subMonths($m);
            for ($e = 0; $e < rand(8, 20); $e++) {
                $laborer = $laborers->random();
                $days    = rand(1, 5);
                $wage    = fake()->randomFloat(2, 350, 800);
                Expense::create([
                    'user_id'             => $farmer->id,
                    'description'         => "Daily wage – {$laborer->name}",
                    'amount'              => round($wage * $days, 2),
                    'category'            => 'labor',
                    'date'                => $baseDate->copy()->addDays(rand(0, 27)),
                    'payment_method'      => 'cash',
                    'related_entity_type' => Expense::ENTITY_TYPE_LABORER,
                    'related_entity_id'   => $laborer->id,
                ]);
            }
            for ($e = 0; $e < rand(3, 8); $e++) {
                Expense::create([
                    'user_id'        => $farmer->id,
                    'description'    => fake()->sentence(4),
                    'amount'         => fake()->randomFloat(2, 100, 5000),
                    'category'       => fake()->randomElement($expenseCategories),
                    'date'           => $baseDate->copy()->addDays(rand(0, 27)),
                    'payment_method' => fake()->randomElement(['cash', 'gcash', 'bank_transfer']),
                ]);
            }
        }
        echo "Seeded 12 months of labor and farm expenses.\n";

        // ─── 8. Rice Products linked to harvests ──────────────────────────
        $riceProducts  = collect();
        $produceItems  = $inventoryItems->where('category', 'produce')->values();
        foreach ($allHarvests->take(60) as $harvest) {
            $variety     = $varieties->firstWhere('id', $harvest->planting->rice_variety_id) ?? $varieties->random();
            $pricePerKg  = fake()->randomFloat(2, 38, 75);
            $availableQty = fake()->randomFloat(2, 20, 200);
            $invItem      = $produceItems->isNotEmpty() ? $produceItems->random() : null;
            $product = RiceProduct::create([
                'farmer_id'          => $farmer->id,
                'rice_variety_id'    => $variety->id,
                'harvest_id'         => $harvest->id,
                'inventory_item_id'  => $invItem?->id,
                'name'               => $variety->name . ' – ' . fake()->randomElement(['Premium', 'Grade A', 'Grade B', 'Commercial']),
                'description'        => fake()->sentence(),
                'quantity_available' => $availableQty,
                'unit'               => 'kg',
                'price_per_unit'     => $pricePerKg,
                'quality_grade'      => fake()->randomElement(['premium', 'grade_a', 'grade_b', 'commercial']),
                'moisture_content'   => fake()->randomFloat(1, 12.0, 14.5),
                'purity_percentage'  => fake()->randomFloat(1, 92.0, 99.5),
                'harvest_date'       => $harvest->harvest_date ?? now()->subDays(rand(10, 90)),
                'processing_method'  => fake()->randomElement(['milled', 'brown', 'parboiled']),
                'is_organic'         => (bool) rand(0, 1),
                'is_available'       => true,
                'production_status'  => 'available',
            ]);
            $riceProducts->push($product);
        }
        echo "Seeded {$riceProducts->count()} Rice Products linked to harvests.\n";

        // ─── 9. Direct Sales (off-platform) ───────────────────────────────
        $saleCount = 0;
        foreach ($allHarvests->take(50) as $harvest) {
            if (rand(0, 1)) {
                $qty      = fake()->randomFloat(2, 10, 300);
                $unitPx   = fake()->randomFloat(2, 35, 70);
                $saleDate = now()->subDays(rand(1, 180));
                Sale::create([
                    'user_id'        => $farmer->id,
                    'harvest_id'     => $harvest->id,
                    'buyer_id'       => $buyers->random()->id,
                    'quantity'       => $qty,
                    'unit_price'     => $unitPx,
                    'total_amount'   => round($qty * $unitPx, 2),
                    'sale_date'      => $saleDate,
                    'payment_method' => fake()->randomElement(['cash', 'bank_transfer', 'check', 'credit']),
                    'payment_status' => fake()->randomElement(['paid', 'pending', 'partial']),
                    'notes'          => fake()->optional()->sentence(),
                ]);
                $saleCount++;
            }
        }
        echo "Seeded {$saleCount} direct Sales.\n";

        // ─── 10. Marketplace Orders (RiceOrder) with linked Sales ─────────
        $orderCount    = 0;
        $orderStatuses = [
            RiceOrder::STATUS_PENDING,
            RiceOrder::STATUS_CONFIRMED,
            RiceOrder::STATUS_READY_FOR_PICKUP,
            RiceOrder::STATUS_PICKED_UP,
        ];
        // Re-use or create buyer users
        $buyerUsers = User::where('role', 'buyer')->get();
        if ($buyerUsers->count() < 5) {
            for ($b = 0; $b < 10; $b++) {
                $buyerUsers->push(User::create([
                    'name'              => fake()->name(),
                    'first_name'        => fake()->firstName(),
                    'last_name'         => fake()->lastName(),
                    'email'             => fake()->unique()->safeEmail(),
                    'password'          => Hash::make('password'),
                    'role'              => 'buyer',
                    'phone'             => fake()->phoneNumber(),
                    'phone_verified_at' => now(),
                ]));
            }
        }
        foreach ($riceProducts->take(40) as $product) {
            $numOrders = rand(1, 4);
            for ($o = 0; $o < $numOrders; $o++) {
                $qty       = fake()->randomFloat(2, 5, 50);
                $unitPx    = $product->price_per_unit;
                $status    = fake()->randomElement($orderStatuses);
                $orderDate = now()->subDays(rand(1, 120));
                $isPaid    = in_array($status, [RiceOrder::STATUS_PICKED_UP, RiceOrder::STATUS_CONFIRMED]);
                $order = RiceOrder::create([
                    'buyer_id'               => $buyerUsers->random()->id,
                    'rice_product_id'        => $product->id,
                    'quantity'               => $qty,
                    'unit_price'             => $unitPx,
                    'total_amount'           => round($qty * $unitPx, 2),
                    'status'                 => $status,
                    'delivery_method'        => fake()->randomElement(['pickup', 'courier']),
                    'payment_method'         => fake()->randomElement(['cash', 'bank_transfer', 'check', 'credit']),
                    'payment_status'         => $isPaid ? RiceOrder::PAYMENT_PAID : RiceOrder::PAYMENT_PENDING,
                    'order_date'             => $orderDate,
                    'expected_delivery_date' => $orderDate->copy()->addDays(rand(3, 14)),
                    'actual_delivery_date'   => $status === RiceOrder::STATUS_PICKED_UP
                                                ? $orderDate->copy()->addDays(rand(1, 7))
                                                : null,
                    'notes'                  => fake()->optional()->sentence(),
                    'is_pre_order'           => false,
                    'delivery_address'       => [
                        'street'   => fake()->streetAddress(),
                        'city'     => 'Malaybalay',
                        'province' => 'Bukidnon',
                    ],
                ]);
                $orderCount++;

                // For completed orders, record a Sale entry too
                if ($status === RiceOrder::STATUS_PICKED_UP) {
                    Sale::create([
                        'user_id'        => $farmer->id,
                        'harvest_id'     => $product->harvest_id,
                        'buyer_id'       => $buyers->random()->id,
                        'rice_order_id'  => $order->id,
                        'quantity'       => $qty,
                        'unit_price'     => $unitPx,
                        'total_amount'   => round($qty * $unitPx, 2),
                        'sale_date'      => $order->actual_delivery_date ?? $orderDate->copy()->addDays(1),
                        'payment_method' => in_array($order->payment_method, ['cash', 'bank_transfer', 'check', 'credit'])
                                            ? $order->payment_method
                                            : 'cash',
                        'payment_status' => 'paid',
                        'notes'          => 'Marketplace order #' . $order->id,
                    ]);
                }
            }
        }
        echo "Seeded {$orderCount} Marketplace Orders with linked Sales.\n";

        echo "\n=== Large Data Seeding Complete! ===\n";
        echo "  Buyers:             20\n";
        echo "  Laborers:           50\n";
        echo "  Fields:             40\n";
        echo "  Seedbeds:           30\n";
        echo "  Plantings:          {$allPlantings->count()}\n";
        echo "  Harvests:           {$allHarvests->count()}\n";
        echo "  Post-Harvest Procs: {$allProcesses->count()}\n";
        echo "  Inventory Items:    " . count($inventorySpecs) . " (priced)\n";
        echo "  Rice Products:      {$riceProducts->count()}\n";
        echo "  Direct Sales:       {$saleCount}\n";
        echo "  Marketplace Orders: {$orderCount}\n";
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
                'address' => [
                    'street' => '456 Farm Road',
                    'city' => 'Rural Town',
                    'state' => 'RT',
                    'country' => 'USA',
                    'postal_code' => '54321'
                ],
            ]
        );

        echo "Seeded John Farmer credentials.\n";
    }

    /**
     * Seed Farm for John Farmer
     */
    private function seedFarm(): void
    {
        $farmer = User::where('email', 'john@farmops.com')->first();

        if (!$farmer) {
            echo "Farmer not found. Skipping farm seeding.\n";
            return;
        }

        $farm = Farm::updateOrCreate(
            [
                'user_id' => $farmer->id,
                'name' => "John's Farm",
            ],
            [
                'location' => 'Managok, City of Malaybalay, Bukidnon',
                'farm_coordinates' => [
                    'lat' => 8.0276,
                    'lon' => 125.1885,
                ],
                'total_area' => 50.0,
                'cultivated_area' => 40.0,
                'soil_type' => 'loam',
                'soil_ph' => 6.4,
                'water_source' => 'well',
                'irrigation_type' => 'sprinkler',
                'is_setup_complete' => true,
            ]
        );

        echo "Seeded John's Farm.\n";
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

            echo "Fetching weather data for farm '{$farm->name}' ({$lat}, {$lon})...\n";

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
                echo "Seeded {$count} weather logs for farm '{$farm->name}'.\n";
            } catch (\Exception $e) {
                echo "Error seeding weather for '{$farm->name}': " . $e->getMessage() . "\n";
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
