<?php

namespace WyriHaximus\React\ChildProcess\Pool\Queue;

use React\Promise\FulfilledPromise;
use React\Promise\PromiseInterface;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Rpc;
use WyriHaximus\React\ChildProcess\Pool\QueueInterface;

class Overflow implements QueueInterface
{
    /**
     * @var Memory
     */
    protected $memory;

    /**
     * @var QueueInterface
     */
    protected $queue;

    /**
     * @var int
     */
    protected $threshold;

    /**
     * Overflow constructor.
     * @param QueueInterface $queue
     * @param int $threshold
     */
    public function __construct(QueueInterface $queue, $threshold = 5)
    {
        $this->memory = new Memory();
        $this->queue = $queue;
        $this->threshold = $threshold;
    }

    public function enqueue(Rpc $rpc)
    {
        if ($this->memory->count() < $this->threshold) {
            return $this->memory->enqueue($rpc);
        }

        return $this->queue->enqueue($rpc);
    }

    /**
     * @return PromiseInterface|Rpc
     */
    public function dequeue()
    {
        $promise = $this->requeue();

        if ($this->memory->count() > 0) {
            return $this->memory->dequeue();
        }

        return $promise->then(function () {
            return \React\Promise\resolve($this->memory->dequeue());
        });
    }

    /**
     * @return PromiseInterface
     */
    protected function requeue()
    {
        if ($this->queue->count() === 0) {
            return new FulfilledPromise();
        }

        return \React\Promise\resolve($this->queue->dequeue())->then(function (Rpc $rpc) {
            return \React\Promise\resolve($this->memory->enqueue($rpc));
        });
    }

    /**
     * @return int
     */
    public function count()
    {
        return $this->memory->count() + $this->queue->count();
    }
}
