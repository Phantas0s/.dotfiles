<?php

namespace WyriHaximus\React\ChildProcess\Pool;

use React\EventLoop\LoopInterface;
use Prophecy\Promise\PromiseInterface;

interface LauncherInterface
{
    /**
     * @param LoopInterface $loop
     * @param array $options
     * @return PromiseInterface
     */
    public function __invoke(LoopInterface $loop, array $options);
}
