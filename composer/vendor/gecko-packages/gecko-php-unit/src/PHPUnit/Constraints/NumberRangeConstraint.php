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
final class NumberRangeConstraint extends Constraint
{
    /**
     * @var int|float
     */
    private $lowerBoundary;

    /**
     * @var int|float
     */
    private $upperBoundary;

    /**
     * @var bool
     */
    private $onBoundary;

    /**
     * @param int|float $lowerBoundary
     * @param int|float $upperBoundary
     * @param bool      $onBoundary    pass if value is same as a boundary value, or false; value must be within the boundaries values
     */
    public function __construct($lowerBoundary, $upperBoundary, bool $onBoundary)
    {
        parent::__construct();

        $this->lowerBoundary = $lowerBoundary;
        $this->upperBoundary = $upperBoundary;
        $this->onBoundary = $onBoundary;
    }

    /**
     * {@inheritdoc}
     */
    public function toString()
    {
        return sprintf('is %s range', $this->onBoundary ? 'in' : 'within');
    }

    /**
     * {@inheritdoc}
     */
    protected function matches($other)
    {
        if ($this->onBoundary) {
            return $other >= $this->lowerBoundary && $other <= $this->upperBoundary;
        }

        return $other > $this->lowerBoundary && $other < $this->upperBoundary;
    }

    /**
     * {@inheritdoc}
     */
    protected function failureDescription($other)
    {
        return sprintf(
            sprintf(
                '%%%s %%s %s%%%s, %%%s%s',
                is_int($other) ? 'd' : '.3f',
                $this->onBoundary ? '[' : '(',
                is_int($this->lowerBoundary) ? 'd' : '.3f',
                is_int($this->upperBoundary) ? 'd' : '.3f',
                $this->onBoundary ? ']' : ')'
            ),
            $other,
            $this->toString(),
            $this->lowerBoundary,
            $this->upperBoundary
        );
    }
}
