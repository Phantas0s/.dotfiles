<?php
/**
 * Copyright (c) 2010-2017 Arne Blankerts <arne@blankerts.de>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 *   * Redistributions of source code must retain the above copyright notice,
 *     this list of conditions and the following disclaimer.
 *
 *   * Redistributions in binary form must reproduce the above copyright notice,
 *     this list of conditions and the following disclaimer in the documentation
 *     and/or other materials provided with the distribution.
 *
 *   * Neither the name of Arne Blankerts nor the names of contributors
 *     may be used to endorse or promote products derived from this software
 *     without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT  * NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER ORCONTRIBUTORS
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
 * OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 *
 * @category  PHP
 * @package   TheSeer\fDOM
 * @author    Arne Blankerts <arne@blankerts.de>
 * @copyright Arne Blankerts <arne@blankerts.de>, All rights reserved.
 * @license   http://www.opensource.org/licenses/bsd-license.php  BSD License
 * @link      http://github.com/theseer/fdomdocument
 *
 */

namespace TheSeer\fDOM {

    /**
     * fDomElement
     *
     * @category  PHP
     * @package   TheSeer\fDOM
     * @author    Arne Blankerts <arne@blankerts.de>
     * @access    public
     * @property  fDOMDocument $ownerDocument
     *
     */
    class fDOMElement extends \DOMElement {

        /**
         * @return string
         */
        public function __toString() {
            return $this->C14N();
        }

        /**
         * Forward to fDomDocument->query()
         *
         * @param string   $q               XPath to use
         * @param \DOMNode $ctx             \DOMNode to overwrite context
         * @param boolean  $registerNodeNS  Register flag pass thru
         *
         * @return \DomNodeList
         */
        public function query($q, \DOMNode $ctx = null, $registerNodeNS = true) {
            return $this->ownerDocument->query($q, $ctx ? $ctx : $this, $registerNodeNS);
        }

        /**
         * Forward to fDomDocument->queryOne()
         *
         * @param string   $q               XPath to use
         * @param \DOMNode $ctx             (optional) \DOMNode to overwrite context
         * @param boolean  $registerNodeNS  Register flag pass thru
         *
         * @return mixed
         */
        public function queryOne($q, \DOMNode $ctx = null, $registerNodeNS = true) {
            return $this->ownerDocument->queryOne($q, $ctx ? $ctx : $this, $registerNodeNS);
        }

        /**
         * Forward to fDomDocument->select()
         *
         * @param string   $selector A CSS Level 3 Selector string
         * @param \DOMNode $ctx
         * @param bool     $registerNodeNS
         *
         * @return \DOMNodeList
         */

        public function select($selector, \DOMNode $ctx = null, $registerNodeNS = true) {
            return $this->ownerDocument->select($selector, $ctx, $registerNodeNS);
        }

        /**
         * Parse and append XML String to node
         *
         * @param String $str string to process
         *
         * @return fDomDocumentFragment Reference to the created Fragment
         */
        public function appendXML($str) {
            $frag = $this->ownerDocument->createDocumentFragment();
            $frag->appendXML($str);
            $this->appendChild($frag);
            return $frag;
        }

        /**
         * Create a new element and append it
         *
         * @param string $name     Name of not element to create
         * @param string $content  Optional content to be set
         * @param bool $asTextnode Create content as textNode rather then setting nodeValue
         *
         * @return fDOMElement Reference to created fDOMElement
         */
        public function appendElement($name, $content = null, $asTextnode = FALSE) {
            $node = $this->ownerDocument->createElement($name, $content, $asTextnode);
            $this->appendChild($node);
            return $node;
        }

        /**
         * Create a new element in given namespace and append it
         *
         * @param string $ns       Namespace of node to create
         * @param string $name     Name of not element to create
         * @param string $content  Optional content to be set
         * @param bool $asTextnode Create content as textNode rather then setting nodeValue
         *
         * @return fDOMElement Reference to created fDOMElement
         */
        public function appendElementNS($ns, $name, $content = null, $asTextnode = FALSE) {
            $node = $this->ownerDocument->createElementNS($ns, $name, $content, $asTextnode);
            $this->appendChild($node);
            return $node;
        }

        /**
         * Create a new element in given namespace and append it
         *
         * @param string $prefix   Namespace prefix for node to create
         * @param string $name     Name of not element to create
         * @param string $content  Optional content to be set
         * @param bool $asTextnode Create content as textNode rather then setting nodeValue
         *
         * @return fDOMElement Reference to created fDOMElement
         */
        public function appendElementPrefix($prefix, $name, $content = null, $asTextnode = FALSE) {
            $node = $this->ownerDocument->createElementPrefix($prefix, $name, $content, $asTextnode);
            $this->appendChild($node);
            return $node;
        }

        /**
         * Create a new text node and append it
         *
         * @param string $content Text content to be added
         *
         * @return \DOMText
         */
        public function appendTextNode($content) {
            $text = $this->ownerDocument->createTextNode($content);
            $this->appendChild($text);
            return $text;
        }

        /**
         * Create a new fDOMElement
         *
         * @see fDOMDocument::createElement
         *
         * @param string $name
         * @param string $content
         * @param bool $asTextnode
         *
         * @return fDOMElement
         */
        public function createElement($name, $content = NULL, $asTextnode = FALSE) {
            return $this->ownerDocument->createElement($name, $content, $asTextnode);
        }

        /**
         * Create a new fDOMElement in namespace defined by prefix
         *
         * @see fDOMDocument::createElementPrefix
         *
         * @param string $prefix
         * @param string $name
         * @param string $content
         * @param bool $asTextNode
         *
         * @return fDOMElement
         */
        public function createElementPrefix($prefix, $name, $content = NULL, $asTextNode = FALSE) {
            return $this->ownerDocument->createElementPrefix($prefix, $name, $content, $asTextNode);
        }

