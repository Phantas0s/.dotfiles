<?php

use React\EventLoop\Factory;
use React\ChildProcess\Process;

require __DIR__ . '/../vendor/autoload.php';

$loop = Factory::create();

$process = new Process('echo hallo;sleep 1;echo welt >&2;sleep 1;echo error;sleep 1;nope');
$process->start($loop);

$process->stdout->on('data', function ($chunk) {
    echo '(' . $chunk . ')';
});

$process->stderr->on('data', function ($chunk) {
    echo '[' . $chunk . ']';
});

$process->on('exit', function ($code) {
    echo 'EXIT with code ' . $code . PHP_EOL;
});

$loop->run();
