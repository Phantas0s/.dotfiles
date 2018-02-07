<?php

namespace WyriHaximus\CpuCoreDetector;

use React\EventLoop\LoopInterface;

interface DetectorInterface extends StrategyInterface
{
    /**
     * @param LoopInterface $loop
     */
    public function __construct(LoopInterface $loop);
}
