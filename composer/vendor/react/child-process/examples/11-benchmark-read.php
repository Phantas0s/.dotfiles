<?php

// $ php examples/11-benchmark.php
// $ php examples/11-benchmark.php echo test
// $ php examples/11-benchmark.php dd if=/dev/zero bs=1M count=1000

use React\EventLoop\Factory;
use React\ChildProcess\Process;

require __DIR__ . '/../vendor/autoload.php';

$cmd = isset($argv[1]) ? implode(' ', array_slice($argv, 1)) : 'dd if=/dev/zero bs=1M count=1000';

$loop = Factory::create();

$info = new React\Stream\Stream(STDERR, $loop);
$info->pause();
$info->write('Counts number of chunks/bytes received from process STDOUT' . PHP_EOL);
$info->write('Command: ' . $cmd . PHP_EOL);
if (extension_loaded('xdebug')) {
    $info->write('NOTICE: The "xdebug" extension is loaded, this has a major impact on performance.' . PHP_EOL);
}

$process = new Process($cmd);
$process->start($loop);
$start = microtime(true);

$chunks = 0;
$bytes = 0;
$process->stdout->on('data', function ($chunk) use (&$chunks, &$bytes) {
    ++$chunks;
    $bytes += strlen($chunk);
});

// print stream position once stream closes
$process->on('exit', function () use (&$chunks, &$bytes, $start, $info) {
    $t = microtime(true) - $start;

    $info->write('read ' . $chunks . ' chunks with ' . $bytes . ' byte(s) in ' . round($t, 3) . ' second(s) => ' . round($bytes / 1024 / 1024 / $t, 1) . ' MiB/s' . PHP_EOL);
    $info->write('peak memory usage of ' . round(memory_get_peak_usage(true) / 1024 / 1024, 1) . ' MiB' . PHP_EOL);
});

// report any other output/errors
$process->stdout->on('error', array($info, 'write'));
$process->stderr->on('data', 'printf');
$process->stdout->on('error', 'printf');

$loop->run();
