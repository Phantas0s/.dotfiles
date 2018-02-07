<?php

namespace WyriHaximus\React\Tests\ChildProcess\Pool\Pool;

use Phake;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Factory;
use WyriHaximus\React\ChildProcess\Pool\Factory\Dummy;
use WyriHaximus\React\Tests\ChildProcess\Pool\TestCase;

class DummyTest extends TestCase
{
    public function testMethods()
    {
        $loop = Phake::mock('React\EventLoop\LoopInterface');
        $poolPromise = Dummy::createFromClass('stdClass', $loop);

        $promiseHasResolved = false;
        $poolPromise->then(function ($pool) use (&$promiseHasResolved) {
            $pool->message(Factory::message([]));
            $pool->terminate(Factory::message([]));

            $this->assertInstanceOf('React\Promise\FulfilledPromise', $pool->rpc(Factory::rpc('abc', ['def'])));
            $this->assertSame([], $pool->info());
            $promiseHasResolved = true;
        });
        $this->assertTrue($promiseHasResolved);
    }
}
