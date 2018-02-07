<?php

namespace WyriHaximus\React\ChildProcess\Pool;

use React\ChildProcess\Process;
use React\EventLoop\LoopInterface;
use React\Promise\PromiseInterface;
use WyriHaximus\CpuCoreDetector\Detector;
use WyriHaximus\CpuCoreDetector\Resolver;

/**
 * @param string $instanceOf
 * @param array $options
 * @param string $key
 * @param string $fallback
 * @return string
 */
function getClassNameFromOptionOrDefault(array $options, $key, $instanceOf, $fallback)
{
    if (isset($options[$key]) && is_a($options[$key], $instanceOf, true)) {
        return $options[$key];
    }

    return $fallback;
}

/**
 * @param array $options
 * @param $processCollection
 * @param string $default
 * @param LoopInterface $loop
 * @return ManagerInterface
 */
function getManager(array $options, $processCollection, $default, LoopInterface $loop)
{
    $manager = getClassNameFromOptionOrDefault(
        $options,
        Options::MANAGER,
        'WyriHaximus\React\ChildProcess\Pool\ManagerInterface',
        $default
    );

    if ($manager instanceof ManagerInterface) {
        return $manager;
    }

    return new $manager($processCollection, $loop, $options);
}

/**
 * @param array $options
 * @param string $default
 * @return QueueInterface
 */
function getQueue(array $options, $default, $loop)
{
    $queue = getClassNameFromOptionOrDefault(
        $options,
        Options::QUEUE,
        'WyriHaximus\React\ChildProcess\Pool\QueueInterface',
        $default
    );

    if ($queue instanceof QueueInterface) {
        return $queue;
    }

    return new $queue($loop);
}

/**
 * @param LoopInterface $loop
 * @param $options
 * @return PromiseInterface
 */
function detectCoreCount(LoopInterface $loop, $options)
{
    if (isset($options[Options::DETECTOR]) && is_callable($options[Options::DETECTOR])) {
        return $options[Options::DETECTOR]($loop);
    }

    return Detector::detectAsync($loop);
}

/**
 * @param $address
 * @param Process $childProcess
 * @return Process
 */
function rebuildProcess($address, Process $childProcess)
{
    return Resolver::resolve(
        $address,
        getProcessPropertyValue('cmd', $childProcess)
    )->then(function ($cmd) use ($childProcess) {
        return \React\Promise\resolve(new Process(
            $cmd,
            getProcessPropertyValue('cwd', $childProcess),
            getProcessPropertyValue('env', $childProcess),
            getProcessPropertyValue('options', $childProcess)
        ));
    });
}

/**
 * @param string $property
 * @param object $childProcess
 * @return mixed
 */
function getProcessPropertyValue($property, $childProcess)
{
    $reflectionProperty = (new \ReflectionClass($childProcess))->getProperty($property);
    $reflectionProperty->setAccessible(true);
    return $reflectionProperty->getValue($childProcess);
}
