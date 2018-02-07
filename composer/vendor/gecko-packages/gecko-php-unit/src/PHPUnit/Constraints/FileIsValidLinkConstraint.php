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

namespace GeckoPackages\PHPUnit\Constraints;

use PHPUnit\Framework\Constraint\Constraint;

/**
 * Test if given value is a string and a symlink and points to a file or directory that exists.
 *
 * @see file_exists() is used for testing if the target exits
 *
 * @api
 *
 * @author SpacePossum
 */
final class FileIsValidLinkConstraint extends Constraint
{
    /**
     * {@inheritdoc}
     */
    protected function matches($other)
    {
        return is_string($other) && is_link($other) && file_exists($other);
    }

    /**
     * {@inheritdoc}
     */
    protected function failureDescription($other)
    {
        if (is_object($other)) {
            $type = sprintf('%s#%s', get_class($other), method_exists($other, '__toString') ? $other->__toString() : '');
        } elseif (null === $other) {
            $type = 'null';
        } elseif (!is_string($other)) {
            $type = gettype($other).'#'.$other;
        } elseif (!file_exists($other)) {
            if (is_link($other)) {
                $type = 'link#'.$other;
            } else {
                $type = 'string#'.$other;
            }
        } elseif (is_dir($other)) {
            $type = 'directory#'.$other;
        } elseif (is_file($other)) {
            $type = 'file#'.$other;
        } else { // is string, not dir, not file, not link, should never be reached
            $type = 'string#'.$other;
        }

        return $type.' '.$this->toString();
    }

    /**
     * {@inheritdoc}
     */
    public function toString()
    {
        return 'is a valid link';
    }
}
