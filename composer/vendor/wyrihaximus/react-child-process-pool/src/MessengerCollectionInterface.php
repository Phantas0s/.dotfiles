<?php

namespace WyriHaximus\React\ChildProcess\Pool;

use WyriHaximus\React\ChildProcess\Messenger\Messenger;

interface MessengerCollectionInterface extends \Iterator
{
    /**
     * @return Messenger
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
