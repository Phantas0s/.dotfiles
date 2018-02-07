<?php

namespace WyriHaximus\React\ChildProcess\Pool;

use React\Promise\PromiseInterface;

interface StrategyInterface
{
    /**
     * @return array
     */
    public static function getSupportedOSs();

    /**
     * @return PromiseInterface
     */
    public function execute();
}
