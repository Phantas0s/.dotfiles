<?php

namespace WyriHaximus\React\Tests\ChildProcess\Pool\Queue;

use WyriHaximus\React\ChildProcess\Pool\Queue\Memory;
use WyriHaximus\React\Tests\ChildProcess\Pool\TestCase;

class MemoryTest extends TestCase
{
    use QueueTestTrait;

    protected function getQueue()
    {
        return new Memory();
    }
}
