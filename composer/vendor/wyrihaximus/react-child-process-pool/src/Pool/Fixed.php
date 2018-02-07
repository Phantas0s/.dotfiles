<?php

namespace WyriHaximus\React\ChildProcess\Pool\Pool;

use Evenement\EventEmitterTrait;
use React\EventLoop\LoopInterface;
use React\Promise\Deferred;
use React\Promise\PromiseInterface;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Message;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Rpc;
use WyriHaximus\React\ChildProcess\Pool\Info;
use WyriHaximus\React\ChildProcess\Pool\ManagerInterface;
use WyriHaximus\React\ChildProcess\Pool\PoolInterface;
use WyriHaximus\React\ChildProcess\Pool\ProcessCollectionInterface;
use WyriHaximus\React\ChildProcess\Pool\QueueInterface;
use WyriHaximus\React\ChildProcess\Pool\WorkerInterface;

class Fixed implements PoolInterface
{
    use EventEmitterTrait;

    /**
     * @var ManagerInterface
     */
    protected $manager;

    /**
     * @var QueueInterface
     */
    protected $queue;

    /**
     * @var LoopInterface
     */
    protected $loop;

    /**
     * @var Deferred[]
     */
    protected $deferreds = [];

    /**
     * @var array
     */
    protected $options = [];

    /**
     * @param ProcessCollectionInterface $processCollection
     * @param LoopInterface $loop
     * @param array $options
     */
    public function __construct(ProcessCollectionInterface $processCollection, LoopInterface $loop, array $options = [])
    {
        $this->loop    = $loop;
        $this->options = $options;
        $this->queue   = \WyriHaximus\React\ChildProcess\Pool\getQueue(
            $this->options,
            'WyriHaximus\React\ChildProcess\Pool\Queue\Memory',
            $loop
        );
        $this->manager = \WyriHaximus\React\ChildProcess\Pool\getManager(
            $this->options,
            $processCollection,
            'WyriHaximus\React\ChildProcess\Pool\Manager\Fixed',
            $loop
        );
        $this->manager->on('ready', function (WorkerInterface $worker) {
            $this->emit('worker', [$worker]);
            if ($this->queue->count() === 0) {
                return;
            }

            \React\Promise\resolve($this->queue->dequeue())->then(function (Rpc $message) use ($worker) {
                $hash = spl_object_hash($message);
                $this->deferreds[$hash]->resolve($worker->rpc($message));
                unset($this->deferreds[$hash]);
            });
        });
    }

    /**
     * @param Rpc $message
     * @return PromiseInterface
     */
    public function rpc(Rpc $message)
    {
        $hash = spl_object_hash($message);
        $deferred = new Deferred();
        $this->deferreds[$hash] = $deferred;
        $this->queue->enqueue($message);
        $this->manager->ping();
        return $deferred->promise();
    }

    /**
     * @param Message $message
     */
    public function message(Message $message)
    {
        $this->manager->message($message);
    }

    /**
     * @param Message|null $message
     * @param int $timeout
     * @param null $signal
     * @return PromiseInterface
     */
    public function terminate(Message $message = null, $timeout = 5, $signal = null)
    {
        if ($message !== null) {
            $this->message($message);
        }

        return \WyriHaximus\React\timedPromise($this->loop, $timeout)->then(function () {
            return $this->manager->terminate();
        });
    }

    /**
     * @return array
     */
    public function info()
    {
        $workers = $this->manager->info();
        return [
            Info::BUSY  => $workers[Info::BUSY],
            Info::CALLS => $this->queue->count(),
            Info::IDLE  => $workers[Info::IDLE],
            Info::SIZE  => $workers[Info::TOTAL],
        ];
    }
}
