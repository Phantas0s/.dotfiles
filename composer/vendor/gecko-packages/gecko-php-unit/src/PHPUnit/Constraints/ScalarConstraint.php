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
final class ScalarConstraint extends Constraint
{
    const TYPE_SCALAR = 1;
    const TYPE_BOOL = 2;
    const TYPE_INT = 3;
    const TYPE_STRING = 4;
    const TYPE_FLOAT = 5;
    const TYPE_ARRAY = 6;

    private $testFunction;
    private $type;

    /**
     * @param int $type
     */
    public function __construct(int $type)
    {
        parent::__construct();

        switch ($type) {
            case self::TYPE_BOOL:
                $this->testFunction = 'is_bool';
                $this->type = 'bool';

                break;
            case self::TYPE_INT:
                $this->testFunction = 'is_int';
                $this->type = 'int';

                break;
            case self::TYPE_STRING:
                $this->testFunction = 'is_string';
                $this->type = 'string';

                break;
            case self::TYPE_FLOAT:
                $this->testFunction = 'is_float';
                $this->type = 'float';

                break;
            case self::TYPE_ARRAY:
                $this->testFunction = 'is_array';
                $this->type = 'array';

                break;
            case self::TYPE_SCALAR:
                $this->testFunction = 'is_scalar';
                $this->type = 'scalar';

                break;
            default:
                throw new \InvalidArgumentException(sprintf(
                    'Unknown ScalarConstraint type "%s" provided.',
                    is_object($type) ? get_class($type) : (null === $type ? 'null' : gettype($type).'#'.$type)
                ));
        }
    }

    /**
     * {@inheritdoc}
     */
    protected function matches($other)
    {
        $m = $this->testFunction;

        return $m($other);
    }

    /**
     * {@inheritdoc}
     */
    protected function failureDescription($other)
    {
        if (is_object($other)) {
            $input = sprintf('%s#%s', get_class($other), method_exists($other, '__toString') ? $other->__toString() : '');
        } elseif (null === $other) {
            $input = 'null';
        } else {
            $input = gettype($other).'#'.$other;
        }

        return sprintf('%s is of type %s', $input, $this->type);
    }

    /**
     * {@inheritdoc}
     */
    public function toString()
    {
        return sprintf('is of type "%s".', $this->type);
    }
}
