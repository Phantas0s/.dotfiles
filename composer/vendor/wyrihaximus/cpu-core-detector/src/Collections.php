<?php

namespace WyriHaximus\CpuCoreDetector;

use WyriHaximus\CpuCoreDetector\Core\AffinityCollection;
use WyriHaximus\CpuCoreDetector\Core\CountCollection;

class Collections
{
    /**
     * @var DetectorCollection
     */
    protected $detectors;

    /**
     * @var CountCollection
     */
    protected $counters;

    /**
     * @var AffinityCollection
     */
    protected $affinities;

    public function __construct(
        DetectorCollection $detectors,
        CountCollection $counters,
        AffinityCollection $affinities
    ) {
        $this->detectors = $detectors;
        $this->counters = $counters;
        $this->affinities = $affinities;
    }

    /**
     * @return DetectorCollection
     */
    public function getDetectors()
    {
        return $this->detectors;
    }

    /**
     * @return CountCollection
     */
    public function getCounters()
    {
        return $this->counters;
    }

    /**
     * @return AffinityCollection
     */
    public function getAffinities()
    {
        return $this->affinities;
    }
}
