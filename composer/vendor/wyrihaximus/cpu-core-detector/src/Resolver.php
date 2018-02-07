<?php

namespace WyriHaximus\CpuCoreDetector;

use React\Promise\PromiseInterface;
use WyriHaximus\CpuCoreDetector\Core\AffinityInterface;

class Resolver
{
    /**
     * @var AffinityInterface
     */
    protected static $affinity;

    /**
     * @param AffinityInterface $affinity
     */
    public static function setAffinity(AffinityInterface $affinity)
    {
        self::$affinity = $affinity;
    }

    /**
     * @return AffinityInterface
     * @throws \Exception
     */
    public static function getAffinity()
    {
        if (!(self::$affinity instanceof AffinityInterface)) {
            throw new \Exception('Affinity not set');
        }

        return self::$affinity;
    }

    /**
     * @param $address
     * @param string $cmd
     * @return PromiseInterface
     * @throws \Exception
     */
    public static function resolve($address, $cmd = '')
    {
        return self::getAffinity()->execute($address, $cmd);
    }

    public static function reset()
    {
        self::$affinity = null;
    }
}
