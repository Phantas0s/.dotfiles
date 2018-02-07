<?php

declare(strict_types=1);

/*
 * This file is part of the GeckoPackages.
 *
 * (c) GeckoPackages https://github.com/GeckoPackages
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

namespace GeckoPackages\PHPUnit\Asserts;

use GeckoPackages\PHPUnit\Constraints\SameStringsConstraint;
use PHPUnit\Framework\Constraint\Constraint;
use PHPUnit\Framework\Constraint\IsType;
use PHPUnit\Framework\Constraint\LogicalNot;

/**
 * Provides asserts for testing of strings.
 *
 * @api
 *
 * @author Dariusz Rumiński <dariusz.ruminski@gmail.com>
 * @author SpacePossum
 */
trait StringsAssertTrait
{
    /**
     * Assert that strings are not identical.
     *
     * @param string $expected
     * @param mixed  $actual
     * @param string $message
     */
    public static function assertNotSameStrings($expected, $actual, string $message = '')
    {
        self::assertStringsIdentity($actual, $message, __FUNCTION__, new LogicalNot(new SameStringsConstraint($expected)));
    }

    /**
     * Assert that strings are identical.
     *
     * @param string $expected
     * @param mixed  $actual
     * @param string $message
     */
    public static function assertSameStrings($expected, $actual, string $message = '')
    {
        self::assertStringsIdentity($actual, $message, __FUNCTION__, new SameStringsConstraint($expected));
    }

    /**
     * Assert value is a string and is empty.
     *
     * @param mixed  $actual
     * @param string $message
     */
    public static function assertStringIsEmpty($actual, string $message = '')
    {
        AssertHelper::assertMethodDependency(__CLASS__, __TRAIT__, 'assertStringIsEmpty', ['assertThat', 'assertEmpty']);
        self::assertThat($actual, new IsType('string'), $message);
        self::assertEmpty($actual, $message);
    }

    /**
     * Assert value is a string and is not empty.
     *
     * @param mixed  $actual
     * @param string $message
     */
    public static function assertStringIsNotEmpty($actual, string $message = '')
    {
        AssertHelper::assertMethodDependency(__CLASS__, __TRAIT__, 'assertStringIsNotEmpty', ['assertThat', 'assertNotEmpty']);
        self::assertThat($actual, new IsType('string'), $message);
        self::assertNotEmpty($actual, $message);
    }

    /**
     * Assert value is a string and not only contains white space characters (" \t\n\r\0\x0B").
     *
     * Uses PHP function trim @see http://php.net/manual/en/function.trim.php
     * The following characters are considered white space:
     * - " "    (ASCII 32 (0x20)), an ordinary space.
     * - "\t"   (ASCII  9 (0x09)), a tab.
     * - "\n"   (ASCII 10 (0x0A)), a new line (line feed).
     * - "\r"   (ASCII 13 (0x0D)), a carriage return.
     * - "\0"   (ASCII  0 (0x00)), the NUL-byte.
     * - "\x0B" (ASCII 11 (0x0B)), a vertical tab.
     *
     * @param mixed  $actual
     * @param string $message
     */
    public static function assertStringIsNotWhiteSpace($actual, string $message = '')
    {
        AssertHelper::assertMethodDependency(__CLASS__, __TRAIT__, 'assertStringIsNotWhiteSpace', ['assertThat', 'assertNotEmpty']);
        self::assertThat($actual, new IsType('string'), $message);
        self::assertNotEmpty(trim($actual), $message);
    }

    /**
     * Assert value is a string and only contains white space characters (" \t\n\r\0\x0B").
     *
     * Uses PHP function trim @see http://php.net/manual/en/function.trim.php
     * The following characters are considered white space:
     * - " "    (ASCII 32 (0x20)), an ordinary space.
     * - "\t"   (ASCII  9 (0x09)), a tab.
     * - "\n"   (ASCII 10 (0x0A)), a new line (line feed).
     * - "\r"   (ASCII 13 (0x0D)), a carriage return.
     * - "\0"   (ASCII  0 (0x00)), the NUL-byte.
     * - "\x0B" (ASCII 11 (0x0B)), a vertical tab.
     *
     * @param mixed  $actual
     * @param string $message
     */
    public static function assertStringIsWhiteSpace($actual, string $message = '')
    {
        AssertHelper::assertMethodDependency(__CLASS__, __TRAIT__, 'assertStringIsWhiteSpace', ['assertThat', 'assertEmpty']);
        self::assertThat($actual, new IsType('string'), $message);
        self::assertEmpty(trim($actual), $message);
    }

    /**
     * @param mixed      $actual
     * @param string     $message
     * @param string     $method
     * @param Constraint $constraint
     */
    private static function assertStringsIdentity($actual, string $message, string $method, Constraint $constraint)
    {
        AssertHelper::assertMethodDependency(__CLASS__, __TRAIT__, $method, ['assertThat']);
        self::assertThat($actual, $constraint, $message);
    }
}
