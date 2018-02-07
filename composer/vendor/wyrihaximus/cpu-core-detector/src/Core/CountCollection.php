<?php

namespace WyriHaximus\CpuCoreDetector\Core;

class CountCollection implements CoreCollectionInterface
{
    /**
     * @var CountInterface[]
     */
    protected $counters;

    /**
     * @var int
     */
    protected $position = 0;

    /**
     * DetectorCollection constructor.
     * @param CountInterface[] $counters
     */
    public function __construct(array $counters)
    {
        $this->counters = $counters;
    }

    public function rewind()
    {
        $this->position = 0;
    }

    public function current()
    {
        return $this->counters[$this->position];
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
        return isset($this->counters[$this->position]);
    }
}
