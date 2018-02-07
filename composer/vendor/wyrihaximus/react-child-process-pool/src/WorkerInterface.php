<?php

namespace WyriHaximus\React\ChildProcess\Pool;

use Evenement\EventEmitterInterface;
use React\Promise\PromiseInterface;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Message;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Rpc;
use WyriHaximus\React\ChildProcess\Messenger\Messenger;

interface WorkerInterface extends EventEmitterInterface
{
    /**
     * @param Messenger $messenger
     */
    public function __construct(Messenger $messenger);

    /**
     * @param Rpc $rpc
     * @return PromiseInterface
     */
    public function rpc(Rpc $rpc);

    /**
     * @param Message $message
     */
    public function message(Message $message);

    /**
     * @return bool
     */
    public function isBusy();

    /**
     * @return PromiseInterface
     */
    public function terminate();
}
