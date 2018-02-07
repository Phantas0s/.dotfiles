<?php

namespace WyriHaximus\React\ChildProcess\Pool\ProcessCollection;

use WyriHaximus\React\ChildProcess\Pool\ProcessCollectionInterface;

class Single implements ProcessCollectionInterface
{
    protected $callable;

    public function __construct(callable $callable)
    {
        $this->callable = $callable;
    }

    public function current()
    {
        return $this->callable;
    }

    public function key()
    {
        return 0;
    }

    public function next()
    {
        return false;
    }

    public function rewind()
    {
        // Do nothing
    }

    public function valid()
    {
        return true;
    }
}
