<?php

namespace WyriHaximus\React\Tests\ChildProcess\Pool\Manager;

use Phake;
use React\EventLoop\LoopInterface;
use React\Promise\Deferred;
use React\Promise\FulfilledPromise;
use React\Promise\RejectedPromise;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Factory;
use WyriHaximus\React\ChildProcess\Pool\Info;
use WyriHaximus\React\ChildProcess\Pool\Manager\Fixed;
use WyriHaximus\React\ChildProcess\Pool\Options;
use WyriHaximus\React\ChildProcess\Pool\ProcessCollectionInterface;
use WyriHaximus\React\ChildProcess\Pool\WorkerInterface;
use WyriHaximus\React\Tests\ChildProcess\Pool\TestCase;

class FixedTest extends TestCase
{
    /**
     * @var ProcessCollectionInterface
     */
    protected $processCollection;

    /**
     * @var LoopInterface
     */
    protected $loop;

    /**
     * @var Fixed
     */
    protected $manager;

    public function setUp()
    {
        parent::setUp();

        $this->processCollection = Phake::mock('WyriHaximus\React\ChildProcess\Pool\ProcessCollectionInterface');
        $this->loop = Phake::mock('React\EventLoop\LoopInterface');
    }

    protected function noWorkers()
    {
        Phake::when($this->processCollection)->current()->thenReturnCallback(function () {
            return function () {
                return new RejectedPromise();
            };
        });
    }

    protected function createManager()
    {
        $this->manager = new Fixed($this->processCollection, $this->loop, [
            Options::SIZE => 1,
        ]);
    }

    public function tearDown()
    {
        $this->manager           = null;
        $this->loop              = null;
        $this->processCollection = null;

        parent::tearDown();
    }

    public function testInfoAtStart()
    {
        $this->noWorkers();
        $this->createManager();

        $this->assertSame([
            Info::TOTAL => 0,
            Info::BUSY => 0,
            Info::IDLE => 0,
        ], $this->manager->info());
    }

    public function testPingEmit()
    {
        Phake::when($this->processCollection)->current()->thenReturnCallback(function () {
            return function () {
                return new FulfilledPromise(Phake::mock('WyriHaximus\React\ChildProcess\Messenger\Messenger'));
            };
        });

        $this->createManager();

        $called = false;
        $this->manager->once('ready', function (WorkerInterface $worker) use (&$called) {
            $this->assertInstanceOf('WyriHaximus\React\ChildProcess\Pool\WorkerInterface', $worker);
            $called = true;
        });
        $this->manager->ping();

        $this->assertTrue($called);
    }

    public function testRpc()
    {
        $rpc = Factory::rpc('foo', ['bar']);
        $workerDeferred = new Deferred();
        $rpcDeferred = new Deferred();
        $worker = null;
        $messenger = Phake::mock('WyriHaximus\React\ChildProcess\Messenger\Messenger');
        Phake::when($messenger)->rpc($rpc)->thenReturn($rpcDeferred->promise());

        Phake::when($this->processCollection)->current()->thenReturnCallback(function () use ($workerDeferred) {
            return function () use ($workerDeferred) {
                return $workerDeferred->promise();
            };
        });

        $this->createManager();

        $this->manager->once('ready', function (WorkerInterface $workerInstance) use (&$worker) {
            $worker = $workerInstance;
        });

        $workerDeferred->resolve($messenger);

        $this->assertSame([
            Info::TOTAL => 1,
            Info::BUSY => 0,
            Info::IDLE => 1,
        ], $this->manager->info());

        $worker->rpc($rpc);

        $this->assertSame([
            Info::TOTAL => 1,
            Info::BUSY => 1,
            Info::IDLE => 0,
        ], $this->manager->info());

        $rpcDeferred->resolve();

        $this->assertSame([
            Info::TOTAL => 1,
            Info::BUSY => 0,
            Info::IDLE => 1,
        ], $this->manager->info());
    }

    public function testTerminate()
    {
        $workerDeferred = new Deferred();
        $worker = null;
        $messenger = Phake::mock('WyriHaximus\React\ChildProcess\Messenger\Messenger');

        Phake::when($this->processCollection)->current()->thenReturnCallback(function () use ($workerDeferred) {
            return function () use ($workerDeferred) {
                return $workerDeferred->promise();
            };
        });

        $this->createManager();

        $this->manager->once('ready', function (WorkerInterface $workerInstance) use (&$worker) {
            $worker = $workerInstance;
        });

        $workerDeferred->resolve($messenger);

        $this->assertSame([
            Info::TOTAL => 1,
            Info::BUSY => 0,
            Info::IDLE => 1,
        ], $this->manager->info());

        $emittedTerminate = false;
        $worker->on('terminating', function ($worker) use (&$emittedTerminate) {
            $this->assertInstanceOf('WyriHaximus\React\ChildProcess\Pool\WorkerInterface', $worker);
            $emittedTerminate = true;
        });

        $this->manager->terminate();

        $this->assertSame([
            Info::TOTAL => 1,
            Info::BUSY => 1,
            Info::IDLE => 0,
        ], $this->manager->info());

        $this->assertTrue($emittedTerminate);
        Phake::verify($messenger)->softTerminate();
    }

    public function testMessage()
    {
        $message = Factory::message(['bar']);
        $workerDeferred = new Deferred();
        $worker = null;
        $messenger = Phake::mock('WyriHaximus\React\ChildProcess\Messenger\Messenger');

        Phake::when($this->processCollection)->current()->thenReturnCallback(function () use ($workerDeferred) {
            return function () use ($workerDeferred) {
                return $workerDeferred->promise();
            };
        });

        $this->createManager();

        $this->manager->once('ready', function (WorkerInterface $workerInstance) use (&$worker) {
            $worker = $workerInstance;
        });

        $workerDeferred->resolve($messenger);
        $this->manager->message($message);

        Phake::verify($messenger)->message($message);
    }
}
