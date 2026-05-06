<?php

namespace Database\Seeders;

use App\Models\ActivityLog;
use App\Models\Buyer;
use App\Models\CartItem;
use App\Models\Category;
use App\Models\Expense;
use App\Models\Favorite;
use App\Models\Farm;
use App\Models\Field;
use App\Models\Harvest;
use App\Models\InventoryItem;
use App\Models\InventoryTransaction;
use App\Models\Laborer;
use App\Models\LaborWage;
use App\Models\Notification;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\PestIncident;
use App\Models\Planting;
use App\Models\PlantingStage;
use App\Models\PostHarvestProcess;
use App\Models\PriceNegotiation;
use App\Models\ProductReview;
use App\Models\RiceGrowthStage;
use App\Models\RiceOrder;
use App\Models\RiceOrderMessage;
use App\Models\RiceProduct;
use App\Models\RiceVariety;
use App\Models\Sale;
use App\Models\ScheduledReport;
use App\Models\SeedPlanting;
use App\Models\Task;
use App\Models\User;
use App\Models\WeatherLog;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class EntireSystemSeeder extends Seeder
{
    public function run(): void
    {
        // Use AnibukidSystemSeeder as the canonical user/farm bootstrap.
        $this->call(AnibukidSystemSeeder::class);

        $farmer = User::where('email', 'anibukidfarm@gmail.com')->firstOrFail();
        $farm = Farm::where('user_id', $farmer->id)->firstOrFail();
        $varieties = RiceVariety::query()->get();
        $stages = RiceGrowthStage::query()->orderBy('order_sequence')->get();

        $buyers = $this->seedBuyers();
        [$fields, $laborers] = $this->seedFarmOpsData($farmer, $farm, $varieties);
        [$plantings, $tasks, $harvests] = $this->seedProductionFlow($farmer, $fields, $laborers, $varieties, $stages);
        $inventoryItems = $this->seedInventory($farmer);
        $this->seedFinanceAndSales($farmer, $buyers, $harvests, $inventoryItems, $tasks);
        [$products, $orders] = $this->seedMarketplace($farmer, $buyers, $harvests, $inventoryItems);
        $this->seedMarketplaceMeta($farmer, $farm, $buyers, $products, $orders);

        $this->command?->info('EntireSystemSeeder completed with full relational sample data.');
    }

    private function seedBuyers()
    {
        $buyerUsers = collect([
            [
                'email' => 'procurement.bukidfresh@example.com',
                'name' => 'Bukid Fresh Procurement',
                'first_name' => 'Bukid',
                'last_name' => 'Fresh',
                'phone' => '+63-917-220-1001',
            ],
            [
                'email' => 'mindanaograins.trading@example.com',
                'name' => 'Mindanao Grains Trading',
                'first_name' => 'Mindanao',
                'last_name' => 'Trading',
                'phone' => '+63-917-220-1002',
            ],
            [
                'email' => 'malaybalay.ricehub@example.com',
                'name' => 'Malaybalay Rice Hub',
                'first_name' => 'Malaybalay',
                'last_name' => 'Rice Hub',
                'phone' => '+63-917-220-1003',
            ],
        ])->map(function (array $u) {
            return User::updateOrCreate(
                ['email' => $u['email']],
                [
                    'name' => $u['name'],
                    'first_name' => $u['first_name'],
                    'last_name' => $u['last_name'],
                    'password' => Hash::make('buyer123'),
                    'role' => 'buyer',
                    'phone' => $u['phone'],
                    'phone_verified_at' => now(),
                ]
            );
        });

        return $buyerUsers->map(function (User $user) {
            return Buyer::updateOrCreate(
                ['user_id' => $user->id],
                [
                    'name' => $user->name,
                    'contact_info' => $user->email . ' | ' . $user->phone,
                    'contact_person' => $user->name,
                    'email' => $user->email,
                    'phone' => $user->phone,
                    'address' => 'Bukidnon, Philippines',
                    'type' => 'retailer',
                    'status' => 'active',
                    'payment_terms' => 'net_15',
                    'credit_limit' => 150000,
                ]
            );
        });
    }

    private function seedFarmOpsData(User $farmer, Farm $farm, $varieties): array
    {
        $fieldRows = [
            ['name' => 'North Irrigated Block', 'size' => 3.2, 'soil_type' => 'loam'],
            ['name' => 'Creekside Paddock', 'size' => 2.8, 'soil_type' => 'clay_loam'],
            ['name' => 'Upper Terrace Plot', 'size' => 2.4, 'soil_type' => 'silt_loam'],
        ];

        $fields = collect($fieldRows)->map(function (array $row, int $idx) use ($farmer, $farm) {
            return Field::updateOrCreate(
                ['farm_id' => $farm->id, 'name' => $row['name']],
                [
                    'user_id' => $farmer->id,
                    'size' => $row['size'],
                    'soil_type' => $row['soil_type'],
                    'location' => [
                        'lat' => 8.0276 + (0.004 * $idx),
                        'lon' => 125.1885 + (0.003 * $idx),
                        'address' => $row['name'] . ', Managok, Malaybalay City',
                    ],
                    'water_access' => 'good',
                    'drainage_quality' => 'good',
                ]
            );
        });

        $laborers = collect([
            ['name' => 'Ramon Dela Cruz', 'phone' => '+63-915-801-1111', 'rate' => 650],
            ['name' => 'Joel Matingaw', 'phone' => '+63-915-801-1112', 'rate' => 620],
            ['name' => 'Maricel Alingasa', 'phone' => '+63-915-801-1113', 'rate' => 700],
            ['name' => 'Lito Balaoro', 'phone' => '+63-915-801-1114', 'rate' => 630],
        ])->map(function (array $laborer) use ($farmer) {
            return Laborer::updateOrCreate(
                ['user_id' => $farmer->id, 'name' => $laborer['name']],
                [
                    'phone' => $laborer['phone'],
                    'rate' => $laborer['rate'],
                    'rate_type' => 'daily',
                ]
            );
        });

        // Seedbeds
        foreach ($varieties->take(3) as $idx => $variety) {
            SeedPlanting::updateOrCreate(
                ['user_id' => $farmer->id, 'batch_id' => 'ANB-2026-B' . ($idx + 1)],
                [
                    'rice_variety_id' => $variety->id,
                    'planting_date' => now()->subDays(60 - ($idx * 5))->toDateString(),
                    'expected_transplant_date' => now()->subDays(40 - ($idx * 3))->toDateString(),
                    'quantity' => 35 + ($idx * 6),
                    'unit' => 'kg',
                    'status' => 'transplanted',
                    'notes' => 'Healthy germination batch used for wet-season cycle.',
                ]
            );
        }

        // Weather logs
        foreach ($fields as $field) {
            for ($d = 0; $d < 7; $d++) {
                WeatherLog::updateOrCreate(
                    [
                        'farm_id' => $farm->id,
                        'recorded_at' => now()->subDays($d)->setTime(6, 0),
                    ],
                    [
                        'temperature' => 24.5 + ($d * 0.3),
                        'humidity' => 78 - $d,
                        'wind_speed' => 7.5 + ($d * 0.2),
                        'rainfall' => $d % 3 === 0 ? 4.2 : 0.0,
                        'conditions' => $d % 3 === 0 ? 'rainy' : 'cloudy',
                    ]
                );
            }
        }

        return [$fields, $laborers];
    }

    private function seedProductionFlow(User $farmer, $fields, $laborers, $varieties, $stages): array
    {
        $plantings = collect();
        $tasks = collect();
        $harvests = collect();

        foreach ($fields as $idx => $field) {
            $planting = Planting::create([
                'field_id' => $field->id,
                'rice_variety_id' => $varieties[$idx % max($varieties->count(), 1)]->id,
                'crop_type' => 'rice',
                'planting_date' => now()->subDays(130 - ($idx * 10)),
                'expected_harvest_date' => now()->subDays(10 - ($idx * 2)),
                'actual_harvest_date' => now()->subDays(6 - $idx),
                'status' => 'harvested',
                'planting_method' => 'transplanting',
                'seed_rate' => 55,
                'area_planted' => $field->size,
                'season' => 'wet',
                'notes' => 'Standard transplanting with pre-emergence weed control.',
            ]);
            $plantings->push($planting);

            foreach ($stages->take(4) as $stage) {
                PlantingStage::updateOrCreate(
                    ['planting_id' => $planting->id, 'rice_growth_stage_id' => $stage->id],
                    [
                        'status' => 'completed',
                        'started_at' => now()->subDays(120 - ($stage->order_sequence * 20)),
                        'completed_at' => now()->subDays(100 - ($stage->order_sequence * 20)),
                        'notes' => 'Stage achieved with stable canopy and expected vigor.',
                    ]
                );
            }

            $taskTypes = ['watering', 'fertilizing', 'weeding', 'pest_control', 'harvesting'];
            foreach ($taskTypes as $k => $taskType) {
                $task = Task::create([
                    'field_id' => $field->id,
                    'planting_id' => $planting->id,
                    'task_type' => $taskType,
                    'due_date' => now()->subDays(90 - ($k * 18)),
                    'description' => ucfirst(str_replace('_', ' ', $taskType)) . ' cycle for ' . $field->name,
                    'status' => $k < 4 ? 'completed' : 'in_progress',
                    'assigned_to' => $laborers[$k % $laborers->count()]->id,
                ]);
                $tasks->push($task);
            }

            $harvest = Harvest::create([
                'planting_id' => $planting->id,
                'harvest_date' => now()->subDays(6 - $idx),
                'yield' => 142 + ($idx * 13),
                'quantity' => 142 + ($idx * 13),
                'quality' => 'good',
                'quality_grade' => 'grade_a',
                'notes' => 'Harvest completed under fair weather with low shattering losses.',
            ]);
            $harvests->push($harvest);

            PestIncident::create([
                'planting_id' => $planting->id,
                'user_id' => $farmer->id,
                'pest_type' => 'insect',
                'pest_name' => 'Brown Plant Hopper',
                'severity' => 'moderate',
                'affected_area' => 0.6,
                'detected_date' => now()->subDays(44)->toDateString(),
                'symptoms' => 'Localized hopper burn in low-lying patch.',
                'treatment_applied' => 'Drain-and-spray management with threshold-based application.',
                'treatment_date' => now()->subDays(42)->toDateString(),
                'treatment_cost' => 2800,
                'status' => 'resolved',
            ]);
        }

        return [$plantings, $tasks, $harvests];
    }

    private function seedInventory(User $farmer)
    {
        $specs = [
            ['name' => 'Urea Fertilizer 46-0-0', 'category' => 'fertilizer', 'unit' => 'kg', 'price' => 26.50, 'stock' => 420, 'min' => 90],
            ['name' => 'Complete Fertilizer 14-14-14', 'category' => 'fertilizer', 'unit' => 'kg', 'price' => 31.00, 'stock' => 310, 'min' => 70],
            ['name' => 'Buprofezin Insecticide', 'category' => 'pesticide', 'unit' => 'liters', 'price' => 265.00, 'stock' => 22, 'min' => 8],
            ['name' => 'Certified NSIC Rc 222 Seeds', 'category' => 'seeds', 'unit' => 'kg', 'price' => 85.00, 'stock' => 140, 'min' => 35],
            ['name' => 'Milled Rice - Grade A', 'category' => 'produce', 'unit' => 'kg', 'price' => 52.00, 'stock' => 780, 'min' => 120],
        ];

        return collect($specs)->map(function (array $spec) use ($farmer) {
            $item = InventoryItem::updateOrCreate(
                ['user_id' => $farmer->id, 'name' => $spec['name']],
                [
                    'category' => $spec['category'],
                    'unit' => $spec['unit'],
                    'unit_price' => $spec['price'],
                    'price' => $spec['price'],
                    'current_stock' => $spec['stock'],
                    'quantity' => $spec['stock'],
                    'minimum_stock' => $spec['min'],
                    'min_stock' => $spec['min'],
                ]
            );

            InventoryTransaction::create([
                'inventory_item_id' => $item->id,
                'user_id' => $farmer->id,
                'transaction_type' => 'in',
                'quantity' => $spec['stock'],
                'unit_cost' => $spec['price'],
                'total_cost' => $spec['stock'] * $spec['price'],
                'notes' => 'Starting stock for complete system demo',
                'transaction_date' => now()->subDays(20),
                'reference_type' => 'purchase',
            ]);

            return $item;
        });
    }

    private function seedFinanceAndSales(User $farmer, $buyers, $harvests, $inventoryItems, $tasks): void
    {
        foreach ($inventoryItems as $item) {
            Expense::create([
                'user_id' => $farmer->id,
                'description' => 'Inventory procurement: ' . $item->name,
                'amount' => (float) $item->current_stock * (float) $item->unit_price,
                'category' => 'inventory_purchase',
                'date' => now()->subDays(19),
                'payment_method' => 'bank_transfer',
                'related_entity_type' => 'inventory_item',
                'related_entity_id' => $item->id,
            ]);
        }

        foreach ($harvests as $index => $harvest) {
            $buyer = $buyers[$index % $buyers->count()];
            $qty = 80 + ($index * 12);
            $unitPrice = 31.50;

            Sale::create([
                'user_id' => $farmer->id,
                'harvest_id' => $harvest->id,
                'buyer_id' => $buyer->id,
                'quantity' => $qty,
                'unit_price' => $unitPrice,
                'total_amount' => $qty * $unitPrice,
                'sale_date' => now()->subDays(4 - $index),
                'payment_method' => 'bank_transfer',
                'payment_status' => 'paid',
                'notes' => 'Direct palay sale to repeat institutional buyer',
            ]);
        }

        foreach ($tasks->take(4) as $task) {
            LaborWage::create([
                'laborer_id' => $task->assigned_to,
                'task_id' => $task->id,
                'hours_worked' => 8,
                'wage_amount' => 680,
                'date' => now()->subDays(7),
            ]);
        }
    }

    private function seedMarketplace(User $farmer, $buyers, $harvests, $inventoryItems): array
    {
        $products = collect();
        foreach ($harvests as $idx => $harvest) {
            $varietyId = Planting::find($harvest->planting_id)?->rice_variety_id ?? RiceVariety::query()->value('id');
            $inv = $inventoryItems->firstWhere('category', 'produce');
            $product = RiceProduct::create([
                'farmer_id' => $farmer->id,
                'rice_variety_id' => $varietyId,
                'harvest_id' => $harvest->id,
                'inventory_item_id' => $inv?->id,
                'name' => 'Anibukid Premium Batch ' . ($idx + 1),
                'description' => 'Freshly milled rice from the latest wet-season cycle in Managok.',
                'quantity_available' => 180 - ($idx * 20),
                'unit' => 'kg',
                'price_per_unit' => 54 + $idx,
                'minimum_order_quantity' => 10,
                'quality_grade' => 'grade_a',
                'processing_method' => 'milled',
                'moisture_content' => 13.8,
                'is_available' => true,
                'production_status' => 'available',
            ]);
            $products->push($product);
        }

        $orders = collect();
        foreach ($products as $i => $product) {
            $buyerUserId = $buyers[$i % $buyers->count()]->user_id;
            $qty = 25 + ($i * 5);
            $order = RiceOrder::create([
                'buyer_id' => $buyerUserId,
                'rice_product_id' => $product->id,
                'quantity' => $qty,
                'unit_price' => $product->price_per_unit,
                'total_amount' => $qty * $product->price_per_unit,
                'status' => $i === 0 ? 'confirmed' : 'pending',
                'delivery_address' => [
                    'street' => 'National Highway',
                    'barangay' => 'Poblacion',
                    'city' => 'Malaybalay',
                    'province' => 'Bukidnon',
                ],
                'delivery_method' => $i === 0 ? 'pickup' : 'courier',
                'payment_method' => 'bank_transfer',
                'payment_status' => $i === 0 ? 'paid' : 'pending',
                'order_date' => now()->subDays(2 + $i),
                'expected_delivery_date' => now()->addDays(2 + $i)->toDateString(),
                'buyer_notes' => 'Please provide lot and moisture details per bag.',
            ]);
            $orders->push($order);
        }

        return [$products, $orders];
    }

    private function seedMarketplaceMeta(User $farmer, Farm $farm, $buyers, $products, $orders): void
    {
        foreach ($orders as $index => $order) {
            RiceOrderMessage::create([
                'rice_order_id' => $order->id,
                'sender_id' => $order->buyer_id,
                'message' => 'Can you confirm loading time and bag labeling for this order?',
                'read_at' => now(),
            ]);

            RiceOrderMessage::create([
                'rice_order_id' => $order->id,
                'sender_id' => $farmer->id,
                'message' => 'Confirmed. Loading starts 8:00 AM and each bag includes batch code.',
                'read_at' => now(),
            ]);

            PriceNegotiation::create([
                'rice_order_id' => $order->id,
                'proposer_id' => $order->buyer_id,
                'proposed_price' => $order->unit_price - 1.50,
                'status' => $index === 0 ? 'accepted' : 'pending',
                'response_message' => $index === 0 ? 'Accepted for this volume.' : null,
                'responded_at' => $index === 0 ? now()->subDay() : null,
            ]);
        }

        foreach ($orders->take(2) as $order) {
            ProductReview::create([
                'rice_product_id' => $order->rice_product_id,
                'buyer_id' => $order->buyer_id,
                'rice_order_id' => $order->id,
                'rating' => 4.8,
                'title' => 'Consistent quality and clean milling',
                'review_text' => 'Grains were uniform, moisture was on target, and delivery coordination was smooth.',
                'quality_rating' => 4.9,
                'delivery_rating' => 4.6,
                'farmer_rating' => 5.0,
                'would_recommend' => true,
                'verified_purchase' => true,
                'is_approved' => true,
            ]);
        }

        foreach ($buyers as $buyer) {
            CartItem::updateOrCreate(
                ['buyer_id' => $buyer->user_id, 'rice_product_id' => $products->first()->id],
                ['quantity' => 15]
            );
            Favorite::firstOrCreate(['user_id' => $buyer->user_id, 'rice_product_id' => $products->last()->id]);
        }

        $orderLegacy = Order::create([
            'buyer_id' => $buyers->first()->user_id,
            'status' => 'confirmed',
            'total_amount' => 18900,
        ]);
        OrderItem::create([
            'order_id' => $orderLegacy->id,
            'inventory_item_id' => InventoryItem::query()->first()->id,
            'quantity' => 60,
            'unit_price' => 315,
        ]);

        foreach ([
            ['name' => 'Field Inputs', 'description' => 'Seeds, fertilizers, pesticides'],
            ['name' => 'Post-Harvest', 'description' => 'Drying, milling, hauling costs'],
        ] as $cat) {
            Category::firstOrCreate(['name' => $cat['name']], ['description' => $cat['description']]);
        }

        $harvest = Harvest::query()->first();
        $planting = Planting::query()->find($harvest?->planting_id);
        $task = Task::query()->first();

        $threshing = PostHarvestProcess::create([
            'harvest_id' => $harvest->id,
            'planting_id' => $planting->id,
            'user_id' => $farmer->id,
            'task_id' => $task?->id,
            'process_type' => 'threshing',
            'status' => 'completed',
            'input_quantity' => 140,
            'input_unit' => 'sacks_palay',
            'output_quantity' => 126,
            'output_unit' => 'sacks_palay',
            'weight_loss_percentage' => 10,
            'process_date' => now()->subDays(8)->toDateString(),
            'completed_date' => now()->subDays(7)->toDateString(),
            'cost' => 3200,
            'cost_type' => 'service_fixed',
            'service_provider' => 'Managok Thresher Services',
            'notes' => 'Moisture stable and minimal grain loss.',
        ]);

        PostHarvestProcess::create([
            'harvest_id' => $harvest->id,
            'planting_id' => $planting->id,
            'user_id' => $farmer->id,
            'parent_process_id' => $threshing->id,
            'process_type' => 'drying',
            'status' => 'completed',
            'input_quantity' => 126,
            'input_unit' => 'sacks_palay',
            'output_quantity' => 104,
            'output_unit' => 'dried_palay',
            'weight_loss_percentage' => 17.46,
            'process_date' => now()->subDays(7)->toDateString(),
            'completed_date' => now()->subDays(5)->toDateString(),
            'cost' => 2800,
            'cost_type' => 'service_fixed',
            'service_provider' => 'Bukidnon Solar Drying Cooperative',
        ]);

        ScheduledReport::updateOrCreate(
            ['user_id' => $farmer->id, 'report_type' => 'financial', 'frequency' => 'monthly'],
            [
                'farm_id' => $farm->id,
                'email' => $farmer->email,
                'parameters' => ['include' => ['sales', 'expenses', 'inventory']],
                'is_active' => true,
                'last_sent_at' => now()->subDays(3),
            ]
        );

        foreach ($buyers as $buyer) {
            Notification::create([
                'user_id' => $buyer->user_id,
                'type' => 'order_status',
                'title' => 'Order update from Anibukid Farm',
                'message' => 'Your order is now being prepared for dispatch.',
                'data' => ['order_ids' => $orders->pluck('id')->take(1)->values()],
                'link' => '/marketplace/orders',
            ]);
        }

        ActivityLog::create([
            'user_id' => $farmer->id,
            'action' => 'system.seeded',
            'model_type' => self::class,
            'model_id' => 1,
            'new_values' => ['seed' => 'EntireSystemSeeder', 'fingerprint' => Str::uuid()->toString()],
            'description' => 'Entire demo dataset loaded with farm, production, inventory, and marketplace flows.',
            'ip_address' => '127.0.0.1',
            'user_agent' => 'Seeder/CLI',
        ]);

        // Additional data for tables without dedicated models in this project.
        DB::table('inventory_categories')->updateOrInsert(
            ['code' => 'fertilizer'],
            [
                'name' => 'Fertilizer',
                'description' => 'Nutrient inputs for field application',
                'color' => '#16A34A',
                'is_active' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ]
        );

        DB::table('inventory_alerts')->insert([
            'inventory_item_id' => InventoryItem::query()->first()->id,
            'alert_type' => 'reorder_point',
            'severity' => 'medium',
            'title' => 'Reorder planning suggested',
            'message' => 'Current stock trend indicates reorder needed within two weeks.',
            'is_active' => true,
            'is_read' => false,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $groupId = DB::table('laborer_groups')->insertGetId([
            'user_id' => $farmer->id,
            'name' => 'Harvest Crew A',
            'description' => 'Primary crew for harvest and hauling',
            'color' => '#0EA5E9',
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        DB::table('group_laborer')->insert([
            'laborer_group_id' => $groupId,
            'laborer_id' => Laborer::query()->first()->id,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $templateId = DB::table('task_templates')->insertGetId([
            'rice_growth_stage_id' => RiceGrowthStage::query()->first()->id,
            'name' => 'Basal Fertilizer Application',
            'description' => 'Apply complete fertilizer after field draining.',
            'task_type' => 'fertilizing',
            'days_from_stage_start' => 7,
            'estimated_duration_hours' => 4,
            'priority' => 'high',
            'is_mandatory' => true,
            'is_weather_dependent' => false,
            'is_active' => true,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $plantingStageId = PlantingStage::query()->first()->id;
        DB::table('automated_tasks')->insert([
            'planting_id' => Planting::query()->first()->id,
            'planting_stage_id' => $plantingStageId,
            'task_template_id' => $templateId,
            'task_id' => Task::query()->first()->id,
            'title' => 'Auto: Basal fertilizer timing',
            'description' => 'Generated from stage template for first nutrient schedule.',
            'scheduled_date' => now()->addDay(),
            'due_date' => now()->addDays(2),
            'status' => 'ready',
            'auto_generated' => true,
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }
}

