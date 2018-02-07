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

    use TheSeer\fDOM\fDOMDocument;
    use TheSeer\fDOM\fDOMDocumentFragment;

    /**
     *
     * @author     Arne Blankerts <arne@blankerts.de>
     * @copyright  Arne Blankerts <arne@blankerts.de>, All rights reserved.
     */
    class fDOMDocumentFragmentTest extends \PHPUnit\Framework\TestCase {

        /**
         * @var fDOMDocument
         */
        private $dom;

        /**
         * @var fDOMDocumentFragment
         */
        private $frag;

        public function setUp() {
            $this->dom = new fDOMDocument();
            $this->frag = $this->dom->createDocumentFragment();
        }

        public function testAppendedXMLGetsAddedAndIsParsedAsXML() {
            $this->frag->appendXML('<some />');
            $this->assertEquals('some', $this->frag->firstChild->nodeName);
        }

        /**
         * @expectedException \TheSeer\fDOM\fDOMException
         */
        public function testTryingToAppendInvalidXMLToFragmentThrowsException() {
            $this->frag->appendXML('<foo');
        }

        public function testCheckingInSameDocumentReturnsTrueOnNodeFromFragment() {
            $this->frag->appendXML('<some />');
            $this->assertTrue($this->frag->inSameDocument($this->frag->firstChild));
        }

        public function testAppendingANewElement() {
            $node = $this->frag->appendElement('append', 'text');
            $this->assertInstanceOf('TheSeer\fDOM\fDOMElement', $node);
            $this->assertEquals(1, $this->frag->query('count(append)'));
            $this->assertEquals('text', $node->nodeValue);
        }

        public function testAppendingANewElementWithinANamespace() {
            $node = $this->frag->appendElementNS('test:uri', 'append', 'text');
            $this->dom->registerNamespace('t', 'test:uri');
            $this->assertInstanceOf('TheSeer\fDOM\fDOMElement', $node);
            $this->assertEquals(1, $this->frag->query('count(t:append)'));
            $this->assertEquals('text', $node->nodeValue);
        }

        public function testAppendingANewElementWithinANamespaceByPrefix() {
            $this->dom->registerNamespace('t', 'test:uri');
            $node = $this->frag->appendElementPrefix('t', 'append', 'text');
            $this->assertInstanceOf('TheSeer\fDOM\fDOMElement', $node);
            $this->assertEquals(1, $this->frag->query('count(t:append)'));
            $this->assertEquals('text', $node->nodeValue);
        }

        public function testAppendingANewElementWithinANamespaceAsTextNodeByPrefix() {
            $this->dom->registerNamespace('t', 'test:uri');
            $node = $this->frag->appendElementPrefix('t', 'append', 'test & demo', true);
            $this->assertInstanceOf('TheSeer\fDOM\fDOMElement', $node);
            $this->assertEquals(1, $this->frag->query('count(t:append)'));
            $this->assertEquals('test & demo', $node->nodeValue);
        }

        public function testAppendingATextAsTextnode() {
            $node = $this->frag->appendTextNode('test & demo');
            $found = $this->frag->queryOne('text()');
            $this->assertSame($node, $found);
            $this->assertEquals('test & demo', $node->nodeValue);
        }

        public function testCSSSelectorReturnsCorrectNodes() {
            $node = $this->frag->appendElement('append', 'text');
            $result = $this->frag->select('append');
            $this->assertSame($node, $result->item(0));
            $this->assertEquals(1, $result->length);
        }

        public function testToStringReturnsSerializedXMLString() {
            $this->frag->appendElement('append', 'text');
            $this->assertEquals('<append>text</append>', (string)$this->frag);
        }

    }
}
