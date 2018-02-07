<?php

namespace WyriHaximus\React\Tests\ChildProcess\Pool\Queue;

use Clue\React\Block;
use React\EventLoop\Factory as LoopFactory;
use React\Promise;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Factory;
use WyriHaximus\React\ChildProcess\Pool\QueueInterface;

trait QueueTestTrait
{
    /**
     * @return QueueInterface
     */
    abstract protected function getQueue();

    public function testInterface()
    {
        $this->assertInstanceOf('WyriHaximus\React\ChildProcess\Pool\QueueInterface', $this->getQueue());
    }

    public function queueProvider()
    {
        $queue = $this->getQueue();
        return array_pad([], 25, [
            $queue,
        ]);
    }

    /**
     * @dataProvider queueProvider
     */
    public function testOperations(QueueInterface $queue)
    {
        $rpc0 = Factory::rpc('a', ['b']);
        $rpc1 = Factory::rpc('c', ['d']);
        $rpc2 = Factory::rpc('e', ['f']);
        $this->assertSame(0, $queue->count());
        $queue->enqueue($rpc0);
        $this->assertSame(1, $queue->count());
        $queue->enqueue($rpc1);
        $this->assertSame(2, $queue->count());
        $queue->enqueue($rpc2);
        $this->assertSame(3, $queue->count());
        $this->assertSame(json_encode($rpc0), json_encode($this->dequeue($queue->dequeue())));
        $this->assertSame(2, $queue->count());
        $this->assertSame(json_encode($rpc1), json_encode($this->dequeue($queue->dequeue())));
        $this->assertSame(1, $queue->count());
        $this->assertSame(json_encode($rpc2), json_encode($this->dequeue($queue->dequeue())));
        $this->assertSame(0, $queue->count());
    }

    protected function dequeue($item)
    {
        return Block\await(Promise\resolve($item), LoopFactory::create(), 5);
    }
}
