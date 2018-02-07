<?php

namespace Phine\Exception\Tests;

use Phine\Exception\Exception;
use PHPUnit_Framework_TestCase as TestCase;

/**
 * Runs tests on the `Phine\Exception\Exception` class.
 *
 * @author Kevin Herrera <kevin@herrera.io>
 */
class ExceptionTest extends TestCase
{
    /**
     * Creates a new exception using a couple of values for formatting without
     * passing a `$previous` exception. The exception returned should have the
     * properly formatted message, and without a previous exception set.
     */
    public function testCreateUsingFormat()
    {
        $exception = Exception::createUsingFormat(
            'This is %s %drd message.',
            'my',
            3
        );

        $this->assertInstanceOf(
            'Phine\\Exception\\Exception',
            $exception
        );

        $this->assertEquals(
            'This is my 3rd message.',
            $exception->getMessage()
        );

        $this->assertNull($exception->getPrevious());
    }

    /**
     * Nearly identical to the `testCreateUsingFormat()` test, but this time
     * a `$previous` exception will be passed. The message should be the same
     * as before, but the `$previous` exception must be returned this time.
     */
    public function testCreateUsingFormatWithPrevious()
    {
        $previous = new \Exception('The previous exception.');
        $exception = Exception::createUsingFormat(
            'This is %s %drd message.',
            'my',
            3,
            $previous
        );

        $this->assertInstanceOf(
            'Phine\\Exception\\Exception',
            $exception
        );

        $this->assertEquals(
            'This is my 3rd message.',
            $exception->getMessage()
        );

        $this->assertSame(
            $previous,
            $exception->getPrevious()
        );
    }

    /**
     * **No errors should be generated prior to this test.** This test will
     * check that the default message "(unknown error)" is used if no error
     * has been generated.
     */
    public function testCreateUsingLastErrorWithDefault()
    {
        $exception = Exception::createUsingLastError();

        $this->assertInstanceOf(
            'Phine\\Exception\\Exception',
            $exception
        );

        $this->assertEquals(
            '(unknown error)',
            $exception->getMessage()
        );
    }

    /**
     * Like the `testCreateUsingLastErrorWithDefault()` test, no errors should
     * be generated prior to this test. This test will check that the user given
     * default message is used if no error has been generated.
     */
    public function testCreateUsingLastErrorWithDefaultGiven()
    {
        $default = 'The default message.';
        $exception = Exception::createUsingLastError(null, $default);

        $this->assertInstanceOf(
            'Phine\\Exception\\Exception',
            $exception
        );

        $this->assertEquals(
            $default,
            $exception->getMessage()
        );
    }

    /**
     * Generates a warning by accessing an undefined variable. An exception
     * will then be created using the default arguments. The message will
     * then be directly compared to the one returned by `error_get_last()`,
     * since they should be identical.
     */
    public function testCreateUsingLastError()
    {
        @$undefinedCreateUsingLastError;

        $exception = Exception::createUsingLastError();

        $this->assertInstanceOf(
            'Phine\\Exception\\Exception',
            $exception
        );

        $error = error_get_last();

        $this->assertEquals(
            $error['message'],
            $exception->getMessage()
        );
    }

    /**
     * Almost identical to the `testCreateUsingLastError()` test, but a prefix
     * is defined this time. Like the previous test, the message should be the
     * same, but the prefix added.
     *
     * @depends testCreateUsingLastError
     */
    public function testCreateUsingLastErrorWithPrefix()
    {
        @$undefinedCreateUsingLastErrorWithPrefix;

        $prefix = 'This is the prefix: ';
        $exception = Exception::createUsingLastError($prefix);

        $this->assertInstanceOf(
            'Phine\\Exception\\Exception',
            $exception
        );

        $error = error_get_last();

        $this->assertEquals(
            $prefix . $error['message'],
            $exception->getMessage()
        );
    }
}
