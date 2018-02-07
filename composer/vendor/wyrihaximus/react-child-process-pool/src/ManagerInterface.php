<?php

namespace WyriHaximus\React\ChildProcess\Pool;

use Evenement\EventEmitterInterface;
use React\EventLoop\LoopInterface;
use React\Promise\PromiseInterface;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Message;

interface ManagerInterface extends EventEmitterInterface
{
    /**
     * @param ProcessCollectionInterface $processCollection
     * @param array $options
     */
    public function __construct(
        ProcessCollectionInterface $processCollection,
        LoopInterface $loop,
        array $options = []
    );

    /**
     * Terminate the manager and all workers managed by it.
     *
     * @return PromiseInterface
     */
    public function terminate();

    /**
     * Ping the manager to broadcast its non busy workers or
     * spawn new ones as needed and allowed by configuration.
     *
     * @return void
     */
    public function ping();

    /**
     * Broadcast a message to all workers
     *
     * @param Message $message
     * @return void
     */
    public function message(Message $message);

    /**
     * Return an array with the following keys:
     * - total: total amount running workers
     * - busy: the amount of workers that is busy
     * - idle: the amount of workers that is waiting for a task
     *
     * @return array
     */
    public function info();
}
