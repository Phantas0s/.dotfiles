<?php

namespace React\Tests\Stream;

use React\Stream\Buffer;

class BufferTest extends TestCase
{
    /**
     * @covers React\Stream\Buffer::__construct
     */
    public function testConstructor()
    {
        $stream = fopen('php://temp', 'r+');
        $loop = $this->createLoopMock();

        $buffer = new Buffer($stream, $loop);
        $buffer->on('error', $this->expectCallableNever());
    }

    /**
     * @covers React\Stream\Buffer::__construct
     * @expectedException InvalidArgumentException
     */
    public function testConstructorThrowsIfNotAValidStreamResource()
    {
        $stream = null;
        $loop = $this->createLoopMock();

        new Buffer($stream, $loop);
    }

    /**
     * @covers React\Stream\Buffer::write
     * @covers React\Stream\Buffer::handleWrite
     */
    public function testWrite()
    {
        $stream = fopen('php://temp', 'r+');
        $loop = $this->createWriteableLoopMock();

        $buffer = new Buffer($stream, $loop);
        $buffer->on('error', $this->expectCallableNever());

        $buffer->write("foobar\n");
        rewind($stream);
        $this->assertSame("foobar\n", fread($stream, 1024));
    }

    /**
     * @covers React\Stream\Buffer::write
     */
    public function testWriteWithDataDoesAddResourceToLoop()
    {
        $stream = fopen('php://temp', 'r+');
        $loop = $this->createLoopMock();
        $loop->expects($this->once())->method('addWriteStream')->with($this->equalTo($stream));

        $buffer = new Buffer($stream, $loop);

        $buffer->write("foobar\n");
    }

    /**
     * @covers React\Stream\Buffer::write
     * @covers React\Stream\Buffer::handleWrite
     */
    public function testEmptyWriteDoesNotAddToLoop()
    {
        $stream = fopen('php://temp', 'r+');
        $loop = $this->createLoopMock();
        $loop->expects($this->never())->method('addWriteStream');

        $buffer = new Buffer($stream, $loop);

        $buffer->write("");
        $buffer->write(null);
    }

    /**
     * @covers React\Stream\Buffer::write
     */
    public function testWriteWillAddStreamToLoop()
    {
        $stream = fopen('php://temp', 'r+');
        $loop = $this->createLoopMock();
        $buffer = new Buffer($stream, $loop);

        $loop->expects($this->once())->method('addWriteStream')->with($stream);

        $buffer->write('foo');
    }

    /**
     * @covers React\Stream\Buffer::write
     * @covers React\Stream\Buffer::handleWrite
     */
    public function testWriteReturnsFalseWhenBufferIsFull()
    {
        $stream = fopen('php://temp', 'r+');
        $loop = $this->createWriteableLoopMock();
        $loop->preventWrites = true;

        $buffer = new Buffer($stream, $loop);
        $buffer->softLimit = 4;
        $buffer->on('error', $this->expectCallableNever());

        $this->assertTrue($buffer->write("foo"));
        $loop->preventWrites = false;
        $this->assertFalse($buffer->write("bar\n"));
    }

    /**
     * @covers React\Stream\Buffer::write
     */
    public function testWriteReturnsFalseWhenBufferIsExactlyFull()
    {
        $stream = fopen('php://temp', 'r+');
        $loop = $this->createLoopMock();

        $buffer = new Buffer($stream, $loop);
        $buffer->softLimit = 3;

        $this->assertFalse($buffer->write("foo"));
    }

    /**
     * @covers React\Stream\Buffer::write
     * @covers React\Stream\Buffer::handleWrite
     */
    public function testWriteEmitsErrorWhenResourceIsNotWritable()
    {
        if (defined('HHVM_VERSION')) {
            // via https://github.com/reactphp/stream/pull/52/files#r75493076
            $this->markTestSkipped('HHVM allows writing to read-only memory streams');
        }

        $stream = fopen('php://temp', 'r');
        $loop = $this->createLoopMock();

        $buffer = new Buffer($stream, $loop);
        $buffer->on('error', $this->expectCallableOnce());
        //$buffer->on('close', $this->expectCallableOnce());

        $buffer->write('hello');
        $buffer->handleWrite();
    }

