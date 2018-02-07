<?php

namespace WyriHaximus\React\ChildProcess\Pool\Factory;

use React\ChildProcess\Process as ChildProcess;
use React\EventLoop\LoopInterface;
use React\Promise\PromiseInterface;
use WyriHaximus\React\ChildProcess\Pool\Launcher\ClassName;
use WyriHaximus\React\ChildProcess\Pool\Launcher\Process;
use WyriHaximus\React\ChildProcess\Pool\Options;
use WyriHaximus\React\ChildProcess\Pool\PoolFactoryInterface;
use WyriHaximus\React\ChildProcess\Pool\Pool\Flexible as FlexiblePool;
use WyriHaximus\React\ChildProcess\Pool\ProcessCollection\Single;

class Flexible implements PoolFactoryInterface
{
    /**
     * @var array
     */
    protected static $defaultOptions =[
        Options::MIN_SIZE => 0,
        Options::MAX_SIZE => 5,
        Options::TTL      => 0,
    ];

    /**
     * @param ChildProcess $process
     * @param LoopInterface $loop
     * @param array $options
     * @return PromiseInterface
     */
    public static function create(ChildProcess $process, LoopInterface $loop, array $options = [])
    {
        $options = array_merge(self::$defaultOptions, $options);
        return \React\Promise\resolve(new FlexiblePool(new Single(new Process($process)), $loop, $options));
    }

    /**
     * @param string $class
     * @param LoopInterface $loop
     * @param array $options
     * @return PromiseInterface
     */
    public static function createFromClass($class, LoopInterface $loop, array $options = [])
    {
        $options = array_merge(self::$defaultOptions, $options);
        return \React\Promise\resolve(new FlexiblePool(new Single(new ClassName($class)), $loop, $options));
    }
}
