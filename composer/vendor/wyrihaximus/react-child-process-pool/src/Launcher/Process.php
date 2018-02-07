<?php

namespace WyriHaximus\React\ChildProcess\Pool\Launcher;

use Prophecy\Promise\PromiseInterface;
use React\ChildProcess\Process as ChildProcess;
use React\EventLoop\LoopInterface;
use WyriHaximus\React\ChildProcess\Messenger\Factory;
use WyriHaximus\React\ChildProcess\Pool\LauncherInterface;

class Process implements LauncherInterface
{
    /**
     * @var ChildProcess
     */
    protected $process;

    /**
     * @param ChildProcess $process
     */
    public function __construct(ChildProcess $process)
    {
        $this->process = $process;
    }

    /**
     * @param LoopInterface $loop
     * @param array $options
     * @return PromiseInterface
     * @throws \Exception
     */
    public function __invoke(LoopInterface $loop, array $options)
    {
        return Factory::parent(clone $this->process, $loop, $options);
    }
}