    /**
     * @covers React\Stream\Buffer::write
     * @covers React\Stream\Buffer::handleWrite
     */
    public function testWriteDetectsWhenOtherSideIsClosed()
    {
        list($a, $b) = stream_socket_pair(STREAM_PF_UNIX, STREAM_SOCK_STREAM, STREAM_IPPROTO_IP);

        $loop = $this->createWriteableLoopMock();

        $buffer = new Buffer($a, $loop);
        $buffer->softLimit = 4;
        $buffer->on('error', $this->expectCallableOnce());

        fclose($b);

        $buffer->write("foo");
    }

    /**
     * @covers React\Stream\Buffer::write
     * @covers React\Stream\Buffer::handleWrite
     */
    public function testDrain()
    {
        $stream = fopen('php://temp', 'r+');
        $loop = $this->createWriteableLoopMock();
        $loop->preventWrites = true;

        $buffer = new Buffer($stream, $loop);
        $buffer->softLimit = 4;
        $buffer->on('error', $this->expectCallableNever());
        $buffer->on('drain', $this->expectCallableOnce());

        $buffer->write("foo");
        $loop->preventWrites = false;
        $buffer->listening = false;
        $buffer->write("bar\n");
    }

    /**
     * @covers React\Stream\Buffer::write
     * @covers React\Stream\Buffer::handleWrite
     */
    public function testWriteInDrain()
    {
        $stream = fopen('php://temp', 'r+');
        $loop = $this->createWriteableLoopMock();
        $loop->preventWrites = true;

        $buffer = new Buffer($stream, $loop);
        $buffer->softLimit = 2;
        $buffer->on('error', $this->expectCallableNever());

        $buffer->once('drain', function ($buffer) {
            $buffer->listening = false;
            $buffer->write("bar\n");
        });

        $this->assertFalse($buffer->write("foo"));
        $loop->preventWrites = false;
        $buffer->listening = false;
        $buffer->write("\n");

        fseek($stream, 0);
        $this->assertSame("foo\nbar\n", stream_get_contents($stream));
    }

    /**
     * @covers React\Stream\Buffer::write
     * @covers React\Stream\Buffer::handleWrite
     */
    public function testDrainAndFullDrainAfterWrite()
    {
        $stream = fopen('php://temp', 'r+');
        $loop = $this->createLoopMock();

        $buffer = new Buffer($stream, $loop);
        $buffer->softLimit = 2;

        $buffer->on('drain', $this->expectCallableOnce());
        $buffer->on('full-drain', $this->expectCallableOnce());

        $buffer->write("foo");
        $buffer->handleWrite();
    }

    /**
     * @covers React\Stream\Buffer::write
     * @covers React\Stream\Buffer::handleWrite
     */
    public function testCloseDuringDrainWillNotEmitFullDrain()
    {
        $stream = fopen('php://temp', 'r+');
        $loop = $this->createLoopMock();

        $buffer = new Buffer($stream, $loop);
        $buffer->softLimit = 2;

        // close buffer on drain event => expect close event, but no full-drain after
        $buffer->on('drain', $this->expectCallableOnce());
        $buffer->on('drain', array($buffer, 'close'));
        $buffer->on('close', $this->expectCallableOnce());
        $buffer->on('full-drain', $this->expectCallableNever());

        $buffer->write("foo");
        $buffer->handleWrite();
    }

    /**
     * @covers React\Stream\Buffer::end
     */
    public function testEnd()
    {
        $stream = fopen('php://temp', 'r+');
        $loop = $this->createLoopMock();

        $buffer = new Buffer($stream, $loop);
        $buffer->on('error', $this->expectCallableNever());
        $buffer->on('close', $this->expectCallableOnce());

        $this->assertTrue($buffer->isWritable());
        $buffer->end();
        $this->assertFalse($buffer->isWritable());
    }

    /**
     * @covers React\Stream\Buffer::end
     */
    public function testEndWithData()
    {
        $stream = fopen('php://temp', 'r+');
        $loop = $this->createWriteableLoopMock();

        $buffer = new Buffer($stream, $loop);
        $buffer->on('error', $this->expectCallableNever());
        $buffer->on('close', $this->expectCallableOnce());

        $buffer->end('final words');

        rewind($stream);
        $this->assertSame('final words', stream_get_contents($stream));
    }

