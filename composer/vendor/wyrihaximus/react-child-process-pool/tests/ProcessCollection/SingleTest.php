<?php

namespace WyriHaximus\React\Tests\ChildProcess\Pool\ProcessCollection;

use WyriHaximus\React\ChildProcess\Pool\ProcessCollection\Single;
use WyriHaximus\React\Tests\ChildProcess\Pool\TestCase;

class SingleTest extends TestCase
{
    public function testSingle()
    {
        $calledCallable      = false;
        $calledCallableCount = 0;
        $callable = function () use (&$calledCallable, &$calledCallableCount) {
            $calledCallable = true;
            $calledCallableCount++;
        };
        $single = new Single($callable);

        for ($i = 0; $i < 14; $i++) {
            $c = $single->current();
            $c();
        }

        $this->assertTrue($calledCallable);
        $this->assertSame($i, $calledCallableCount);

        $this->assertFalse($single->next());
        $this->assertTrue($single->valid());
        $this->assertSame(0, $single->key());

        $single->rewind();

        $this->assertFalse($single->next());
        $this->assertTrue($single->valid());
        $this->assertSame(0, $single->key());
    }
}
