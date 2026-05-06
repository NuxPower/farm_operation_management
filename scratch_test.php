<?php
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

try {
    $user = \App\Models\User::first();
    echo "Found user: " . $user->email . "\n";
    $status = \Illuminate\Support\Facades\Password::sendResetLink(['email' => $user->email]);
    echo "Status: " . $status . "\n";
} catch (\Exception $e) {
    echo "Exception: " . $e->getMessage() . "\n";
}
