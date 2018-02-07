<?php

namespace React\Tests\ChildProcess;

use React\ChildProcess\Process;
use React\EventLoop\Timer\Timer;
use SebastianBergmann\Environment\Runtime;

abstract class AbstractProcessTest extends \PHPUnit_Framework_TestCase
{
    abstract public function createLoop();

    public function testGetEnhanceSigchildCompatibility()
    {
        $process = new Process('echo foo');

        $this->assertSame($process, $process->setEnhanceSigchildCompatibility(true));
        $this->assertTrue($process->getEnhanceSigchildCompatibility());

        $this->assertSame($process, $process->setEnhanceSigchildCompatibility(false));
        $this->assertFalse($process->getEnhanceSigchildCompatibility());
    }

    /**
     * @expectedException RuntimeException
     */
    public function testSetEnhanceSigchildCompatibilityCannotBeCalledIfProcessIsRunning()
    {
        $process = new Process('sleep 1');

        $process->start($this->createLoop());
        $process->setEnhanceSigchildCompatibility(false);
    }

    public function testGetCommand()
    {
        $process = new Process('echo foo');

        $this->assertSame('echo foo', $process->getCommand());
    }

    public function testIsRunning()
    {
        $process = new Process('sleep 1');

        $this->assertFalse($process->isRunning());
        $process->start($this->createLoop());
        $this->assertTrue($process->isRunning());

        return $process;
    }

    /**
     * @depends testIsRunning
     */
    public function testGetExitCodeWhenRunning($process)
    {
        $this->assertNull($process->getExitCode());
    }

    /**
     * @depends testIsRunning
     */
    public function testGetTermSignalWhenRunning($process)
    {
        $this->assertNull($process->getTermSignal());
    }

    public function testReceivesProcessStdoutFromEcho()
    {
        $cmd = 'echo test';

        $loop = $this->createLoop();
        $process = new Process($cmd);
        $process->start($loop);

        $buffer = '';
        $process->stdout->on('data', function ($data) use (&$buffer) {
            $buffer .= $data;
        });

        $loop->run();

        $this->assertEquals('test', rtrim($buffer));
    }

    public function testReceivesProcessStdoutFromDd()
    {
        if (!file_exists('/dev/zero')) {
            $this->markTestSkipped('Unable to read from /dev/zero, Windows?');
        }

        $cmd = 'dd if=/dev/zero bs=12345 count=1234';

        $loop = $this->createLoop();
        $process = new Process($cmd);
        $process->start($loop);

        $bytes = 0;
        $process->stdout->on('data', function ($data) use (&$bytes) {
            $bytes += strlen($data);
        });

        $loop->run();

        $this->assertEquals(12345 * 1234, $bytes);
    }

    public function testProcessPidNotSameDueToShellWrapper()
    {
        $cmd = $this->getPhpBinary() . ' -r ' . escapeshellarg('echo getmypid();');

        $loop = $this->createLoop();
        $process = new Process($cmd, '/');
        $process->start($loop);

        $output = '';
        $process->stdout->on('data', function ($data) use (&$output) {
            $output .= $data;
        });

        $loop->run();

        $this->assertNotEquals('', $output);
        $this->assertNotNull($process->getPid());
        $this->assertNotEquals($process->getPid(), $output);
    }

    public function testProcessPidSameWithExec()
    {
        $cmd = 'exec ' . $this->getPhpBinary() . ' -r ' . escapeshellarg('echo getmypid();');

        $loop = $this->createLoop();
        $process = new Process($cmd, '/');
        $process->start($loop);

        $output = '';
        $process->stdout->on('data', function ($data) use (&$output) {
            $output .= $data;
        });

        $loop->run();

        $this->assertNotNull($process->getPid());
        $this->assertEquals($process->getPid(), $output);
    }

