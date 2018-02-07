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
 * @api
 *
 * @author SpacePossum
 */
final class FilePermissionsMaskConstraint extends Constraint
{
    /**
     * @var int
     */
    private $mask;

    /**
     * @param int $mask
     */
    public function __construct(int $mask)
    {
        parent::__construct();

        $this->mask = $mask;
    }

    /**
     * {@inheritdoc}
     */
    protected function matches($other)
    {
        if (!is_string($other) || !file_exists($other)) {
            return false;
        }

        if (is_link($other)) {
            $perms = lstat($other);
            $perms = $perms['mode'];
        } else {
            $perms = fileperms($other);
        }

        return ($perms & $this->mask) === $this->mask;
    }

    /**
     * {@inheritdoc}
     */
    protected function failureDescription($other)
    {
        if (!is_string($other)) {
            if (is_object($other)) {
                $type = sprintf('%s#%s', get_class($other), method_exists($other, '__toString') ? $other->__toString() : '');
            } elseif (null === $other) {
                $type = 'null';
            } else {
                $type = gettype($other).'#'.$other;
            }

            return $type.' '.$this->toString();
        }

        if (!file_exists($other)) {
            return 'not file or directory#'.$other.' '.$this->toString();
        }

        if (is_link($other)) {
            $type = 'link';
            $perms = lstat($other);
            $perms = $perms['mode'];
        } else {
            $type = is_file($other) ? 'file' : (is_dir($other) ? 'directory' : 'other');
            $perms = fileperms($other);
        }

        return sprintf('%s#%s %o %s %o', $type, $other, $perms, $this->toString(), $this->mask);
    }

    /**
     * {@inheritdoc}
     */
    public function toString()
    {
        return 'permissions matches mask';
    }
}
