<?php

namespace WyriHaximus\React\Tests\ChildProcess\Pool\Queue;

use Phake;
use React\Promise\FulfilledPromise;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Factory;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Rpc;
use WyriHaximus\React\ChildProcess\Pool\Queue\Memory;
use WyriHaximus\React\ChildProcess\Pool\Queue\Overflow;
use WyriHaximus\React\Tests\ChildProcess\Pool\TestCase;

class OverflowTest extends TestCase
{
    use QueueTestTrait;

    protected function getQueue()
    {
        return new Overflow(new Memory(), 1);
    }

    public function testOverflow()
    {
        $memory = new Memory();
        $queue = Phake::mock('WyriHaximus\React\ChildProcess\Pool\QueueInterface');
        Phake::when($queue)->count()->thenReturnCallback(function () use ($memory) {
            return $memory->count();
        });
        Phake::when($queue)->dequeue()->thenReturnCallback(function () use ($memory) {
            return new FulfilledPromise($memory->dequeue());
        });
        Phake::when($queue)->enqueue($this->isInstanceOf('WyriHaximus\React\ChildProcess\Messenger\Messages\Rpc'))->thenReturnCallback(function (Rpc $rpc) use ($memory) {
            return new FulfilledPromise($memory->enqueue($rpc));
        });
        $overflow = new Overflow($queue, 1);
        $rpc0 = Factory::rpc('a', ['b']);
        $rpc1 = Factory::rpc('c', ['d']);
        $this->assertSame(0, $memory->count());
        $this->assertSame(0, $overflow->count());
        $overflow->enqueue($rpc0);
        $this->assertSame(0, $memory->count());
        $this->assertSame(1, $overflow->count());
        $overflow->enqueue($rpc1);
        $this->assertSame(1, $memory->count());
        $this->assertSame(2, $overflow->count());
        $this->assertSame(json_encode($rpc0), json_encode($this->dequeue($overflow->dequeue())));
        $this->assertSame(0, $memory->count());
        $this->assertSame(1, $overflow->count());
        $this->assertSame(json_encode($rpc1), json_encode($this->dequeue($overflow->dequeue())));
        $this->assertSame(0, $memory->count());
        $this->assertSame(0, $overflow->count());
    }
}
