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

use GeckoPackages\PHPUnit\Constraints\DirectoryEmptyConstraint;
use GeckoPackages\PHPUnit\Constraints\FileIsLinkConstraint;
use GeckoPackages\PHPUnit\Constraints\FileIsValidLinkConstraint;
use GeckoPackages\PHPUnit\Constraints\FilePermissionsIsIdenticalConstraint;
use GeckoPackages\PHPUnit\Constraints\FilePermissionsMaskConstraint;
use PHPUnit\Framework\Constraint\Constraint;
use PHPUnit\Framework\Constraint\LogicalNot;

/**
 * Provides asserts for testing directories, files and symbolic links.
 *
 * Additional PHPUnit asserts for testing file (system) based logic.
 *
 * @api
 *
 * @author SpacePossum
 */
trait FileSystemAssertTrait
{
    /**
     * Assert that a directory exists and is empty.
     *
     * @param mixed  $filename
     * @param string $message
     */
    public static function assertDirectoryEmpty($filename, string $message = '')
    {
        self::assertThatConstraint($filename, $message, 'assertDirectoryEmpty', new DirectoryEmptyConstraint());
    }

    /**
     * Assert that a directory exists and is not empty.
     *
     * @param mixed  $filename
     * @param string $message
     */
    public static function assertDirectoryNotEmpty($filename, string $message = '')
    {
        self::assertThatConstraint($filename, $message, 'assertDirectoryNotEmpty', new LogicalNot(new DirectoryEmptyConstraint()));
    }

    /**
     * Asserts that a file permission matches, for example: 'drwxrwxrwx' or '0664'.
     *
     * @param int|string $permissions > 0 or string; format for example: 'drwxrwxrwx'
     * @param mixed      $filename
     * @param string     $message
     */
    public static function assertFileHasPermissions($permissions, $filename, string $message = '')
    {
        if (!is_string($permissions) && !(is_int($permissions) && $permissions >= 0)) {
            throw AssertHelper::createArgumentException(__TRAIT__, 'assertFileHasPermissions', 'int (>= 0) or string', $permissions);
        }

        try {
            $constraint = new FilePermissionsIsIdenticalConstraint($permissions);
        } catch (\InvalidArgumentException $e) {
            throw AssertHelper::createArgumentExceptionWithMessage(
                __TRAIT__,
                'assertFileHasPermissions',
                $permissions,
                $e->getMessage()
            );
        }

        self::assertThatConstraint($filename, $message, 'assertFileHasPermissions', $constraint);
    }

    /**
     * Assert that a file is a symbolic link.
     *
     * @param mixed  $filename
     * @param string $message
     */
    public static function assertFileIsLink($filename, string $message = '')
    {
        self::assertThatConstraint($filename, $message, 'assertFileIsLink', new FileIsLinkConstraint());
    }

    /**
     * Assert that a file is not a symbolic link.
     *
     * @param mixed  $filename
     * @param string $message
     */
    public static function assertFileIsNotLink($filename, string $message = '')
    {
        self::assertThatConstraint($filename, $message, 'assertFileIsNotLink', new LogicalNot(new FileIsLinkConstraint()));
    }

    /**
     * Assert given value is a string, symlink and points to a file or directory that exists.
     *
     * @param mixed  $filename
     * @param string $message
     */
    public static function assertFileIsValidLink($filename, string $message = '')
    {
        self::assertThatConstraint($filename, $message, 'assertFileIsValidLink', new FileIsValidLinkConstraint());
    }

    /**
     * Asserts that a file permission matches mask, for example: '0007'.
     *
     * @param int    $permissionMask
     * @param mixed  $filename
     * @param string $message
     */
    public static function assertFilePermissionMask($permissionMask, $filename, string $message = '')
    {
        self::filePermissionMask($permissionMask, $filename, 'assertFilePermissionMask', true, $message);
    }

    /**
     * Asserts that a file permission does not matches mask, for example: '0607'.
     *
     * @param int    $permissionMask
     * @param mixed  $filename
     * @param string $message
     */
    public static function assertFilePermissionNotMask($permissionMask, $filename, string $message = '')
    {
        self::filePermissionMask($permissionMask, $filename, 'assertFilePermissionNotMask', false, $message);
    }

    /**
     * @param mixed      $input
     * @param string     $message
     * @param string     $method
     * @param Constraint $constraint
     */
    private static function assertThatConstraint($input, string $message, string $method, Constraint $constraint)
    {
        AssertHelper::assertMethodDependency(__CLASS__, __TRAIT__, $method, ['assertThat']);
        self::assertThat($input, $constraint, $message);
    }

    /**
     * @param int    $permissionMask
     * @param mixed  $filename
     * @param string $method
     * @param bool   $positive
     * @param string $message
     */
    private static function filePermissionMask($permissionMask, $filename, string $method, bool $positive, string $message = '')
    {
        if (!is_int($permissionMask)) {
            throw AssertHelper::createArgumentException(__TRAIT__, $method, 'int', $permissionMask);
        }

        $constraint = new FilePermissionsMaskConstraint($permissionMask);

        self::assertThatConstraint($filename, $message, $method, $positive ? $constraint : new LogicalNot($constraint));
    }
}
