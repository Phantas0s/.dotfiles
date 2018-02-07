<?php

namespace WyriHaximus\React\Tests\ChildProcess\Pool;

use ReflectionClass;

class InfoTest extends TestCase
{
    public function testNoMethods()
    {
        $this->assertSame(0, count(get_class_methods('WyriHaximus\React\ChildProcess\Pool\Info')));
    }

    public function testNoVars()
    {
        $this->assertSame(0, count(get_class_vars('WyriHaximus\React\ChildProcess\Pool\Info')));
    }

    public function testConstants()
    {
        foreach ((new ReflectionClass('WyriHaximus\React\ChildProcess\Pool\Info'))->getConstants() as $constant) {
            $this->assertInternalType('string', $constant);
        }
    }
}
