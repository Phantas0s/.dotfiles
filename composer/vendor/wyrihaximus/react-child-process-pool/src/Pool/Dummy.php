<?php

namespace WyriHaximus\React\ChildProcess\Pool\Pool;

use Evenement\EventEmitterTrait;
use React\EventLoop\LoopInterface;
use React\Promise\FulfilledPromise;
use React\Promise\PromiseInterface;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Message;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Rpc;
use WyriHaximus\React\ChildProcess\Pool\PoolInterface;
use WyriHaximus\React\ChildProcess\Pool\ProcessCollectionInterface;

class Dummy implements PoolInterface
{
    use EventEmitterTrait;

    /**
     * @param ProcessCollectionInterface $processCollection
     * @param LoopInterface $loop
     * @param array $options
     */
    public function __construct(ProcessCollectionInterface $processCollection, LoopInterface $loop, array $options = [])
    {
    }

    /**
     * @param Rpc $message
     * @return PromiseInterface
     */
    public function rpc(Rpc $message)
    {
        return new FulfilledPromise();
    }

    /**
     * @param Message $message
     */
    public function message(Message $message)
    {
    }

    /**
     * @param Message|null $message
     * @param int $timeout
     * @param null $signal
     */
    public function terminate(Message $message = null, $timeout = 5, $signal = null)
    {
    }

    /**
     * @return array
     */
    public function info()
    {
        return [];
    }
}
