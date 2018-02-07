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
final class UnsignedIntConstraint extends Constraint
{
    /**
     * {@inheritdoc}
     */
    public function toString()
    {
        return 'is unsigned int';
    }

    /**
     * {@inheritdoc}
     */
    protected function matches($other)
    {
        return is_int($other) && $other >= 0;
    }
}
