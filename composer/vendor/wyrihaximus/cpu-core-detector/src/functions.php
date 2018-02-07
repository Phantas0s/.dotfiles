<?php

namespace WyriHaximus\CpuCoreDetector;

use React\EventLoop\LoopInterface;
use WyriHaximus\CpuCoreDetector\Core\Affinity\Taskset;
use WyriHaximus\CpuCoreDetector\Core\AffinityCollection;
use WyriHaximus\CpuCoreDetector\Core\Count\Nproc;
use WyriHaximus\CpuCoreDetector\Core\CountCollection;
use WyriHaximus\CpuCoreDetector\Detector\Hash;

/**
 * @return Collections
 */
function getDefaultCollections(LoopInterface $loop)
{
    return new Collections(
        getDefaultDetectors($loop),
        getDefaultCounters($loop),
        getDefaultAffinities($loop)
    );
}

/**
 * @return DetectorCollection
 */
function getDefaultDetectors(LoopInterface $loop)
{
    return new DetectorCollection([
        new Hash($loop),
    ]);
}

/**
 * @return CountCollection
 */
function getDefaultCounters(LoopInterface $loop)
{
    return new CountCollection([
        new Nproc($loop),
    ]);
}

/**
 * @return AffinityCollection
 */
function getDefaultAffinities(LoopInterface $loop)
{
    return new AffinityCollection([
        new Taskset(),
    ]);
}
