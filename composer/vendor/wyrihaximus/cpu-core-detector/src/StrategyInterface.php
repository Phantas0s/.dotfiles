<?php

namespace WyriHaximus\CpuCoreDetector;

use React\Promise\PromiseInterface;
use Tivie\OS\Detector as OSDetector;

interface StrategyInterface
{
    /**
     * @param OSDetector|null $detector
     * @return bool
     */
    public function supportsCurrentOS(OSDetector $detector = null);

    /**
     * @return PromiseInterface
     */
    public function execute();
}
