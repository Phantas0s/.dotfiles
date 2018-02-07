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

use GeckoPackages\PHPUnit\Constraints\ScalarConstraint;
use PHPUnit\Framework\Constraint\Constraint;
use PHPUnit\Framework\Constraint\LogicalNot;

/**
 * Provides alias/short hand asserts.
 *
 * Additional alias/shorthand PHPUnit asserts to test for some types etc.
 *
 * @api
 *
 * @author SpacePossum
 */
trait AliasAssertTrait
{
    /**
     * Assert value is an array.
     *
     * @param mixed  $actual
     * @param string $message
     */
    public static function assertArray($actual, string $message = '')
    {
        self::assertTypeOfScalar($actual, $message, 'assertArray', new ScalarConstraint(ScalarConstraint::TYPE_ARRAY));
    }

    /**
     * Assert value is a bool (boolean).
     *
     * @param mixed  $actual
     * @param string $message
     */
    public static function assertBool($actual, string $message = '')
    {
        self::assertTypeOfScalar($actual, $message, 'assertBool', new ScalarConstraint(ScalarConstraint::TYPE_BOOL));
    }

    /**
     * Assert value is a float (double, real).
     *
     * @param mixed  $actual
     * @param string $message
     */
    public static function assertFloat($actual, string $message = '')
    {
        self::assertTypeOfScalar($actual, $message, 'assertFloat', new ScalarConstraint(ScalarConstraint::TYPE_FLOAT));
    }

    /**
     * Assert value is an int (integer).
     *
     * @param mixed  $actual
     * @param string $message
     */
    public static function assertInt($actual, string $message = '')
    {
        self::assertTypeOfScalar($actual, $message, 'assertInt', new ScalarConstraint(ScalarConstraint::TYPE_INT));
    }

    /**
     * Assert value is a scalar.
     *
     * @param mixed  $actual
     * @param string $message
     */
    public static function assertScalar($actual, string $message = '')
    {
        self::assertTypeOfScalar($actual, $message, 'assertScalar', new ScalarConstraint(ScalarConstraint::TYPE_SCALAR));
    }

    /**
     * Assert value is a string.
     *
     * @param mixed  $actual
     * @param string $message
     */
    public static function assertString($actual, string $message = '')
    {
        self::assertTypeOfScalar($actual, $message, 'assertString', new ScalarConstraint(ScalarConstraint::TYPE_STRING));
    }

    /**
     * Assert value is not an array.
     *
     * @param mixed  $actual
     * @param string $message
     */
    public static function assertNotArray($actual, string $message = '')
    {
        self::assertTypeOfScalar($actual, $message, 'assertNotArray', new LogicalNot(new ScalarConstraint(ScalarConstraint::TYPE_ARRAY)));
    }

    /**
     * Assert value is not a bool (boolean).
     *
     * @param mixed  $actual
     * @param string $message
     */
    public static function assertNotBool($actual, string $message = '')
    {
        self::assertTypeOfScalar($actual, $message, 'assertNotBool', new LogicalNot(new ScalarConstraint(ScalarConstraint::TYPE_BOOL)));
    }

    /**
     * Assert value is not a float (double, real).
     *
     * @param mixed  $actual
     * @param string $message
     */
    public static function assertNotFloat($actual, string $message = '')
    {
        self::assertTypeOfScalar($actual, $message, 'assertNotFloat', new LogicalNot(new ScalarConstraint(ScalarConstraint::TYPE_FLOAT)));
    }

    /**
     * Assert value is not an int (integer).
     *
     * @param mixed  $actual
     * @param string $message
     */
    public static function assertNotInt($actual, string $message = '')
    {
        self::assertTypeOfScalar($actual, $message, 'assertNotInt', new LogicalNot(new ScalarConstraint(ScalarConstraint::TYPE_INT)));
    }

    /**
     * Assert value is not a scalar.
     *
     * @param mixed  $actual
     * @param string $message
     */
    public static function assertNotScalar($actual, string $message = '')
    {
        self::assertTypeOfScalar($actual, $message, 'assertNotScalar', new LogicalNot(new ScalarConstraint(ScalarConstraint::TYPE_SCALAR)));
    }

    /**
     * Assert value is not a string.
     *
     * @param mixed  $actual
     * @param string $message
     */
    public static function assertNotString($actual, string $message = '')
    {
        self::assertTypeOfScalar($actual, $message, 'assertNotString', new LogicalNot(new ScalarConstraint(ScalarConstraint::TYPE_STRING)));
    }

    /**
     * @param mixed      $actual
     * @param string     $message
     * @param string     $method
     * @param Constraint $constraint
     */
    private static function assertTypeOfScalar($actual, string $message, string $method, Constraint $constraint)
    {
        AssertHelper::assertMethodDependency(__CLASS__, __TRAIT__, $method, ['assertThat']);
        self::assertThat($actual, $constraint, $message);
    }
}
