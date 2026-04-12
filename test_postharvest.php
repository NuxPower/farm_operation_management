<?php
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Http\Kernel::class);
$response = $kernel->handle(
    $request = Illuminate\Http\Request::create(
        '/api/post-harvest/harvest/8',
        'GET'
    )
);
$request->setUserResolver(function () { return App\Models\User::find(1); });

try {
    $controller = $app->make('App\Http\Controllers\Farm\PostHarvestController');
    $harvest = App\Models\Harvest::find(8);
    if (!$harvest) { echo "Harvest not found\n"; exit; }
    $res = $controller->index($request, $harvest);
    echo $res->getContent();
} catch (\Throwable $e) {
    echo $e->getMessage() . "\n" . $e->getTraceAsString();
}
