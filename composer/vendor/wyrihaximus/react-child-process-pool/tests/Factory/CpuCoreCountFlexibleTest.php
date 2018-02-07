<?php

namespace WyriHaximus\React\Tests\ChildProcess\Pool\Factory;

use Phake;
use React\ChildProcess\Process;
use React\Promise\FulfilledPromise;
use WyriHaximus\CpuCoreDetector\Resolver;
use WyriHaximus\React\ChildProcess\Pool\Options;
use WyriHaximus\React\ChildProcess\Pool\Factory\CpuCoreCountFlexible;
use WyriHaximus\React\Tests\ChildProcess\Pool\TestCase;

class CpuCoreCountFlexibleTest extends TestCase
{
    protected function createProcess()
    {
        return new Process(
            'a',
            'b',
            [
                'c'
            ],
            [
                'd'
            ]
        );
    }

    public function testCreate()
    {
        $process = $this->createProcess();
        $loop = Phake::mock('React\EventLoop\LoopInterface');
        $poolPromise = CpuCoreCountFlexible::create($process, $loop, [
            Options::DETECTOR => function ($loop) {
                $promise = new FulfilledPromise();
                $affinity = Phake::mock('WyriHaximus\CpuCoreDetector\Core\AffinityInterface');
                Phake::when($affinity)->execute($this->isType('integer'), $this->isType('string'))->thenReturn($promise);
                Resolver::setAffinity($affinity);
                return new FulfilledPromise(4);
            },
        ]);

        $this->assertInstanceOf('React\Promise\PromiseInterface', $poolPromise);
        $promiseHasResolved = false;
        $poolPromise->then(function ($pool) use (&$promiseHasResolved) {
            $this->assertInstanceOf('WyriHaximus\React\ChildProcess\Pool\Pool\Flexible', $pool);
            $this->assertInstanceOf('WyriHaximus\React\ChildProcess\Pool\PoolInterface', $pool);
            $promiseHasResolved = true;
        });
        $this->assertTrue($promiseHasResolved);
    }

    public function testCreateFromClass()
    {
        $loop = Phake::mock('React\EventLoop\LoopInterface');
        $poolPromise = CpuCoreCountFlexible::createFromClass('stdClass', $loop, [
            Options::DETECTOR => function ($loop) {
                $promise = new FulfilledPromise();
                $affinity = Phake::mock('WyriHaximus\CpuCoreDetector\Core\AffinityInterface');
                Phake::when($affinity)->execute($this->isType('integer'), $this->isType('string'))->thenReturn($promise);
                Resolver::setAffinity($affinity);
                return new FulfilledPromise(4);
            },
            Options::MIN_SIZE => 1,
            Options::MAX_SIZE => 1,
        ]);

        $this->assertInstanceOf('React\Promise\PromiseInterface', $poolPromise);
        $promiseHasResolved = false;
        $poolPromise->then(null, function ($exception) use (&$promiseHasResolved) {
            $this->assertInstanceOf('Exception', $exception);
            $this->assertSame('Given class doesn\'t implement ChildInterface', $exception->getMessage());
            $promiseHasResolved = true;
        });
        $this->assertTrue($promiseHasResolved);
    }
}
