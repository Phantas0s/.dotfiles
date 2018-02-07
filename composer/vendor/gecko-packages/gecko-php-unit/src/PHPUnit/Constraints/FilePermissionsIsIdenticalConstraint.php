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
 * @note Some code is derived from the example on PHP net (http://php.net/manual/en/function.fileperms.php)
 *
 * @api
 *
 * @author SpacePossum
 */
final class FilePermissionsIsIdenticalConstraint extends Constraint
{
    /**
     * @var int|string
     */
    private $permissions;

    private static $permissionFormat = '#^[slbdcpu\-]([r-][w-][sxS-]){2}[r-][w-][txT-]$#';

    /**
     * @param int|string $permissions
     */
    public function __construct($permissions)
    {
        parent::__construct();

        if (is_string($permissions)) {
            if (preg_match('#^\d+$#', $permissions)) {
                $this->permissions = '0' === $permissions[0]
                    ? intval($permissions, 8)
                    : (int) $permissions
                ;

                return;
            }

            if (1 === preg_match(self::$permissionFormat, $permissions)) {
                $this->permissions = $permissions;

                return;
            }

            throw new \InvalidArgumentException(sprintf('Permission to match "%s" is not formatted correctly.', $permissions));
        }

        if (!is_int($permissions)) {
            if (is_object($permissions)) {
                $type = sprintf('%s#%s', get_class($permissions), method_exists($permissions, '__toString') ? $permissions->__toString() : '');
            } elseif (null === $permissions) {
                $type = 'null';
            } else {
                $type = gettype($permissions).'#'.$permissions;
            }

            throw new \InvalidArgumentException(sprintf('Invalid value for permission to match "%s", expected int >= 0 or string.', $type));
        }

        if ($permissions < 0) {
            throw new \InvalidArgumentException(sprintf('Invalid value for permission to match "%d", expected int >= 0 or string.', $permissions));
        }

        $this->permissions = $permissions;
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

        if (is_string($this->permissions)) {
            return self::getFilePermissionsAsString($perms) === $this->permissions;
        }

        // $this->permissions is int
        // for example 0777 vs 100777
        if ($this->permissions < 1412) {
            $comp = (int) sprintf('%o', $this->permissions);
            $filePerm = (int) substr(sprintf('%o', $perms), -3);
        } else {
            $comp = $this->permissions;
            $filePerm = (int) sprintf('%o', $perms);
        }

        return $filePerm === $comp;
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
            $perms = lstat($other);
            $perms = $perms['mode'];
            $type = 'link';
        } else {
            $perms = fileperms($other);
            $type = is_file($other) ? 'file' : (is_dir($other) ? 'directory' : 'other');
        }

        if (is_string($this->permissions)) {
            return sprintf('%s#%s %s %s to %s', $type, $other, self::getFilePermissionsAsString($perms), $this->toString(), $this->permissions);
        }

        if ($this->permissions < 1412) {
            $comp = (int) sprintf('%o', $this->permissions);
            $perms = (int) substr(sprintf('%o', $perms), -3);
        } else {
            $comp = $this->permissions;
            $perms = (int) sprintf('%o', $perms);
        }

        return sprintf('%s#%s 0%d %s to 0%d', $type, $other, $perms, $this->toString(), $comp);
    }

    /**
     * {@inheritdoc}
     */
    public function toString()
    {
        return 'permissions are equal';
    }

    /**
     * @param int $perms
     *
     * @return string
     */
    private static function getFilePermissionsAsString($perms)
    {
        if (0xC000 === ($perms & 0xC000)) {       // Socket
            $info = 's';
        } elseif (0xA000 === ($perms & 0xA000)) { // Symbolic Link
            $info = 'l';
        } elseif (0x8000 === ($perms & 0x8000)) { // Regular
            $info = '-';
        } elseif (0x6000 === ($perms & 0x6000)) { // Block special
            $info = 'b';
        } elseif (0x4000 === ($perms & 0x4000)) { // Directory
            $info = 'd';
        } elseif (0x2000 === ($perms & 0x2000)) { // Character special
            $info = 'c';
        } elseif (0x1000 === ($perms & 0x1000)) { // FIFO pipe
            $info = 'p';
        } else { // Unknown
            $info = 'u';
        }

        // Owner
        $info .= (($perms & 0x0100) ? 'r' : '-');
        $info .= (($perms & 0x0080) ? 'w' : '-');
        $info .= (($perms & 0x0040) ?
            (($perms & 0x0800) ? 's' : 'x') :
            (($perms & 0x0800) ? 'S' : '-'));

        // Group
        $info .= (($perms & 0x0020) ? 'r' : '-');
        $info .= (($perms & 0x0010) ? 'w' : '-');
        $info .= (($perms & 0x0008) ?
            (($perms & 0x0400) ? 's' : 'x') :
            (($perms & 0x0400) ? 'S' : '-'));

        // World
        $info .= (($perms & 0x0004) ? 'r' : '-');
        $info .= (($perms & 0x0002) ? 'w' : '-');
        $info .= (($perms & 0x0001) ?
            (($perms & 0x0200) ? 't' : 'x') :
            (($perms & 0x0200) ? 'T' : '-'));

        return $info;
    }
}
