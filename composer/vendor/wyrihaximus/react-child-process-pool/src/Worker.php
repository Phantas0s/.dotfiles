<?php

namespace WyriHaximus\React\ChildProcess\Pool;

use Evenement\EventEmitterTrait;
use React\Promise\PromiseInterface;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Message;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Rpc;
use WyriHaximus\React\ChildProcess\Messenger\Messenger;

class Worker implements WorkerInterface
{
    use EventEmitterTrait;

    /**
     * @var Messenger
     */
    protected $messenger;

    /**
     * @var bool
     */
    protected $busy = false;

    /**
     * @param Messenger $messenger
     */
    public function __construct(Messenger $messenger)
    {
        $this->messenger = $messenger;
    }

    /**
     * @param Rpc $rpc
     * @return PromiseInterface
     */
    public function rpc(Rpc $rpc)
    {
        $this->busy = true;
        return $this->messenger->rpc($rpc)->always(function () {
            $this->busy = false;
            $this->emit('done', [$this]);
        });
    }

    /**
     * @param Message $message
     */
    public function message(Message $message)
    {
        $this->messenger->message($message);
    }

    /**
     * @return bool
     */
    public function isBusy()
    {
        return $this->busy;
    }

    /*
     * @return PromiseInterface
     */
    public function terminate()
    {
        $this->busy = true;
        $this->emit('terminating', [$this]);
        return $this->messenger->softTerminate();
    }
}
