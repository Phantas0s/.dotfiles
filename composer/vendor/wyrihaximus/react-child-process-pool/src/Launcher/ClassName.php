<?php

namespace WyriHaximus\React\ChildProcess\Pool\Launcher;

use Prophecy\Promise\PromiseInterface;
use React\EventLoop\LoopInterface;
use WyriHaximus\React\ChildProcess\Messenger\Factory;
use WyriHaximus\React\ChildProcess\Pool\LauncherInterface;

class ClassName implements LauncherInterface
{
    /**
     * @var string
     */
    protected $className;

    /**
     * @var array
     */
    protected $overrideOptions;

    /**
     * @param string $className
     */
    public function __construct($className, array $overrideOptions = [])
    {
        $this->className       = $className;
        $this->overrideOptions = $overrideOptions;
    }

    /**
     * @param LoopInterface $loop
     * @param array $options
     * @return PromiseInterface
     * @throws \Exception
     */
    public function __invoke(LoopInterface $loop, array $options)
    {
        $options = array_merge($options, $this->overrideOptions);
        return Factory::parentFromClass($this->className, $loop, $options);
    }
}
