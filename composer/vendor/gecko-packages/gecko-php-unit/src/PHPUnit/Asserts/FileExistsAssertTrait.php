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

use GeckoPackages\PHPUnit\Constraints\FileExistsConstraint;
use PHPUnit\Framework\Constraint\Constraint;
use PHPUnit\Framework\Constraint\LogicalNot;

/**
 * Replaces the PHPUnit `assertFileExists` method. This assert does not pass if there is a directory rather than a file.
 *
 * Replacement for PHPUnits `assertFileExists` and `assertFileNotExists`.
 * Asserts when the filename exists and is a regular file, i.e. directories do not pass (however a symlink to a file does).<br/>
 * <sub>Note. Since this changes the default behaviour of the PHPUnit assert this has been placed in a separate trait.</sub>
 *
 * @api
 *
 * @author SpacePossum
 */
trait FileExistsAssertTrait
{
    /**
     * Assert the filename exists and is a regular file.
     *
     * @param mixed  $filename
     * @param string $message
     */
    public static function assertFileExists($filename, $message = '')
    {
        self::assertFileExisting($filename, $message, 'assertFileExists', new FileExistsConstraint());
    }

    /**
     * Assert the filename does not exists or is not a regular file.
     *
     * @param mixed  $filename
     * @param string $message
     */
    public static function assertFileNotExists($filename, $message = '')
    {
        self::assertFileExisting($filename, $message, 'assertFileNotExists', new LogicalNot(new FileExistsConstraint()));
    }

    /**
     * @param mixed      $filename
     * @param string     $message
     * @param string     $method
     * @param Constraint $constraint
     */
    private static function assertFileExisting($filename, string $message, string $method, Constraint $constraint)
    {
        AssertHelper::assertMethodDependency(__CLASS__, __TRAIT__, $method, ['assertThat']);
        self::assertThat($filename, $constraint, $message);
    }
}
