<?php

namespace WyriHaximus\CpuCoreDetector\Core;

use React\EventLoop\LoopInterface;
use WyriHaximus\CpuCoreDetector\CoreInterface;

interface CountInterface extends CoreInterface
{
    public function __construct(LoopInterface $loop);
}
