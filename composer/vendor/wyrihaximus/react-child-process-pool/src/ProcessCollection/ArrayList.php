<?php

namespace WyriHaximus\React\ChildProcess\Pool\ProcessCollection;

use ArrayIterator;
use React\ChildProcess\Process;
use WyriHaximus\React\ChildProcess\Pool\ProcessCollectionInterface;

class ArrayList implements ProcessCollectionInterface
{
    /**
     * @var ArrayIterator
     */
    protected $callables;

    public function __construct(array $callables)
    {
        $this->callables = new ArrayIterator($callables);
    }

    public function current()
    {
        return $this->callables->current();
    }

    public function key()
    {
        return $this->callables->key();
    }

    public function next()
    {
        $this->callables->next();
    }

    public function rewind()
    {
        $this->callables->rewind();
    }

    public function valid()
    {
        return $this->callables->valid();
    }
}
