<?php

namespace WyriHaximus\React\Tests\ChildProcess\Pool;

use WyriHaximus\CpuCoreDetector\Resolver;

class TestCase extends \PHPUnit_Framework_TestCase
{
    public function setUp()
    {
        parent::setUp();
        Resolver::reset();
    }

    public function tearDown()
    {
        parent::tearDown();
        Resolver::reset();
    }
}
