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
     * fDomNode
     *
     * @category  PHP
     * @package   TheSeer\fDOM
     * @author    Arne Blankerts <arne@blankerts.de>
     * @access    public
     * @property  fDOMDocument $ownerDocument
     *
     */
    class fDOMNode extends \DOMNode {

        /**
         * @return string
         */
        public function __toString() {
            return $this->C14N();
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
         * Check if the given node is in the same document
         *
         * @param \DomNode $node Node to compare with
         *
         * @return boolean true on match, false if they differ
         *
         */
        public function inSameDocument(\DOMNode $node) {
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



    } // fDOMNode

}
