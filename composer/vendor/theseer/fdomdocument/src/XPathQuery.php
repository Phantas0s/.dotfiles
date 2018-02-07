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
     * Class XPathQuery
     *
     * @package TheSeer\fDOM
     */
    class XPathQuery {

        /**
         * @var string
         */
        private $query;

        /**
         * Key-value Map for bound values
         *
         * @var array
         */
        private $values = array();

        /**
         * @param string $query
         */
        public function __construct($query) {
            $this->setQuery($query);
        }

        /**
         * Set Query.
         *
         * @param string $query
         */
        private function setQuery($query) {
            $this->query = $query;
            $res = preg_match_all('/(:(\w*))/', $query, $matches);
            if ($res > 0) {
                $this->values = array_fill_keys($matches[2], '');
            }
        }

        /**
         * Returns keys.
         *
         * @return array
         */
        public function getKeys() {
            return array_keys($this->values);
        }

        /**
         * Bind value to key.
         *
         * @param string $key
         * @param string $value
         *
         * @throws XPathQueryException
         */
        public function bind($key, $value) {
            if (!array_key_exists($key, $this->values)) {
                throw new XPathQueryException("'$key' not found in query'", XPathQueryException::KeyNotFound );
            }
            $this->values[$key] = $value;
        }

        /**
         * Generate query.
         *
         * @param \DOMNode $ctx
         * @param array $values
         *
         * @return string
         */
        public function generate(\DOMNode $ctx, array $values = NULL) {
            return $this->buildQuery($this->getXPathObjectFor($ctx), $values);
        }

        /**
         * Evaluate Query.
         *
         * @param \DOMNode $ctx
         * @param array $values
         * @param bool $registerNodeNS
         *
         * @throws fDOMException
         *
         * @return mixed
         */
        public function evaluate(\DOMNode $ctx, array $values = NULL, $registerNodeNS = TRUE) {
            $xp = $this->getXPathObjectFor($ctx);
            return $xp->evaluate($this->buildQuery($xp, $values), $ctx, $registerNodeNS);
        }

        /**
         * Execute Query.
         *
         * @param \DOMNode $ctx
         * @param array $values
         * @param bool $registerNodeNS
         *
         * @throws fDOMException
         *
         * @return mixed
         */
        public function query(\DOMNode $ctx, array $values = NULL, $registerNodeNS = TRUE) {
            $xp = $this->getXPathObjectFor($ctx);
            return $xp->evaluate($this->buildQuery($xp, $values), $ctx, $registerNodeNS);
        }

        /**
         * Execute Query and return first result.
         *
         * @param \DOMNode $ctx
         * @param array $values
         * @param bool $registerNodeNS
         *
         * @return \DOMNode
         */
        public function queryOne(\DOMNode $ctx, array $values = NULL, $registerNodeNS = TRUE) {
            $xp = $this->getXPathObjectFor($ctx);
            return $xp->queryOne($this->buildQuery($xp, $values), $ctx, $registerNodeNS);
        }

        /**
         * Return xPath for node
         *
         * @param \DOMNode $ctx
         *
         * @throws fDOMException
         *
         * @return fDOMXPath
         */
        private function getXPathObjectFor(\DOMNode $ctx) {
            $dom = $ctx instanceof \DOMDocument ? $ctx : $ctx->ownerDocument;
            if ($dom instanceOf fDOMDocument) {
                return $dom->getDOMXPath();
            }
            return new fDOMXPath($dom);
        }

        /**
         * Build query using values.
         *
         * @param fDOMXPath $xp
         * @param array $values
         *
         * @throws XPathQueryException
         *
         * @return string
         */
        private function buildQuery(fDOMXPath $xp, array $values = NULL) {
            $backup = $this->values;
            if (is_array($values) && count($values) > 0) {
                foreach($values as $k => $v) {
                    $this->bind($k, $v);
                }
            }
            $query = $xp->prepare($this->query, $this->values);
            $this->values = $backup;
            return $query;
        }
    }

}
