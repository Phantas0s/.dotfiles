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

/**
 * @api
 *
 * @author SpacePossum
 */
final class XMLValidConstraint extends AbstractXMLConstraint
{
    /**
     * {@inheritdoc}
     */
    protected function stringMatches($other)
    {
        $internalErrors = libxml_use_internal_errors(true);
        $disableEntities = libxml_disable_entity_loader(true);
        libxml_clear_errors();

        $dom = new \DOMDocument();
        $dom->preserveWhiteSpace = false;
        $dom->validateOnParse = true;
        if (!@$dom->loadXML($other, LIBXML_NONET | (defined('LIBXML_COMPACT') ? LIBXML_COMPACT : 0))) {
            libxml_disable_entity_loader($disableEntities);
            $this->setXMLConstraintErrors();
            libxml_clear_errors();
            libxml_use_internal_errors($internalErrors);

            return false;
        }

        libxml_disable_entity_loader($disableEntities);
        libxml_clear_errors();

        return true;
    }

    /**
     * {@inheritdoc}
     */
    public function toString()
    {
        return 'is valid XML';
    }
}
