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
    use TheSeer\fDOM\CSS\Translator;

    /**
     * fDOMDocument extension to PHP's DOMDocument.
     * This class adds various convenience methods to simplify APIs
     * It is set to final since further extending it would even more
     * break the Object structure after use of registerNodeClass.
     *
     * @category  PHP
     * @package   TheSeer\fDOM
     * @author    Arne Blankerts <arne@blankerts.de>
     * @access    public
     * @property  fDOMDocument $ownerDocument
     *
     */
    class fDOMDocument extends \DOMDocument {

        /**
         * XPath Object instance
         *
         * @var fDOMXPath
         */
        private $xp = NULL;

        /**
         * List of registered prefixes and their namespace uri
         * @var array
         */
        private $prefixes = array();

        /**
         * Extended DOMDocument constructor
         *
         * @param string $version       XML Version, should be 1.0
         * @param string $encoding      Encoding, defaults to utf-8
         * @param array  $streamOptions optional stream options array
         *
         * @return fDOMDocument
         */
        public function __construct($version = '1.0', $encoding = 'utf-8', $streamOptions = NULL) {
            if (!is_null($streamOptions)) {
                $this->setStreamContext($streamOptions);
            }

            libxml_use_internal_errors(TRUE);
            $rc = parent::__construct($version, $encoding);

            $this->registerNodeClasses();

            return $rc;
        }

        /**
         * Reset XPath object so the clone gets a new instance when needed
         */
        public function __clone() {
            $this->registerNodeClasses();
            $this->xp = new fDOMXPath($this);
            foreach($this->prefixes as $prefix => $uri) {
                $this->xp->registerNamespace($prefix, $uri);
            }
        }

        /**
         * @return string
         */
        public function __toString() {
            return $this->C14N();
        }

        /**
         * Set Stream context options
         *
         * @param array $options Stream context options
         *
         * @return boolean true on success, false on failure
         */
        public function setStreamContext(array $options) {
            if (!count($options)) {
                return FALSE;
            }
            $context = stream_context_create($options);
            libxml_set_streams_context($context);
            return TRUE;
        }

        /**
         * Wrapper to DOMDocument load with exception handling
         * Returns true on success to satisfy the compatibilty of the original DOM Api
         *
         * @param string  $fname   File to load
         * @param int|null $options LibXML Flags to pass
         *
         * @throws fDOMException
         *
         * @return bool|mixed
         */
        public function load($fname, $options = LIBXML_NONET) {
            if ($fname === '') {
                throw new fDOMException('empty filename is not allowed', fDOMException::ParseError);
            }
            $this->xp = NULL;
            $tmp = parent :: load($fname, $options);
            if (!$tmp || libxml_get_last_error()) {
                throw new fDOMException("loading file '$fname' failed.", fDOMException::LoadError);
            }
            $this->registerNodeClasses();
            return TRUE;
        }

        /**
         * Wrapper to DOMDocument loadXML with exception handling
         * Returns true on success to satisfy the compatibilty of the original DOM Api
         *
         * @param string  $source  XML source code
         * @param integer $options LibXML option flags
         *
         * @throws fDOMException
         *
         * @return boolean
         */
        public function loadXML($source, $options = LIBXML_NONET) {
            if ($source === '') {
                throw new fDOMException('empty string not allowed', fDOMException::ParseError);
            }
            $this->xp = NULL;
            $tmp = parent :: loadXML($source, $options);
            if (!$tmp || libxml_get_last_error()) {
                throw new fDOMException('parsing string failed', fDOMException::ParseError);
            }
            $this->registerNodeClasses();
            return TRUE;
        }

        /**
         * Wrapper to DOMDocument loadHTMLFile with exception handling.
         * Returns true on success to satisfy the compatibilty of the original DOM Api
         *
         * @param string  $fname html file to load
         * @param integer $options Options bitmask (@see DOMDocument::loadHTMLFile)
         *
         * @throws fDOMException
         *
         * @return boolean
         */
        public function loadHTMLFile($fname, $options = NULL) {
            if ($fname === '') {
                throw new fDOMException('empty filename is not allowed', fDOMException::ParseError);
            }
            $this->xp = NULL;
            if (version_compare(PHP_VERSION, '5.4.0', '<')) {
                if ($options !== NULL) {
                    throw new fDOMException('Passing options requires PHP 5.4.0+', fDOMException::LoadError);
                }
                $tmp = parent :: loadHTMLFile($fname);
            } else {
                $tmp = parent :: loadHTMLFile($fname, $options);
            }
            if (!$tmp || libxml_get_last_error()) {
                throw new fDOMException("loading html file '$fname' failed", fDOMException::LoadError);
            }
            $this->registerNodeClasses();
            return TRUE;
        }

        /**
         * Wrapper to DOMDocument loadHTML with exception handling
         * Returns true on success to satisfy the compatibilty of the original DOM Api
         *
         * @param string  $source html source code
         * @param integer $options Options bitmask (@see DOMDocument::loadHTML)
         *
         * @throws fDOMException
         *
         * @return boolean
         */
        public function loadHTML($source, $options = NULL) {
            if ($source === '') {
                throw new fDOMException('empty string not allowed', fDOMException::ParseError);
            }
            $this->xp = NULL;
            if (version_compare(PHP_VERSION, '5.4.0', '<')) {
                if ($options !== NULL) {
                    throw new fDOMException('Passing options requires PHP 5.4.0+', fDOMException::LoadError);
                }
                $tmp = parent :: loadHTML($source);
            } else {
                $tmp = parent :: loadHTML($source, $options);
            }
            if (!$tmp || libxml_get_last_error()) {
                throw new fDOMException('parsing html string failed', fDOMException::ParseError);
            }
            $this->registerNodeClasses();
            return TRUE;
        }

        /**
         * Wrapper to DOMDocument::save with exception handling
         *
         * @param string  $filename filename to save to
         * @param integer $options Options bitmask (@see DOMDocument::save)
         *
         * @throws fDOMException
         *
         * @return integer bytes saved
         */
        public function save($filename, $options = NULL) {
            $tmp = parent::save($filename, $options);
            if (!$tmp) {
                throw new fDOMException("Saving XML to file '$filename' failed", fDOMException::SaveError);
            }
            return $tmp;
        }

        /**
         * Wrapper to DOMDocument::saveHTML with exception handling
         *
         * @param \DOMNode|null $node Context DOMNode (optional)
         *
         * @throws fDOMException
         *
         * @return string html content
         */
        public function saveHTML(\DOMNode $node = NULL) {
            if (version_compare(PHP_VERSION, '5.3.6', '<') && $node !== NULL) {
                throw new fDOMException('Passing a context node requires PHP 5.3.6+', fDOMException::SaveError);
            }
            $tmp = parent::saveHTML($node);
            if (!$tmp) {
                throw new fDOMException('Serializing to HTML failed', fDOMException::SaveError);
            }
            return $tmp;
        }

        /**
         * Wrapper to DOMDocument::saveHTMLfile with exception handling
         *
         * @param string $filename filename to save to
         * @param integer $options Options bitmask (@see DOMDocument::saveHTMLFile)
         *
         * @throws fDOMException
         *
         * @return integer bytes saved
         */
        public function saveHTMLFile($filename, $options = NULL) {
            $tmp = parent::saveHTMLFile($filename, $options);
            if (!$tmp) {
                throw new fDOMException("Saving HTML to file '$filename' failed", fDOMException::SaveError);
            }
            return $tmp;
        }

        /**
         * Wrapper to DOMDocument::saveXML with exception handling
         *
         * @param \DOMNode $node    node to start serializing at
         * @param integer  $options options flags as bitmask
         *
         * @throws fDOMException
         *
         * @return string serialized XML
         */
        public function saveXML(\DOMNode $node = NULL, $options = NULL) {
            try {
                $tmp = parent::saveXML($node, $options);
                if (!$tmp) {
                    throw new fDOMException('Serializing to XML failed', fDOMException::SaveError);
                }
                return $tmp;
            } catch (\Exception $e) {
                if (!$e instanceof fDOMException) {
                    throw new fDOMException($e->getMessage(), fDOMException::SaveError, $e);
                }
                throw $e;
            }
        }

        /**
         * get Instance of DOMXPath Object for current DOM
         *
         * @throws fDOMException
         *
         * @return fDOMXPath
         */
        public function getDOMXPath() {
            if (is_null($this->xp)) {
                $this->xp = new fDOMXPath($this);
            }
            if (!$this->xp) {
                throw new fDOMException('creating DOMXPath object failed.', fDOMException::NoDOMXPath);
            }
            return $this->xp;
        }

        /**
         * Convert a given DOMNodeList into a DOMFragment
         *
         * @param \DOMNodeList $list The Nodelist to process
         * @param boolean     $move Signale if nodes are to be moved into fragment or not
         *
         * @return fDOMDocumentFragment
         */
        public function nodeList2Fragment(\DOMNodeList $list, $move=FALSE) {
            $frag = $this->createDocumentFragment();
            /** @var fDOMNode $node */
            foreach($list as $node) {
                $frag->appendChild($move ? $node : $node->cloneNode(TRUE));
            }
            return $this->ensureIntance($frag);
        }

        /**
         * Perform an xpath query
         *
         * @param String   $q   query string containing xpath
         * @param \DOMNode|null $ctx (optional) Context DOMNode
         * @param boolean  $registerNodeNS  Register flag pass through
         *
         * @return \DOMNodeList
         */
        public function query($q, \DOMNode $ctx = NULL, $registerNodeNS = TRUE) {
            if (is_null($this->xp)) {
                $this->getDOMXPath();
            }
            return $this->xp->evaluate($q, $ctx, $registerNodeNS);
        }

        /**
         * Perform an xpath query and return only the 1st match
         *
         * @param String   $q   query string containing xpath
         * @param \DOMNode  $ctx (optional) Context DOMNode
         * @param boolean  $registerNodeNS  Register flag pass thru
         *
         * @return fDOMNode
         */
        public function queryOne($q, \DOMNode $ctx = NULL, $registerNodeNS = TRUE) {
            if (is_null($this->xp)) {
                $this->getDOMXPath();
            }
            return $this->xp->queryOne($q, $ctx, $registerNodeNS);
        }

        /**
         * Forwarder to fDOMXPath's prepare method allowing for easy and secure
         * placeholder replacement comparable to sql's prepared statements
         * .
         * @param string $xpath    String containing xpath with :placeholder markup
         * @param array  $valueMap array containing keys (:placeholder) and value pairs to be quoted
         *
         * @return string
         */
        public function prepareQuery($xpath, array $valueMap) {
            if (is_null($this->xp)) {
                $this->getDOMXPath();
            }
            return $this->xp->prepare($xpath, $valueMap);
        }

        /**
         * Use a CSS Level 3 Selector string to query select nodes
         *
         * @param string   $selector A CSS Level 3 Selector string
         * @param \DOMNode $ctx
         * @param bool     $registerNodeNS
         *
         * @return \DOMNodeList
         */
        public function select($selector, \DOMNode $ctx = NULL, $registerNodeNS = TRUE) {
            $translator = new Translator();
            $xpath = $translator->translate($selector);
            if ($ctx !== NULL) {
                $xpath = '.' . $xpath;
            }
            return $this->query($xpath, $ctx, $registerNodeNS);
        }

        /**
         * Forward to DOMXPath->registerNamespace()
         *
         * @param string $prefix The prefix to use
         * @param string $uri    The uri to assign to this prefix
         *
         * @throws fDOMException
         *
         * @return void
         */
        public function registerNamespace($prefix, $uri) {
            if (is_null($this->xp)) {
                $this->getDOMXPath();
            }
            if (!$this->xp->registerNamespace($prefix, $uri)) {
                throw new fDOMException("Registering namespace '$uri' with prefix '$prefix' failed.", fDOMException::RegistrationFailed);
            }
            $this->prefixes[$prefix] = $uri;
        }

        /**
         * Forward to DOMXPath->registerPHPFunctions()
         *
         * @param mixed $restrict array of function names or string with functionname to restrict callabilty to
         *
         * @throws fDOMException
         *
         * @return void
         */
        public function registerPHPFunctions($restrict = NULL) {
            if (is_null($this->xp)) {
                $this->getDOMXPath();
            }
            $this->xp->registerPHPFunctions($restrict);
            if (libxml_get_last_error()) {
                throw new fDOMException("Registering php functions failed.", fDOMException::RegistrationFailed);
            }
        }

        /**
         * Create a new element in namespace defined by given prefix
         *
         * @param string $prefix   Namespace prefix for node to create
         * @param string $name     Name of not element to create
         * @param string $content  Optional content to be set
         * @param bool $asTextNode Create content as textNode rather then setting nodeValue
         *
         * @throws fDOMException
         *
         * @return fDOMElement Reference to created fDOMElement
         */
        public function createElementPrefix($prefix, $name, $content = NULL, $asTextNode = FALSE) {
            if (!isset($this->prefixes[$prefix])) {
                throw new fDOMException("'$prefix' not bound", fDOMException::UnboundPrefix);
            }
            return $this->createElementNS($this->prefixes[$prefix], $prefix.':'.$name, $content, $asTextNode);
        }

        /**
         * Create a new fDOMElement and return it, optionally set content
         *
         * @param string $name Name of node to create
         * @param null $content Content to set (optional)
         * @param bool $asTextnode Create content as textNode rather then setting nodeValue
         *
         * @throws fDOMException
         *
         * @return fDOMElement Reference to created fDOMElement
         */
        public function createElement($name, $content = NULL, $asTextnode = FALSE) {
            try {
                $node = parent::createElement($name);
                if (!$node) {
                    throw new fDOMException("Creating element with name '$name' failed", fDOMException::NameInvalid);
                }
                if ($content !== NULL) {
                    if ($asTextnode) {
                        $node->appendChild($this->createTextnode($content));
                    } else {
                        $node->nodeValue = $content;
                    }
                    if (libxml_get_errors()) {
                        throw new fDOMException("Setting content value failed", fDOMException::SetFailedError);
                    }
                }
                return $this->ensureIntance($node);
            } catch (\DOMException $e) {
                throw new fDOMException("Creating elemnt with name '$name' failed", 0, $e);
            }

        }

        /**
         * Create a new fDOMElement within given namespace and return it
         *
         * @param string $namespace Namespace URI for node to create
         * @param string $name Name of node to create
         * @param string $content Content to set (optional)
         * @param bool $asTextNode Create content as textNode rather then setting nodeValue
         *
         * @throws fDOMException
         *
         * @return fDOMElement
         */
        public function createElementNS($namespace, $name, $content = NULL, $asTextNode = FALSE) {
            $node = parent::createElementNS($namespace, $name);
            if (!$node) {
                throw new fDOMException("Creating element with name '$name' failed", fDOMException::NameInvalid);
            }
            if ($content !== NULL) {
                if ($asTextNode) {
                    $node->appendChild($this->createTextnode($content));
                } else {
                    $node->nodeValue = $content;
                }
                if (libxml_get_errors()) {
                    throw new fDOMException("Setting content value failed", fDOMException::SetFailedError);
                }
            }
            return $this->ensureIntance($node);
        }

        /**
         * @return fDOMDocumentFragment
         */
        public function createDocumentFragment() {
            return $this->ensureIntance(parent::createDocumentFragment());
        }

        /**
         * Check if the given node is in the same document
         *
         * @param \DOMNode $node Node to compare with
         *
         * @return boolean true on match, false if they differ
         *
         */
        public function inSameDocument(\DOMNode $node) {
            if ($node instanceof \DOMDocument) {
                return $this->isSameNode($node);
            }
            return $this->isSameNode($node->ownerDocument);
        }

        /**
         * Create a new element and append it as documentElement
         *
         * @param string $name Name of not element to create
         * @param string $content Optional content to be set
         * @param bool $asTextNode
         *
         * @return fDOMElement Reference to created fDOMElement
         */
        public function appendElement($name, $content = NULL, $asTextNode = FALSE) {
            return $this->appendChild(
                $this->createElement($name, $content, $asTextNode)
            );
        }

        /**
         * Create a new element in given namespace and append it as documentElement
         *
         * @param string $ns Namespace of node to create
         * @param string $name Name of not element to create
         * @param string $content Optional content to be set
         * @param bool $asTextNode
         *
         * @return fDOMElement Reference to created fDOMElement
         */
        public function appendElementNS($ns, $name, $content = NULL, $asTextNode = FALSE) {
            return $this->appendChild(
                $this->createElementNS($ns, $name, $content, $asTextNode)
            );
        }

        /**
         * This is a workaround for hhvm's broken registerNodeClass handling
         * (https://github.com/facebook/hhvm/issues/1848)
         *
         * @param \DOMNode $node
         *
         * @return \DOMNode
         */
        private function ensureIntance(\DOMNode $node) {
            if ($node instanceof fDOMNode || $node instanceof fDOMElement || $node instanceof fDOMDocumentFragment) {
                return $node;
            }
            return $this->importNode($node, TRUE);
        }

        /**
         * Register replacements
         *
         * Called from constructor and, as a workaround for (https://github.com/facebook/hhvm/issues/5412),
         * after load(), loadXML(), loadHTML() and loadHTMLFile()
         */
        private function registerNodeClasses() {
            $this->registerNodeClass('DOMDocument', get_called_class());
            $this->registerNodeClass('DOMNode', 'TheSeer\fDOM\fDOMNode');
            $this->registerNodeClass('DOMElement', 'TheSeer\fDOM\fDOMElement');
            $this->registerNodeClass('DOMDocumentFragment', 'TheSeer\fDOM\fDOMDocumentFragment');
        }

    } // fDOMDocument

}