    /**
     * @covers React\Stream\Buffer::isWritable
     * @covers React\Stream\Buffer::close
     */
    public function testClose()
    {
        $stream = fopen('php://temp', 'r+');
        $loop = $this->createLoopMock();

        $buffer = new Buffer($stream, $loop);
        $buffer->on('error', $this->expectCallableNever());
        $buffer->on('close', $this->expectCallableOnce());

        $this->assertTrue($buffer->isWritable());
        $buffer->close();
        $this->assertFalse($buffer->isWritable());

        $this->assertEquals(array(), $buffer->listeners('close'));
    }

    /**
     * @covers React\Stream\Buffer::close
     */
    public function testClosingAfterWriteRemovesStreamFromLoop()
    {
        $stream = fopen('php://temp', 'r+');
        $loop = $this->createLoopMock();
        $buffer = new Buffer($stream, $loop);

        $loop->expects($this->once())->method('removeWriteStream')->with($stream);

        $buffer->write('foo');
        $buffer->close();
    }

    /**
     * @covers React\Stream\Buffer::close
     */
    public function testClosingWithoutWritingDoesNotRemoveStreamFromLoop()
    {
        $stream = fopen('php://temp', 'r+');
        $loop = $this->createLoopMock();
        $buffer = new Buffer($stream, $loop);

        $loop->expects($this->never())->method('removeWriteStream');

        $buffer->close();
    }

    /**
     * @covers React\Stream\Buffer::close
     */
    public function testDoubleCloseWillEmitOnlyOnce()
    {
        $stream = fopen('php://temp', 'r+');
        $loop = $this->createLoopMock();

        $buffer = new Buffer($stream, $loop);
        $buffer->on('close', $this->expectCallableOnce());

        $buffer->close();
        $buffer->close();
    }

    /**
     * @covers React\Stream\Buffer::write
     * @covers React\Stream\Buffer::close
     */
    public function testWritingToClosedBufferShouldNotWriteToStream()
    {
        $stream = fopen('php://temp', 'r+');
        $loop = $this->createWriteableLoopMock();

        $buffer = new Buffer($stream, $loop);
        $buffer->close();

        $buffer->write('foo');

        rewind($stream);
        $this->assertSame('', stream_get_contents($stream));
    }

    /**
     * @covers React\Stream\Buffer::handleWrite
     */
    public function testErrorWhenStreamResourceIsInvalid()
    {
        $stream = fopen('php://temp', 'r+');
        $loop = $this->createWriteableLoopMock();

        $error = null;

        $buffer = new Buffer($stream, $loop);
        $buffer->on('error', function ($message) use (&$error) {
            $error = $message;
        });

        // invalidate stream resource
        fclose($stream);

        $buffer->write('Attempting to write to bad stream');

        $this->assertInstanceOf('Exception', $error);

        // the error messages differ between PHP versions, let's just check substrings
        $this->assertContains('Unable to write to stream: ', $error->getMessage());
        $this->assertContains(' not a valid stream resource', $error->getMessage(), '', true);
    }

    public function testWritingToClosedStream()
    {
        if ('Darwin' === PHP_OS) {
            $this->markTestSkipped('OS X issue with shutting down pair for writing');
        }

        list($a, $b) = stream_socket_pair(STREAM_PF_UNIX, STREAM_SOCK_STREAM, STREAM_IPPROTO_IP);
        $loop = $this->createWriteableLoopMock();

        $error = null;

        $buffer = new Buffer($a, $loop);
        $buffer->on('error', function($message) use (&$error) {
            $error = $message;
        });

        $buffer->write('foo');
        stream_socket_shutdown($b, STREAM_SHUT_RD);
        stream_socket_shutdown($a, STREAM_SHUT_RD);
        $buffer->write('bar');

        $this->assertInstanceOf('Exception', $error);
        $this->assertSame('Unable to write to stream: fwrite(): send of 3 bytes failed with errno=32 Broken pipe', $error->getMessage());
    }

    private function createWriteableLoopMock()
    {
        $loop = $this->createLoopMock();
        $loop->preventWrites = false;
        $loop
            ->expects($this->any())
            ->method('addWriteStream')
            ->will($this->returnCallback(function ($stream, $listener) use ($loop) {
                if (!$loop->preventWrites) {
                    call_user_func($listener, $stream);
                }
            }));

        return $loop;
    }

    private function createLoopMock()
    {
        return $this->getMock('React\EventLoop\LoopInterface');
    }
}
