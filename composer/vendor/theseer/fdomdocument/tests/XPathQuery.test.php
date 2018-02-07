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

namespace TheSeer\fDOM\Tests {

    use TheSeer\fDOM\XPathQuery;
    use TheSeer\fDOM\fDOMDocument;

    class XPathQueryTest extends \PHPUnit\Framework\TestCase {

        private $dom;

        protected function setUp() {
            $this->dom = new fDOMDocument();
            $this->dom->loadXML('<?xml version="1.0" ?><root attr="value" />');
        }


        public function testFindingKeysInQueryWorks() {
            $xp = new XPathQuery(':key');
            $this->assertEquals(array('key'), $xp->getKeys());
        }

        /**
         * @expectedException TheSeer\fDOM\XPathQueryException
         */
        public function testTryingToBindNonExistingKeyThrowsException() {
            $xp = new XPathQuery(':key');
            $xp->bind('other', 123);
        }

        public function testBoundValueForKeyGetsApplied() {
            $xp = new XPathQuery(':key');
            $xp->bind('key', 123);
            $this->assertEquals('"123"', $xp->generate($this->dom));
        }

        public function testAppliedValueForKeyIsUsedOnQueryAndReturnsNode() {
            $xp = new XPathQuery('//*[@attr = :key]');
            $xp->bind('key', 'value');
            $res = $xp->query($this->dom);
            $this->assertInstanceOf('\DOMNodelist', $res);
            $this->assertEquals(1, $res->length);
            $this->assertInstanceOf('\DOMNode', $res->item(0));
        }

        public function testOverwriteValueOnQuery() {
            $xp = new XPathQuery('//*[@attr = :key]');
            $xp->bind('key', 'first');
            $res = $xp->query($this->dom, array('key' => 'value'));
            $this->assertEquals(1, $res->length);
            $this->assertInstanceOf('\DOMNode', $res->item(0));
        }

        public function testAppliedValueForKeyIsUsedOnEvaluateAndReturnsNode() {
            $xp = new XPathQuery('//*[@attr = :key]');
            $xp->bind('key', 'value');
            $res = $xp->evaluate($this->dom);
            $this->assertInstanceOf('\DOMNodelist', $res);
            $this->assertEquals(1, $res->length);
            $this->assertInstanceOf('\DOMNode', $res->item(0));
        }

        public function testOverwriteValueOnEvaluate() {
            $xp = new XPathQuery('//*[@attr = :key]');
            $xp->bind('key', 'first');
            $res = $xp->evaluate($this->dom, array('key' => 'value'));
            $this->assertEquals(1, $res->length);
            $this->assertInstanceOf('\DOMNode', $res->item(0));
        }

        public function testCallToQueryOneReturnsOneNode() {
            $xp = new XPathQuery('//*[@attr]');
            $res = $xp->queryOne($this->dom);
            $this->assertInstanceOf('\DOMNode', $res);
        }

        public function testQueryCanBeRunWithStandardDomDocument() {
            $xp = new XPathQuery('/');
            $res = $xp->query(new \DomDocument());
            $this->assertInstanceOf('\DOMNodelist', $res);
        }

    }

}
