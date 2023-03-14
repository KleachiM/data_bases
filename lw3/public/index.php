<?php
declare(strict_types=1);

use App\TestApiController;
use Slim\Factory\AppFactory;

require __DIR__ . '/../vendor/autoload.php';

$isProduction = getenv('APP_ENV') === 'prod';

$app = AppFactory::create();

// Регистрация middlewares фреймворка Slim.
$app->addRoutingMiddleware();
$errorMiddleware = $app->addErrorMiddleware(!$isProduction, true, true);

$app->get('/hello', App\TestApiController::class . ':getHelloWorld');
$app->post('course', )

$app->run();