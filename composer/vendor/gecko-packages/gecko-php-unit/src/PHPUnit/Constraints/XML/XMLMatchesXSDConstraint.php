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
final class XMLMatchesXSDConstraint extends AbstractXMLConstraint
{
    /**
     * @var string
     */
    private $XSD;

    /**
     * @param string $XSD
     */
    public function __construct(string $XSD)
    {
        parent::__construct();

        $this->XSD = str_replace('http://www.w3.org/2001/xml.xsd', 'file:////'.__DIR__.'/schema/xml.xsd', $XSD);
    }

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

        $dom->normalizeDocument();

        libxml_disable_entity_loader($disableEntities);
        libxml_clear_errors();

        if (false === $result = @$dom->schemaValidateSource($this->XSD)) {
            $this->setXMLConstraintErrors();
        }

        libxml_clear_errors();
        libxml_use_internal_errors($internalErrors);

        return $result;
    }

    /**
     * {@inheritdoc}
     */
    public function toString()
    {
        return 'matches XSD';
    }
}
