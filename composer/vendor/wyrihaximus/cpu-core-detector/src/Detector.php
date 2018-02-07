<?php

namespace WyriHaximus\CpuCoreDetector;

use React\EventLoop\Factory;
use React\EventLoop\LoopInterface;
use WyriHaximus\CpuCoreDetector\Core\AffinityInterface;
use WyriHaximus\CpuCoreDetector\Core\CountInterface;

class Detector
{
    public static function detect(Collections $collections = null)
    {
        $return = null;
        $loop = Factory::create();

        $assign = function ($value) use (&$return) {
            $return = $value;
        };
        static::detectAsync($loop, $collections)->then($assign, $assign);

        $loop->run();

        if ($return instanceof \Exception) {
            throw $return;
        }

        return $return;
    }

    public static function detectAsync(LoopInterface $loop, Collections $collections = null)
    {
        if ($collections === null) {
            $collections = getDefaultCollections($loop);
        }

        return $collections->getDetectors()->execute(
            $collections->getCounters()
        )->then(function (CountInterface $counter) {
            return $counter->execute();
        })->then(function ($count) use ($collections) {
            return $collections->getDetectors()->execute(
                $collections->getAffinities()
            )->then(function (AffinityInterface $affinity) use ($count) {
                Resolver::setAffinity($affinity);
                return \React\Promise\resolve($count);
            });
        });
    }
}