    public function testProcessWithDefaultCwdAndEnv()
    {
        $cmd = $this->getPhpBinary() . ' -r ' . escapeshellarg('echo getcwd(), PHP_EOL, count($_SERVER), PHP_EOL;');

        $loop = $this->createLoop();
        $process = new Process($cmd);

        $output = '';

        $loop->addTimer(0.001, function(Timer $timer) use ($process, &$output) {
            $process->start($timer->getLoop());
            $process->stdout->on('data', function () use (&$output) {
                $output .= func_get_arg(0);
            });
        });

        $loop->run();

        list($cwd, $envCount) = explode(PHP_EOL, $output);

        /* Child process should inherit the same current working directory and
         * existing environment variables; however, it may be missing a "_"
         * environment variable (i.e. current shell/script) on some platforms.
         */
        $this->assertSame(getcwd(), $cwd);
        $this->assertLessThanOrEqual(1, (count($_SERVER) - (integer) $envCount));
    }

    public function testProcessWithCwd()
    {
        $cmd = $this->getPhpBinary() . ' -r ' . escapeshellarg('echo getcwd(), PHP_EOL;');

        $loop = $this->createLoop();
        $process = new Process($cmd, '/');

        $output = '';

        $loop->addTimer(0.001, function(Timer $timer) use ($process, &$output) {
            $process->start($timer->getLoop());
            $process->stdout->on('data', function () use (&$output) {
                $output .= func_get_arg(0);
            });
        });

        $loop->run();

        $this->assertSame('/' . PHP_EOL, $output);
    }

    public function testProcessWithEnv()
    {
        if (getenv('TRAVIS')) {
            $this->markTestSkipped('Cannot execute PHP processes with custom environments on Travis CI.');
        }

        $cmd = $this->getPhpBinary() . ' -r ' . escapeshellarg('echo getenv("foo"), PHP_EOL;');

        $loop = $this->createLoop();
        $process = new Process($cmd, null, array('foo' => 'bar'));

        $output = '';

        $loop->addTimer(0.001, function(Timer $timer) use ($process, &$output) {
            $process->start($timer->getLoop());
            $process->stdout->on('data', function () use (&$output) {
                $output .= func_get_arg(0);
            });
        });

        $loop->run();

        $this->assertSame('bar' . PHP_EOL, $output);
    }

    public function testStartAndAllowProcessToExitSuccessfullyUsingEventLoop()
    {
        $loop = $this->createLoop();
        $process = new Process('exit 0');

        $called = false;
        $exitCode = 'initial';
        $termSignal = 'initial';

        $process->on('exit', function () use (&$called, &$exitCode, &$termSignal) {
            $called = true;
            $exitCode = func_get_arg(0);
            $termSignal = func_get_arg(1);
        });

        $loop->addTimer(0.001, function(Timer $timer) use ($process) {
            $process->start($timer->getLoop());
        });

        $loop->run();

        $this->assertTrue($called);
        $this->assertSame(0, $exitCode);
        $this->assertNull($termSignal);

        $this->assertFalse($process->isRunning());
        $this->assertSame(0, $process->getExitCode());
        $this->assertNull($process->getTermSignal());
        $this->assertFalse($process->isTerminated());
    }

    public function testStartInvalidProcess()
    {
        $cmd = tempnam(sys_get_temp_dir(), 'react');

        $loop = $this->createLoop();
        $process = new Process($cmd);

        $output = '';

        $loop->addTimer(0.001, function(Timer $timer) use ($process, &$output) {
            $process->start($timer->getLoop());
            $process->stderr->on('data', function () use (&$output) {
                $output .= func_get_arg(0);
            });
        });

        $loop->run();

        unlink($cmd);

        $this->assertNotEmpty($output);
    }

    /**
     * @expectedException RuntimeException
     */
    public function testStartAlreadyRunningProcess()
    {
        $process = new Process('sleep 1');

        $process->start($this->createLoop());
        $process->start($this->createLoop());
    }

    public function testTerminateWithDefaultTermSignalUsingEventLoop()
    {
        if (defined('PHP_WINDOWS_VERSION_BUILD')) {
            $this->markTestSkipped('Windows does not report signals via proc_get_status()');
        }

        if (!defined('SIGTERM')) {
            $this->markTestSkipped('SIGTERM is not defined');
        }

        $loop = $this->createloop();
        $process = new Process('sleep 1; exit 0');

        $called = false;
        $exitCode = 'initial';
        $termSignal = 'initial';

        $process->on('exit', function () use (&$called, &$exitCode, &$termSignal) {
            $called = true;
            $exitCode = func_get_arg(0);
            $termSignal = func_get_arg(1);
        });

        $loop->addTimer(0.001, function(Timer $timer) use ($process) {
            $process->start($timer->getLoop());
            $process->terminate();
        });

        $loop->run();

        $this->assertTrue($called);
        $this->assertNull($exitCode);
        $this->assertEquals(SIGTERM, $termSignal);

        $this->assertFalse($process->isRunning());
        $this->assertNull($process->getExitCode());
        $this->assertEquals(SIGTERM, $process->getTermSignal());
        $this->assertTrue($process->isTerminated());
    }

