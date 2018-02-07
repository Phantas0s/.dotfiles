<?php

namespace WyriHaximus\React;

use React\ChildProcess\Process;
use React\EventLoop\LoopInterface;
use React\Promise\Deferred;

/**
 * Promise that resolves once child process exits
 *
 * @param LoopInterface $loop    ReactPHP event loop.
 * @param Process       $process Child Process to run.
 *
 * @return \React\Promise\PromiseInterface
 */
function childProcessPromise(LoopInterface $loop, Process $process)
{
    $deferred = new Deferred();
    $buffers = [
        'stderr' => '',
        'stdout' => '',
    ];

    $process->on('exit', function ($exitCode) use ($deferred, &$buffers) {
        $deferred->resolve(new ProcessOutcome($exitCode, $buffers['stderr'], $buffers['stdout']));
    });

    \WyriHaximus\React\futurePromise($loop, $process)->then(function (Process $process) use ($loop, &$buffers) {
        $process->start($loop);
        $process->stderr->on('data', function ($output) use (&$buffers) {
            $buffers['stderr'] .= $output;
        });
        $process->stdout->on('data', function ($output) use (&$buffers) {
            $buffers['stdout'] .= $output;
        });
    });

    return $deferred->promise();
}
