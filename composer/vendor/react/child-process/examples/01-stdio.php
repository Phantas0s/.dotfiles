<?php

use React\EventLoop\Factory;
use React\ChildProcess\Process;

require __DIR__ . '/../vendor/autoload.php';

$loop = Factory::create();

$process = new Process('cat');
$process->start($loop);

$process->stdout->on('data', function ($chunk) {
    echo $chunk;
});

$process->on('exit', function ($code) {
    echo 'EXIT with code ' . $code . PHP_EOL;
});

// periodically send something to stream
$periodic = $loop->addPeriodicTimer(0.2, function () use ($process) {
    $process->stdin->write('hello');
});

// stop sending after a few seconds
$loop->addTimer(2.0, function () use ($periodic, $loop, $process) {
    $loop->cancelTimer($periodic);
    $process->stdin->end();
});

$loop->run();
