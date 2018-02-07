<?php

namespace WyriHaximus\React\Tests\ChildProcess\Pool\ProcessCollection;

use WyriHaximus\React\ChildProcess\Pool\ProcessCollection\ArrayList;
use WyriHaximus\React\Tests\ChildProcess\Pool\TestCase;

class ArrayListTest extends TestCase
{
    public function testArrayList()
    {
        $calledCallable      = false;
        $calledCallableCount = 0;
        $callable = function () use (&$calledCallable, &$calledCallableCount) {
            $calledCallable = true;
            $calledCallableCount++;
        };
        $callables = [
            $callable,
            $callable,
            $callable,
            $callable,
            $callable,
        ];
        $arrayList = new ArrayList($callables);

        for ($i = 0; $i < 5; $i++) {
            $this->assertSame($i, $arrayList->key());
            $c = $arrayList->current();
            $c();
            $arrayList->next();
        }

        $this->assertTrue($calledCallable);
        $this->assertSame($i, $calledCallableCount);

        $this->assertFalse($arrayList->valid());
        $this->assertSame(null, $arrayList->key());

        $arrayList->rewind();

        $this->assertTrue($arrayList->valid());
        $this->assertSame(0, $arrayList->key());
    }
}
