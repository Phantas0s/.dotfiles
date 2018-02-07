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

use PHPUnit\Framework\Exception;

/**
 * Helper for building exceptions and checking dependencies.
 *
 * @internal
 *
 * @author SpacePossum
 */
final class AssertHelper
{
    /**
     * @param string   $class              name of the class using trait;
     * @param string   $trait              name of the trait calling method;
     * @param string   $method             called method name
     * @param string[] $methodDependencies list of methods the trait relies on
     *
     * @throws Exception
     */
    public static function assertMethodDependency(string $class, string $trait, string $method, array $methodDependencies)
    {
        $missing = [];
        foreach ($methodDependencies as $methodDependency) {
            if (!method_exists($class, $methodDependency)) {
                $missing[] = sprintf('"%s"', $methodDependency);
            }
        }

        if (0 !== count($missing)) {
            throw self::createException(
                $trait,
                $method,
                sprintf('Relies on missing %s %s', count($missing) > 1 ? 'methods' : 'method', implode(', ', $missing))
            );
        }
    }

    /**
     * @param string $trait                   name of the trait used
     * @param string $method                  called method name
     * @param string $expectedTypeForArgument expected type description
     * @param mixed  $valueOfArgument         given value
     * @param int    $index                   argument position
     *
     * @return Exception
     */
    public static function createArgumentException(string $trait, string $method, string $expectedTypeForArgument, $valueOfArgument, int $index = 1): Exception
    {
        return self::createArgumentExceptionWithMessage(
            $trait,
            $method,
            $valueOfArgument,
            sprintf('must be %s.', (in_array($expectedTypeForArgument[0], ['a', 'e', 'i', 'o', 'u'], true) ? 'an' : 'a').' '.$expectedTypeForArgument),
            $index
        );
    }

    public static function createArgumentExceptionWithMessage(string $trait, string $method, $valueOfArgument, string $message, int $index = 1): Exception
    {
        if (is_object($valueOfArgument)) {
            $valueOfArgument = sprintf('%s#%s', get_class($valueOfArgument), method_exists($valueOfArgument, '__toString') ? $valueOfArgument->__toString() : '');
        } elseif (null === $valueOfArgument) {
            $valueOfArgument = 'null';
        } else {
            $valueOfArgument = gettype($valueOfArgument).'#'.$valueOfArgument;
        }

        return new Exception(
            sprintf(
                'Argument #%d (%s) of %s::%s() %s',
                $index,
                $valueOfArgument,
                substr($trait, strrpos($trait, '\\') + 1),
                $method,
                $message
            )
        );
    }

    /**
     * @param string $trait   name of the trait used
     * @param string $method  called method name
     * @param string $message
     *
     * @return Exception
     */
    private static function createException(string $trait, string $method, string $message): Exception
    {
        return new Exception(
            sprintf(
                '%s::%s() %s.',
                substr($trait, strrpos($trait, '\\') + 1),
                $method,
                $message
            )
        );
    }
}
