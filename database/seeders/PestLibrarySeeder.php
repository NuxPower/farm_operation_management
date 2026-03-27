<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\PestLibrary;
use App\Models\PestAnalyticsRule;
use Illuminate\Support\Str;

class PestLibrarySeeder extends Seeder
{
    /**
     * Run the database seeds.
     * Research Sources: PhilRice, IRRI, Academic Papers
     */
    public function run(): void
    {
        // 1. Rice Blast (Disease)
        // Source: Preferred temp 25-28C, Humidity > 90%, High Rainfall
        $blast = PestLibrary::firstOrCreate(
            ['slug' => Str::slug('Rice Blast')],
            [
                'name' => 'Rice Blast',
                'type' => 'disease',
                // 'scientific_name' => 'Magnaporthe oryzae',
                'description' => 'A fungal disease affecting all parts of the rice plant, causing spindle-shaped lesions.',
                'symptoms' => 'Diamond/spindle-shaped lesions with gray centers on leaves; neck rot causing panicles to fall over.',
                'treatment_guidance' => 'Use fungicides (e.g., Tricyclazole, Isoprothiolane). Avoid excessive nitrogen fertilizer. Keep field flooded.',
                'images' => ['https://www.irri.org/sites/default/files/styles/science_standard/public/Rice%20blast%20symptoms%20on%20leaves.jpg'],
                'vulnerable_stages' => ['vegetative', 'reproductive', 'ripening'],
            ]
        );
        $blast->update(['vulnerable_stages' => ['vegetative', 'reproductive', 'ripening']]);

        PestAnalyticsRule::firstOrCreate([
            'pest_library_id' => $blast->id,
            'metric' => 'humidity',
            'condition' => '>',
            'value_min' => 90,
        ], [
            'risk_level' => 'high',
            'risk_message' => 'High humidity (>90%) strongly favors Rice Blast spore germination.',
            'stage_note' => 'Leaf blast risk at vegetative stage; neck blast risk at reproductive stage',
        ]);

        PestAnalyticsRule::firstOrCreate([
            'pest_library_id' => $blast->id,
            'metric' => 'temperature',
            'condition' => 'between',
            'value_min' => 25,
            'value_max' => 28,
        ], [
            'risk_level' => 'high',
            'risk_message' => 'Temperatures between 25-28°C are optimal for Rice Blast development.'
        ]);

        PestAnalyticsRule::firstOrCreate([
            'pest_library_id' => $blast->id,
            'metric' => 'rainfall',
            'condition' => '>',
            'value_min' => 80, // mm
        ], [
            'risk_level' => 'moderate',
            'risk_message' => 'Frequent rainfall can spread blast spores.'
        ]);

        // 2. Brown Plant Hopper (Insect)
        // Source: Temp 28-30C, Humidity > 80%
        $bph = PestLibrary::firstOrCreate(
            ['slug' => Str::slug('Brown Plant Hopper')],
            [
                'name' => 'Brown Plant Hopper',
                'type' => 'insect',
                'scientific_name' => 'Nilaparvata lugens',
                'description' => 'Sucking pests that remove plant sap, causing "hopper burn" where plants turn brown and die.',
                'symptoms' => 'Yellowing and browning of leaves (Hopper burn), sooty mold at base of stems.',
                'treatment_guidance' => 'Drain field for 3-4 days. Use resistant varieties. Avoid indiscriminant insecticide use which kills natural enemies.',
                'images' => ['https://live.staticflickr.com/65535/51234567890_abcdef1234_b.jpg'],
                'vulnerable_stages' => ['vegetative', 'reproductive'],
            ]
        );
        $bph->update(['vulnerable_stages' => ['vegetative', 'reproductive']]);

        PestAnalyticsRule::firstOrCreate([
            'pest_library_id' => $bph->id,
            'metric' => 'temperature',
            'condition' => 'between',
            'value_min' => 28,
            'value_max' => 30,
        ], [
            'risk_level' => 'high',
            'risk_message' => 'Temperatures of 28-30°C accelerate BPH reproduction.',
            'stage_note' => 'Peak damage during tillering (vegetative) stage',
        ]);

        PestAnalyticsRule::firstOrCreate([
            'pest_library_id' => $bph->id,
            'metric' => 'humidity',
            'condition' => '>',
            'value_min' => 80,
        ], [
            'risk_level' => 'high',
            'risk_message' => 'High humidity (>80%) at plant base supports BPH survival.'
        ]);

        // 3. Yellow Stem Borer (Insect)
        // Source: Temp 28-32C, Humidity > 90%
        $ysb = PestLibrary::firstOrCreate(
            ['slug' => Str::slug('Yellow Stem Borer')],
            [
                'name' => 'Yellow Stem Borer',
                'type' => 'insect',
                'scientific_name' => 'Scirpophaga incertulas',
                'description' => 'Larvae bore into stems, causing "Deadheart" in vegetative stage and "Whitehead" in reproductive stage.',
                'symptoms' => 'Deadhearts (drying central shoot) and Whiteheads (empty, white panicles).',
                'treatment_guidance' => 'Install pheromone traps. Biological control (Trichogramma). Early planting.',
                'images' => ['https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Stem_borer_adult.jpg/640px-Stem_borer_adult.jpg'],
                'vulnerable_stages' => ['vegetative', 'reproductive'],
            ]
        );
        $ysb->update(['vulnerable_stages' => ['vegetative', 'reproductive']]);

        PestAnalyticsRule::firstOrCreate([
            'pest_library_id' => $ysb->id,
            'metric' => 'temperature',
            'condition' => 'between',
            'value_min' => 28,
            'value_max' => 32,
        ], [
            'risk_level' => 'high',
            'risk_message' => 'Warm temperatures (28-32°C) favor Stem Borer moth activity.',
            'stage_note' => 'Causes deadheart (vegetative) or whitehead (reproductive)',
        ]);

        PestAnalyticsRule::firstOrCreate([
            'pest_library_id' => $ysb->id,
            'metric' => 'humidity',
            'condition' => '>',
            'value_min' => 90,
        ], [
            'risk_level' => 'moderate',
            'risk_message' => 'High humidity increases egg hatching rates for stem borers.'
        ]);

        // 4. Green Leafhopper (Insect/Vector)
        // Source: Temp 32-34C, Humidity > 90%
        $glh = PestLibrary::firstOrCreate(
            ['slug' => Str::slug('Green Leafhopper')],
            [
                'name' => 'Green Leafhopper',
                'type' => 'insect',
                'scientific_name' => 'Nephotettix virescens',
                'description' => 'Major vector for Rice Tungro Virus. Feeds on sap.',
                'symptoms' => 'Stunted growth, yellowing leaves. Main damage is virus transmission.',
                'treatment_guidance' => 'Use resistant varieties. Manage weeds. Light traps.',
                'images' => ['https://knowledgebank.irri.org/images/stories/pests-and-diseases/insects/glh/GLH_adult.jpg'],
                'vulnerable_stages' => ['vegetative'],
            ]
        );
        $glh->update(['vulnerable_stages' => ['vegetative']]);

        PestAnalyticsRule::firstOrCreate([
            'pest_library_id' => $glh->id,
            'metric' => 'temperature',
            'condition' => 'between',
            'value_min' => 32,
            'value_max' => 34,
        ], [
            'risk_level' => 'high',
            'risk_message' => 'Hot temperatures (32-34°C) trigger peak GLH population.',
            'stage_note' => 'Seedling stage most vulnerable to Tungro transmission via GLH',
        ]);

        PestAnalyticsRule::firstOrCreate([
            'pest_library_id' => $glh->id,
            'metric' => 'humidity',
            'condition' => '>',
            'value_min' => 90,
        ], [
            'risk_level' => 'high',
            'risk_message' => 'Morning humidity >90% favors GLH activity.'
        ]);

        // 5. Rice Tungro Virus (Disease)
        // Source: Vector is GLH. Triggered by vector + Temp 24-32C
        $tungro = PestLibrary::firstOrCreate(
            ['slug' => Str::slug('Rice Tungro Virus')],
            [
                'name' => 'Rice Tungro Virus',
                'type' => 'disease',
                // 'scientific_name' => 'RTBV / RTSV',
                'description' => 'Most destructive virus disease of rice in SE Asia. Transmitted by Green Leafhopper.',
                'symptoms' => 'Stunted plants, yellow to orange-red discoloration of leaves, twisting of leaves.',
                'treatment_guidance' => 'Control the vector (GLH). Rogue infected plants immediately. Synchronous planting.',
                'images' => ['https://knowledgebank.irri.org/images/stories/pests-and-diseases/diseases/tungro/tungro1.jpg'],
                'vulnerable_stages' => ['vegetative'],
            ]
        );
        $tungro->update(['vulnerable_stages' => ['vegetative']]);

        PestAnalyticsRule::firstOrCreate([
            'pest_library_id' => $tungro->id,
            'metric' => 'temperature',
            'condition' => 'between',
            'value_min' => 24,
            'value_max' => 32,
        ], [
            'risk_level' => 'high',
            'risk_message' => 'Temperatures of 24-32°C facilitate rapid Tungro Virus transmission.',
            'stage_note' => 'Seedling to early tillering most susceptible',
        ]);

        // Note: Tungro also needs GLH presence, which is handled by overlap or logic, but we add a rule for vector risk awareness
        PestAnalyticsRule::firstOrCreate([
            'pest_library_id' => $tungro->id,
            'metric' => 'humidity',
            'condition' => '>',
            'value_min' => 85,
        ], [
            'risk_level' => 'moderate',
            'risk_message' => 'Humid conditions support the vector (GLH) lifespan.'
        ]);

        // 6. Rice Black Bug (Insect)
        // Source: Full Moon +/- 3 days, High Humidity
        $rbb = PestLibrary::firstOrCreate(
            ['slug' => Str::slug('Rice Black Bug')],
            [
                'name' => 'Rice Black Bug',
                'type' => 'insect',
                'scientific_name' => 'Scotinophara coarctata',
                'description' => 'Sapsucking bugs that attack base of stems. Cause "bugburn". Strongly attracted to light during full moon.',
                'symptoms' => 'Reddish-brown leaves, dead plants, empty grains.',
                'treatment_guidance' => 'Light traps during full moon. Raise water level to submerge eggs. Biological controls (Metarhizium).',
                'images' => ['https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_x_example_check_url'],
                'vulnerable_stages' => ['reproductive', 'ripening'],
            ]
        );
        $rbb->update(['vulnerable_stages' => ['reproductive', 'ripening']]);

        PestAnalyticsRule::firstOrCreate([
            'pest_library_id' => $rbb->id,
            'metric' => 'lunar_phase',
            'condition' => 'equals',
        ], [
            'risk_level' => 'high',
            'risk_message' => 'Full Moon phase triggers massive Rice Black Bug flight activity.',
            'stage_note' => 'Grain-filling (ripening) stage most damaged by RBB',
        ]);

        PestAnalyticsRule::firstOrCreate([
            'pest_library_id' => $rbb->id,
            'metric' => 'humidity',
            'condition' => '>',
            'value_min' => 85,
        ], [
            'risk_level' => 'moderate',
            'risk_message' => 'High humidity increases RBB survival.'
        ]);
    }
}
