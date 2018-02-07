<?php

const MB = 1048576;
const I = 100000;

function show_memory($message = '')
{
    echo '------------------------------------------', PHP_EOL;
    echo $message, PHP_EOL;
    echo '------------------------------------------', PHP_EOL;
    echo 'Current memory usage: ',      memory_get_usage()          / MB, 'MB', PHP_EOL;
    echo 'Peak memory usage: ',         memory_get_peak_usage()     / MB, 'MB', PHP_EOL;
    echo 'Current real memory usage: ', memory_get_usage(true)      / MB, 'MB', PHP_EOL;
    echo 'Peak real memory usage: ',    memory_get_peak_usage(true) / MB, 'MB', PHP_EOL;
}

show_memory('Bare init');

require dirname(__DIR__) . '/vendor/autoload.php';

use React\EventLoop\Factory as EventLoopFactory;
use React\EventLoop\Timer\Timer;
use WyriHaximus\React\ChildProcess\Messenger\Factory as MessengerFactory;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Factory as MessagesFactory;
use WyriHaximus\React\ChildProcess\Messenger\Messenger;
use WyriHaximus\React\ChildProcess\Pool\Factory\Flexible;
use WyriHaximus\React\ChildProcess\Pool\PoolInfoInterface;
use WyriHaximus\React\ChildProcess\Pool\PoolInterface;

show_memory('Begin');

$loop = EventLoopFactory::create();

Flexible::createFromClass('WyriHaximus\React\ChildProcess\Messenger\ReturnChild', $loop)->then(function (PoolInterface $messenger) use ($loop) {
    $messenger->on('error', function ($e) {
        echo 'Error: ', var_export($e, true), PHP_EOL;
    });

    for ($i = 0; $i <= I; $i++) {
        $messenger->rpc(MessagesFactory::rpc('return', [
            'i' => $i,
            'time' => time(),
        ]));
    }
});

$loop->run();

show_memory('Done');

unset($loop);
$loop = null;

show_memory('Removed loop');

gc_collect_cycles();

show_memory('gc_collect_cycles');
