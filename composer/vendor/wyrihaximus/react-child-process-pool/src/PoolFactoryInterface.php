<?php

namespace WyriHaximus\React\ChildProcess\Pool;

use React\ChildProcess\Process;
use React\EventLoop\LoopInterface;
use React\Promise\PromiseInterface;

interface PoolFactoryInterface
{
    /**
     * @param Process $childProcess
     * @param LoopInterface $loop
     * @param array $options
     * @return PromiseInterface
     */
    public static function create(Process $childProcess, LoopInterface $loop, array $options = []);

    /**
     * @param string $class
     * @param LoopInterface $loop
     * @param array $options
     * @return PromiseInterface
     */
    public static function createFromClass($class, LoopInterface $loop, array $options = []);
}
