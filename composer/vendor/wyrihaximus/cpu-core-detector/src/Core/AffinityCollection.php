<?php

namespace WyriHaximus\CpuCoreDetector\Core;

class AffinityCollection implements CoreCollectionInterface
{
    /**
     * @var AffinityInterface[]
     */
    protected $affinities;

    /**
     * @var int
     */
    protected $position = 0;

    /**
     * DetectorCollection constructor.
     * @param AffinityInterface[] $affinities
     */
    public function __construct(array $affinities)
    {
        $this->affinities = $affinities;
    }

    public function rewind()
    {
        $this->position = 0;
    }

    public function current()
    {
        return $this->affinities[$this->position];
    }

    public function key()
    {
        return $this->position;
    }

    public function next()
    {
        ++$this->position;
    }

    public function valid()
    {
        return isset($this->affinities[$this->position]);
    }
}