        /**
         * Create a new fDOMElement within given namespace and return it
         *
         * @param string $namespace Namespace URI for node to create
         * @param string $name Name of node to create
         * @param null $content Content to set (optional)
         * @param bool $asTextNode Create content as textNode rather then setting nodeValue
         *
         * @throws fDOMException
         *
         * @return fDOMElement
         */
        public function createElementNS($namespace, $name, $content = NULL, $asTextNode = FALSE) {
            return $this->ownerDocument->createElementNS($namespace, $name, $content, $asTextNode);
        }

        /**
         * Wrapper to DomElement->getAttribute with default value option
         *
         * Note: A set but emptry attribute does NOT trigger use of the default
         *
         * @param string $attr    Attribute to access
         * @param string $default Default value to use if the attribute is not set
         *
         * @return string
         */
        public function getAttribute($attr, $default='') {
            return $this->hasAttribute($attr) ? parent::getAttribute($attr) : $default;
        }

        /**
         * Wrapper to DomElement->getAttributeNS with default value option
         *
         * Note: A set but empty attribute does NOT trigger use of the default
         *
         * @param string $ns      Namespace of attribute
         * @param string $attr    Attribute to access
         * @param string $default Default value to use if the attribute is not set
         *
         * @return string
         */
        public function getAttributeNS($ns, $attr, $default='') {
            return $this->hasAttributeNS($ns, $attr) ? parent::getAttributeNS($ns, $attr) : $default;
        }

        /**
         * Wrapper to DOMElement::setAttribute with additional entities support
         *
         * @param string  $attr          Attribute name to set
         * @param string  $value         Value to set attribute to
         * @param bool $keepEntities Flag to signale if entities should be kept
         *
         * @throws fDOMException
         *
         * @return \DOMAttr
         *
         * @see DOMElement::setAttribute()
         */
        public function setAttribute($attr, $value, $keepEntities=false) {
            if ($keepEntities === true) {
                $attrNode = $this->ownerDocument->createAttribute($attr);
                if (!$attrNode) {
                   throw new fDOMException("Setting attribute '$attr' failed.", fDOMException::SetFailedError);
                }
                $attrNode->value = $value;
                $this->appendChild($attrNode);
                return $attrNode;
            }
            return parent::setAttribute($attr, $value);
        }

        /**
         * Wrapper to namespace aware DOMElement::setAttributeNS with additional entities support
         *
         * @param string  $ns            namespace attribute should be in
         * @param string  $attr          Attribute name to set
         * @param string  $value         Value to set attribute to
         * @param bool    $keepEntities  Flag to signale if entities should be kept
         *
         * @throws fDOMException
         *
         * @return \DOMAttr|null
         * @see DOMElement::setAttribute()
         */
        public function setAttributeNS($ns, $attr, $value, $keepEntities=false) {
            if ($keepEntities === true) {
                $attrNode = $this->ownerDocument->createAttributeNS($ns, $attr);
                if (!$attrNode) {
                   throw new fDOMException("Setting attribute '$attr' failed.", fDOMException::SetFailedError);
                }
                $attrNode->value = $value;
                $this->appendChild($attrNode);
                return $attrNode;
            }
            return parent::setAttributeNS($ns, $attr, $value);
        }

        /**
         * Helper to add multiple attributes to an element
         *
         * @param array $attr Attributes to add as key-value pair
         * @param bool $keepEntities Flag wether to keep entities
         *
         * @return array List with references to created DOMAttr
         */
        public function setAttributes(array $attr, $keepEntities=false) {
            $attList = array();
            foreach($attr as $name => $value) {
               $attList[] = $this->setAttribute($name, $value, $keepEntities);
            }
            return $attList;
        }

        /**
         * Helper to add multiple attributes with the given namespace and prefix
         *
         * @param string $ns       Namespace of attribute
         * @param string $prefix   Namespace prefix for attribute to create
         * @param array  $attr     Attributes to add
         * @param bool $keepEntities Flag wether to keep entities
         *
         * @return void
         */
        public function setAttributesNS($ns, $prefix, array $attr, $keepEntities=false) {
           foreach($attr as $name => $value) {
              $this->setAttributeNS($ns, $prefix.':'.$name, $value, $keepEntities);
           }
        }

        /**
         * Helper method to get children by name
         *
         * @param string $tagName tagname to search for
         *
         * @return \DOMNodeList
         */
        public function getChildrenByTagName($tagName) {
            return $this->query("*[local-name()='$tagName']");
        }

        /**
         * Helper method to get children by name and namespace
         *
         * @param string $ns      namespace nodes have to be in
         * @param string $tagName tagname to search for
         *
         * @return \DOMNodeList
         */
        public function getChildrenByTagNameNS($ns, $tagName) {
            return $this->query("*[local-name()='$tagName' and namespace-uri()='$ns']");
        }

        /**
         * Check if the given node is in the same document
         *
         * @param \DomNode $node Node to compare with
         *
         * @return boolean true on match, false if they differ
         *
         */
        public function inSameDocument(\DomNode $node) {
            return $this->ownerDocument->inSameDocument($node);
        }

        /**
         * Wrapper to DomDocument::saveXML() with current node as context
         *
         * @return string
         */
        public function saveXML() {
            return $this->ownerDocument->saveXML($this);
        }

        /**
         * Wrapper to DomDocument::saveHTML() with current node as context
         *
         * @return string
         */
        public function saveHTML() {
            return $this->ownerDocument->saveHTML($this);
        }

    } // fDOMElement

}
