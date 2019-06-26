<?php

use Slim\Http\Request;
use Slim\Http\Response;

chdir(dirname(__DIR__));
require 'vendor/autoload.php';

$app = new Slim\App([
    "settings" => [
        "addContentLengthHeader" => false
    ]
]);

$app->get('/', function (Request $request, Response $response) {
    return $response->withJson([
        "name" => "Manager",
        "param" => $request->getQueryParam("param")
    ]);
});

$app->run();

