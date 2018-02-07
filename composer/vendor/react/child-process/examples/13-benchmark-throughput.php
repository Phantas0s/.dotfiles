<?php

use React\EventLoop\Factory;
use React\ChildProcess\Process;
use React\Stream\Stream;

require __DIR__ . '/../vendor/autoload.php';

$loop = Factory::create();

$info = new React\Stream\Stream(STDERR, $loop);
$info->pause();
$info->write('Pipes data through process STDIN and reads STDOUT again' . PHP_EOL);
if (extension_loaded('xdebug')) {
    $info->write('NOTICE: The "xdebug" extension is loaded, this has a major impact on performance.' . PHP_EOL);
}

$process = new Process('cat');
$process->start($loop);
$start = microtime(true);

$chunks = 0;
$bytes = 0;
$process->stdout->on('data', function ($chunk) use (&$chunks, &$bytes) {
    ++$chunks;
    $bytes += strlen($chunk);
});

// 10000 * 100 KB => 1 GB
$i = 10000;
$chunk = str_repeat("\0", 100 * 1000);
$write = function () use ($chunk, $process, &$i, &$write) {
    do {
        --$i;
        $continue = $process->stdin->write($chunk);
    } while ($i && $continue);

    if ($i > 0) {
        // buffer full => wait for drain to continue
        $process->stdin->once('drain', $write);
    } else {
        $process->stdin->end();
    }
};
$write();

// print stream position once process exits
$process->on('exit', function () use (&$chunks, &$bytes, $start, $info) {
    $t = microtime(true) - $start;

    $info->write('read ' . $chunks . ' chunks with ' . $bytes . ' byte(s) in ' . round($t, 3) . ' second(s) => ' . round($bytes / 1024 / 1024 / $t, 1) . ' MiB/s' . PHP_EOL);
    $info->write('peak memory usage of ' . round(memory_get_peak_usage(true) / 1024 / 1024, 1) . ' MiB' . PHP_EOL);
});

// report any other output/errors
$process->stdout->on('error', 'printf');
$process->stderr->on('data', 'printf');
$process->stdout->on('error', 'printf');

$loop->run();
