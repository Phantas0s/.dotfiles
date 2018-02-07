<?php

namespace WyriHaximus\React\Tests\ChildProcess\Pool\Launcher;

use Phake;
use WyriHaximus\React\ChildProcess\Messenger\Messenger;
use WyriHaximus\React\ChildProcess\Pool\Launcher\ClassName;
use WyriHaximus\React\Tests\ChildProcess\Pool\TestCase;

class ClassNameTest extends TestCase
{

    /**
     * @expectedException \Exception
     * @expectedExceptionMessage Given class doesn't implement ChildInterface
     */
    public function testClassName()
    {
        $loop = Phake::mock('React\EventLoop\LoopInterface');
        $process = new ClassName('stdClass');
        $process($loop, []);
    }
}
