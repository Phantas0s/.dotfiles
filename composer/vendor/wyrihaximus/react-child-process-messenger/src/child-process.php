<?php

use React\EventLoop\Factory as LoopFactory;
use WyriHaximus\React\ChildProcess\Messenger\ArgvEncoder;
use WyriHaximus\React\ChildProcess\Messenger\Factory as MessengerFactory;
use WyriHaximus\React\ChildProcess\Messenger\Process;

foreach ([
    __DIR__ . '/../vendor/autoload.php',
    __DIR__ . '/../../../autoload.php',
] as $file) {
    if (file_exists($file)) {
        require $file;
        break;
    }
}

$arguments = '';
if (isset($argv[1])) {
    $arguments = $argv[1];
}

$loop = LoopFactory::create();
$messenger = MessengerFactory::child($loop, ArgvEncoder::decode($arguments));

Process::create($loop, $messenger);
$loop->run();
