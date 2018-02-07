<?php

namespace WyriHaximus\React\ChildProcess\Pool;

use Evenement\EventEmitterInterface;
use React\ChildProcess\Process;
use React\EventLoop\LoopInterface;
use React\Promise\PromiseInterface;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Message;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Rpc;

interface PoolInterface extends PoolInfoInterface, EventEmitterInterface
{
    /**
     * @param ProcessCollectionInterface $processCollection
     * @param LoopInterface $loop
     * @param array $options
     */
    public function __construct(
        ProcessCollectionInterface $processCollection,
        LoopInterface $loop,
        array $options = []
    );

    /**
     * @param Rpc $message
     * @return PromiseInterface
     */
    public function rpc(Rpc $message);

    /**
     * * Messages all processes in the pool
     *
     * @param Message $message
     * @return void
     */
    public function message(Message $message);

    /**
     * @param Message $message
     * @param int $timeout
     * @param null $signal
     * @return mixed
     */
    public function terminate(Message $message, $timeout = 5, $signal = null);
}
