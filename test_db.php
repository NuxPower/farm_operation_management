<?php
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();
try {
    $db = app('db')->connection()->getPdo();
    echo "DB Connected! " . $db->getAttribute(PDO::ATTR_SERVER_VERSION) . "\n";
} catch (\Throwable $e) {
    echo "DB Error: " . $e->getMessage() . "\n";
}
