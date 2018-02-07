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

use GeckoPackages\PHPUnit\Constraints\NumberRangeConstraint;
use GeckoPackages\PHPUnit\Constraints\UnsignedIntConstraint;
use PHPUnit\Framework\Constraint\LogicalNot;

/**
 * Provides asserts for testing values with ranges.
 *
 * Additional PHPUnit asserts for testing if numbers are within or on ranges.
 *
 * @api
 *
 * @author SpacePossum
 */
trait RangeAssertTrait
{
    /**
     * Assert that a number is within a given range (a,b).
     *
     * @param int|float $lowerBoundary
     * @param int|float $upperBoundary
     * @param mixed     $actual
     * @param string    $message
     */
    public static function assertNumberInRange($lowerBoundary, $upperBoundary, $actual, string $message = '')
    {
        self::assertNumberRangeMatch($lowerBoundary, $upperBoundary, $actual, $message, 'assertNumberInRange', false, false);
    }

    /**
     * Assert that a number is not within a given range !(a,b).
     *
     * @param int|float $lowerBoundary
     * @param int|float $upperBoundary
     * @param mixed     $actual
     * @param string    $message
     */
    public static function assertNumberNotInRange($lowerBoundary, $upperBoundary, $actual, string $message = '')
    {
        self::assertNumberRangeMatch($lowerBoundary, $upperBoundary, $actual, $message, 'assertNumberNotInRange', false, true);
    }

    /**
     * Assert that a number is not within a given range and not on its boundaries ![a,b].
     *
     * @param int|float $lowerBoundary
     * @param int|float $upperBoundary
     * @param mixed     $actual
     * @param string    $message
     */
    public static function assertNumberNotOnRange($lowerBoundary, $upperBoundary, $actual, string $message = '')
    {
        self::assertNumberRangeMatch($lowerBoundary, $upperBoundary, $actual, $message, 'assertNumberNotOnRange', true, true);
    }

    /**
     * Assert that a number is within a given range or on its boundaries [a,b].
     *
     * @param int|float $lowerBoundary
     * @param int|float $upperBoundary
     * @param mixed     $actual
     * @param string    $message
     */
    public static function assertNumberOnRange($lowerBoundary, $upperBoundary, $actual, string $message = '')
    {
        self::assertNumberRangeMatch($lowerBoundary, $upperBoundary, $actual, $message, 'assertNumberOnRange', true, false);
    }

    /**
     * Assert that given value is an unsigned int (>= 0).
     *
     * @param mixed  $actual
     * @param string $message
     */
    public function assertUnsignedInt($actual, string $message = '')
    {
        AssertHelper::assertMethodDependency(__CLASS__, __TRAIT__, 'assertUnsignedInt', ['assertThat']);
        self::assertThat($actual, new UnsignedIntConstraint(), $message);
    }

    /**
     * @param int|float $lowerBoundary
     * @param int|float $upperBoundary
     * @param mixed     $actual
     * @param string    $message
     * @param string    $method        name of method doing the testing
     * @param bool      $onBoundary    test on boundary or between boundary values
     * @param bool      $negative      test as negative
     */
    private static function assertNumberRangeMatch(
        $lowerBoundary,
        $upperBoundary,
        $actual,
        string $message,
        string $method,
        bool $onBoundary,
        bool $negative
    ) {
        if (!is_int($lowerBoundary) && !is_float($lowerBoundary)) {
            throw AssertHelper::createArgumentException(__TRAIT__, $method, 'float or int', $lowerBoundary);
        }

        if (!is_int($upperBoundary) && !is_float($upperBoundary)) {
            throw AssertHelper::createArgumentException(__TRAIT__, $method, 'float or int', $upperBoundary, 2);
        }

        if ($lowerBoundary >= $upperBoundary) {
            $message = sprintf(
                'lower boundary %s must be smaller than upper boundary %s.',
                is_int($lowerBoundary) ? '%d' : '%.3f',
                is_int($upperBoundary) ? '%d' : '%.3f'
            );

            throw AssertHelper::createArgumentExceptionWithMessage(
                __TRAIT__,
                $method,
                $lowerBoundary,
                sprintf($message, $lowerBoundary, $upperBoundary)
            );
        }

        $rangeConstraint = new NumberRangeConstraint($lowerBoundary, $upperBoundary, $onBoundary);
        if ($negative) {
            $rangeConstraint = new LogicalNot($rangeConstraint);
        }

        AssertHelper::assertMethodDependency(__CLASS__, __TRAIT__, $method, ['assertThat']);
        self::assertThat($actual, $rangeConstraint, $message);
    }
}
