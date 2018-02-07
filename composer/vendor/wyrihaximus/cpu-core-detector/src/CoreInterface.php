<?php

namespace WyriHaximus\CpuCoreDetector;

interface CoreInterface extends StrategyInterface
{
    /**
     * @return string
     */
    public function getCommandName();
}
