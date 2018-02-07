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

namespace GeckoPackages\PHPUnit\Constraints\XML;

use PHPUnit\Framework\Constraint\Constraint;

/**
 * @internal
 *
 * @author SpacePossum
 */
abstract class AbstractXMLConstraint extends Constraint
{
    /**
     * @var string[]
     */
    protected $XMLConstraintErrors = [];

    /**
     * {@inheritdoc}
     */
    protected function matches($other)
    {
        if (!is_string($other)) {
            return false;
        }

        return $this->stringMatches($other);
    }

    /**
     * @param string $other
     *
     * @return bool
     */
    abstract protected function stringMatches($other);

    protected function setXMLConstraintErrors()
    {
        foreach (libxml_get_errors() as $error) {
            switch ($error->level) {
                case LIBXML_ERR_WARNING:
                    $level = 'warning ';

                    break;
                case LIBXML_ERR_ERROR:
                    $level = 'error ';

                    break;
                case LIBXML_ERR_FATAL:
                    $level = 'fatal ';

                    break;
                default:
                    $level = '';

                    break;
            }

            $this->XMLConstraintErrors[] = sprintf('[%s%s] %s (line %d, column %d).', $level, $error->code, trim($error->message), $error->line, $error->column);
        }
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

        return sprintf("%s %s.\n%s", $other, $this->toString(), implode("\n", $this->XMLConstraintErrors));
    }
}
