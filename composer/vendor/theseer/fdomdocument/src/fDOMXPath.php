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
     * fDOMXPath extension to PHP's DOMXPath.
     *
     * @category  PHP
     * @package   TheSeer\fDOM
     * @author    Arne Blankerts <arne@blankerts.de>
     * @access    public
     *
     */
    class fDOMXPath extends \DOMXPath {

        /**
         * @var \DOMDocument
         */
        protected $doc;

        /**
         * @param \DOMDocument $doc
         */
        public function __construct(\DOMDocument $doc) {
            parent::__construct($doc);
            $this->doc = $doc;
        }

        /**
         * @param string $xpath
         * @param array $valueMap
         *
         * @return string
         */
        public function prepare($xpath, array $valueMap) {
            if (count($valueMap)==0) {
                return $xpath;
            }
            foreach($valueMap as $key => $value) {
                $xpath = str_replace(':'.$key, $this->quote($value), $xpath);
            }
            return $xpath;
        }

        /**
         * @param string $q
         * @param \DOMNode $ctx
         * @param bool $registerNodeNS
         *
         * @throws fDOMException
         *
         * @return \DOMNodeList
         */
        public function query($q, \DOMNode $ctx = null, $registerNodeNS = true) {
            libxml_clear_errors();
            if (version_compare(PHP_VERSION, '5.3.3', '<') || strpos(PHP_VERSION, 'hiphop') || strpos(PHP_VERSION, 'hhvm')) {
                $rc = parent::query($q, ($ctx instanceof \DOMNode) ? $ctx : $this->doc->documentElement);
            } else {
                $rc = parent::query($q, ($ctx instanceof \DOMNode) ? $ctx : $this->doc->documentElement, $registerNodeNS);
            }

            if (libxml_get_last_error()) {
                throw new fDOMException('evaluating xpath expression failed.', fDOMException::QueryError);
            }
            return $rc;
        }

        /**
         * @param string $q
         * @param \DOMNode $ctx
         * @param bool $registerNodeNS
         *
         * @throws fDOMException
         *
         * @return mixed
         */
        public function evaluate($q, \DOMNode $ctx = null, $registerNodeNS = true) {
            libxml_clear_errors();
            if (version_compare(PHP_VERSION, '5.3.3', '<') || strpos(PHP_VERSION, 'hiphop') || strpos(PHP_VERSION, 'hhvm')) {
                $rc = parent::evaluate($q, ($ctx instanceof \DOMNode) ? $ctx : $this->doc->documentElement);
            } else {
                $rc = parent::evaluate($q, ($ctx instanceof \DOMNode) ? $ctx : $this->doc->documentElement, $registerNodeNS);
            }
            if (libxml_get_last_error()) {
                throw new fDOMException('evaluating xpath expression failed.', fDOMException::QueryError);
            }
            return $rc;
        }

        /**
         * @param string $q
         * @param \DOMNode $ctx
         * @param bool $registerNodeNS
         *
         * @throws fDOMException
         *
         * @return \DOMNode|mixed
         */
        public function queryOne($q, \DOMNode $ctx = null, $registerNodeNS = true) {
            $rc = $this->evaluate($q, $ctx, $registerNodeNS);
            if ($rc instanceof \DOMNodelist) {
                return $rc->item(0);
            }
            return $rc;
        }

        /**
         * @param string $str
         *
         * @return string
         */
        public function quote($str) {
            if (strpos($str, '"') === false) {
                return '"'.$str.'"';
            }
            $parts = explode('"', $str);
            return 'concat("' . join('",\'"\',"', $parts).'")';
        }
    }
}