    public function testTerminateWithStopAndContinueSignalsUsingEventLoop()
    {
        if (defined('PHP_WINDOWS_VERSION_BUILD')) {
            $this->markTestSkipped('Windows does not report signals via proc_get_status()');
        }

        if (!defined('SIGSTOP') && !defined('SIGCONT')) {
            $this->markTestSkipped('SIGSTOP and/or SIGCONT is not defined');
        }

        $loop = $this->createloop();
        $process = new Process('sleep 1; exit 0');

        $called = false;
        $exitCode = 'initial';
        $termSignal = 'initial';

        $process->on('exit', function () use (&$called, &$exitCode, &$termSignal) {
            $called = true;
            $exitCode = func_get_arg(0);
            $termSignal = func_get_arg(1);
        });

        $that = $this;
        $loop->addTimer(0.001, function(Timer $timer) use ($process, $that) {
            $process->start($timer->getLoop());
            $process->terminate(SIGSTOP);

            $that->assertSoon(function() use ($process, $that) {
                $that->assertTrue($process->isStopped());
                $that->assertTrue($process->isRunning());
                $that->assertEquals(SIGSTOP, $process->getStopSignal());
            });

            $process->terminate(SIGCONT);

            $that->assertSoon(function() use ($process, $that) {
                $that->assertFalse($process->isStopped());
                $that->assertEquals(SIGSTOP, $process->getStopSignal());
            });
        });

        $loop->run();

        $this->assertTrue($called);
        $this->assertSame(0, $exitCode);
        $this->assertNull($termSignal);

        $this->assertFalse($process->isRunning());
        $this->assertSame(0, $process->getExitCode());
        $this->assertNull($process->getTermSignal());
        $this->assertFalse($process->isTerminated());
    }

    public function testIssue18() {
        $loop = $this->createLoop();

        $testString = 'x';

        $process = new Process($this->getPhpBinary() . " -r 'echo \"$testString\";'");

        $stdOut = '';
        $stdErr = '';

        $that = $this;
        $process->on(
            'exit',
            function ($exitCode) use (&$stdOut, &$stdErr, $testString, $that) {
                $that->assertEquals(0, $exitCode, "Exit code is 0");

                $that->assertEquals($testString, $stdOut);
            }
        );

        $process->start($loop);

        $process->stdout->on(
            'data',
            function ($output) use (&$stdOut) {
                $stdOut .= $output;
            }
        );
        $process->stderr->on(
            'data',
            function ($output) use (&$stdErr) {
                $stdErr .= $output;
            }
        );

        $loop->tick();
        sleep(1); // comment this line out and it works fine

        $loop->run();
    }

    /**
     * Execute a callback at regular intervals until it returns successfully or
     * a timeout is reached.
     *
     * @param Closure $callback Callback with one or more assertions
     * @param integer $timeout  Time limit for callback to succeed (milliseconds)
     * @param integer $interval Interval for retrying the callback (milliseconds)
     * @throws PHPUnit_Framework_ExpectationFailedException Last exception raised by the callback
     */
    public function assertSoon(\Closure $callback, $timeout = 20000, $interval = 200)
    {
        $start = microtime(true);
        $timeout /= 1000; // convert to seconds
        $interval *= 1000; // convert to microseconds

        while (1) {
            try {
                call_user_func($callback);
                return;
            } catch (\PHPUnit_Framework_ExpectationFailedException $e) {}

            if ((microtime(true) - $start) > $timeout) {
                throw $e;
            }

            usleep($interval);
        }
    }

    private function getPhpBinary()
    {
        $runtime = new Runtime();

        return $runtime->getBinary();
    }
}
