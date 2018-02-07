<?php

namespace WyriHaximus\React\ChildProcess\Pool\Manager;

use Evenement\EventEmitterTrait;
use React\EventLoop\LoopInterface;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Message;
use WyriHaximus\React\ChildProcess\Messenger\Messenger;
use WyriHaximus\React\ChildProcess\Pool\ManagerInterface;
use WyriHaximus\React\ChildProcess\Pool\Options;
use WyriHaximus\React\ChildProcess\Pool\ProcessCollectionInterface;
use WyriHaximus\React\ChildProcess\Pool\Worker;
use WyriHaximus\React\ChildProcess\Pool\WorkerInterface;

class Flexible implements ManagerInterface
{
    use EventEmitterTrait;

    /**
     * @var WorkerInterface[]
     */
    protected $workers = [];

    /**
     * @var ProcessCollectionInterface
     */
    protected $processCollection;

    /**
     * @var LoopInterface
     */
    protected $loop;

    /**
     * @var array
     */
    protected $options;

    /**
     * @var array
     */
    protected $defaultOptions = [
        Options::MIN_SIZE => 0,
        Options::MAX_SIZE => 4,
    ];

    /**
     * @var int
     */
    protected $startingProcesses = 0;

    public function __construct(ProcessCollectionInterface $processCollection, LoopInterface $loop, array $options = [])
    {
        $this->processCollection = $processCollection;
        $this->loop = $loop;
        $this->options = array_merge($this->defaultOptions, $options);

        for ($i = 0; $i < $this->options[Options::MIN_SIZE]; $i++) {
            $this->spawn();
        }
    }

    protected function workerAvailable(WorkerInterface $worker)
    {
        $this->emit('ready', [$worker]);
    }

    protected function spawn()
    {
        $this->startingProcesses++;
        $current = $this->processCollection->current();
        $promise = $current($this->loop, $this->options);
        $promise->then(function (Messenger $messenger) {
            $worker = new Worker($messenger);
            $this->workers[] = $worker;
            $worker->on('done', function (WorkerInterface $worker) {
                $this->workerAvailable($worker);
            });
            $worker->on('terminating', function (WorkerInterface $worker) {
                foreach ($this->workers as $key => $value) {
                    if ($worker === $value) {
                        unset($this->workers[$key]);
                        break;
                    }
                }
            });
            $this->workerAvailable($worker);
            $this->startingProcesses--;
        });

        $this->processCollection->next();
        if (!$this->processCollection->valid()) {
            $this->processCollection->rewind();
        }
    }

    public function ping()
    {
        foreach ($this->workers as $worker) {
            if (!$worker->isBusy()) {
                $this->workerAvailable($worker);
                return;
            }
        }

        if (count($this->workers) + $this->startingProcesses < $this->options[Options::MIN_SIZE]) {
            $this->spawn();
            return;
        }

        if (count($this->workers) + $this->startingProcesses < $this->options[Options::MAX_SIZE]) {
            $this->spawn();
        }
    }

    public function message(Message $message)
    {
        foreach ($this->workers as $worker) {
            $worker->message($message);
        }
    }

    public function terminate()
    {
        $promises = [];

        foreach ($this->workers as $worker) {
            $promises[] = $worker->terminate();
        }

        return \React\Promise\all($promises);
    }

    public function info()
    {
        $count = count($this->workers);
        $busy = 0;
        foreach ($this->workers as $worker) {
            if ($worker->isBusy()) {
                $busy++;
            }
        }
        return [
            'total' => $count,
            'busy' => $busy,
            'idle' => $count - $busy,
        ];
    }
}
