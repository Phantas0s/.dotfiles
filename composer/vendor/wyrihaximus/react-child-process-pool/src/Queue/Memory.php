<?php

namespace WyriHaximus\React\ChildProcess\Pool\Queue;

use WyriHaximus\React\ChildProcess\Messenger\Messages\Rpc;
use WyriHaximus\React\ChildProcess\Pool\QueueInterface;

class Memory implements QueueInterface
{
    /**
     * @var \SplQueue
     */
    protected $queue;

    public function __construct()
    {
        $this->queue = new \SplQueue();
    }

    /**
     * @param Rpc $rpc
     */
    public function enqueue(Rpc $rpc)
    {
        $this->queue->enqueue($rpc);
    }

    /**
     * @return Rpc
     */
    public function dequeue()
    {
        return $this->queue->dequeue();
    }

    /**
     * @return int
     */
    public function count()
    {
        return $this->queue->count();
    }
}
