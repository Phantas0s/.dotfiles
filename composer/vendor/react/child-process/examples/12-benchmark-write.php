<?php

use React\EventLoop\Factory;
use React\ChildProcess\Process;
use React\Stream\Stream;

require __DIR__ . '/../vendor/autoload.php';

$loop = Factory::create();

$info = new React\Stream\Stream(STDERR, $loop);
$info->pause();
$info->write('Pipes data to process STDIN' . PHP_EOL);
if (extension_loaded('xdebug')) {
    $info->write('NOTICE: The "xdebug" extension is loaded, this has a major impact on performance.' . PHP_EOL);
}

$process = new Process('dd of=/dev/zero');
$process->start($loop);

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

// report any other output/errors
$process->stdout->on('data', 'printf');
$process->stdout->on('error', 'printf');
$process->stderr->on('data', 'printf');
$process->stdout->on('error', 'printf');

$loop->run();
