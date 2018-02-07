<?php

namespace WyriHaximus\React\Tests\ChildProcess\Pool;

use Phake;
use React\Promise\Deferred;
use React\Promise\FulfilledPromise;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Factory;
use WyriHaximus\React\ChildProcess\Pool\Worker;

class WorkerTest extends TestCase
{
    public function testWorker()
    {
        $messenger = Phake::mock('WyriHaximus\React\ChildProcess\Messenger\Messenger');
        $worker = new Worker($messenger);

        $this->assertFalse($worker->isBusy());

        $calledCallback = false;
        $worker->on('terminating', function (Worker $passedWorker) use (&$calledCallback, $worker) {
            $this->assertSame($worker, $passedWorker);
            $calledCallback = true;
        });
        $worker->terminate();
        $this->assertTrue($worker->isBusy());
        $this->assertTrue($calledCallback);
        Phake::verify($messenger)->softTerminate();
    }

    public function testRpc()
    {
        $deferred = new Deferred();
        $rpc = Factory::rpc('t', []);
        $messenger = Phake::mock('WyriHaximus\React\ChildProcess\Messenger\Messenger');
        Phake::when($messenger)->rpc($rpc)->thenReturn($deferred->promise());
        $worker = new Worker($messenger);

        $this->assertFalse($worker->isBusy());
        $worker->rpc($rpc);
        $this->assertTrue($worker->isBusy());
        $deferred->resolve();
        $this->assertFalse($worker->isBusy());
        Phake::verify($messenger)->rpc($rpc);
    }

    public function testMessage()
    {
        $message = Factory::message(['t']);
        $messenger = Phake::mock('WyriHaximus\React\ChildProcess\Messenger\Messenger');
        $worker = new Worker($messenger);

        $worker->message($message);
        Phake::verify($messenger)->message($message);
    }
}
