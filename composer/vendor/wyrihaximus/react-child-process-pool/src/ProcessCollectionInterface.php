<?php

namespace WyriHaximus\React\ChildProcess\Pool;

interface ProcessCollectionInterface extends \Iterator
{
    /**
     * @return callable
     */
    public function current();

    /**
     * @return mixed
     */
    public function key();

    public function next();

    public function rewind();

    /**
     * @return bool
     */
    public function valid();
}
