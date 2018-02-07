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
    use TheSeer\fDOM\fDOMElement;

    /**
     *
     * @author     Arne Blankerts <arne@blankerts.de>
     * @copyright  Arne Blankerts <arne@blankerts.de>, All rights reserved.
     */
    class fDOMElementTest extends \PHPUnit\Framework\TestCase {

        /**
         * @var fDOMDocument
         */
        private $dom;

        /**
         * @var fDOMElement
         */
        private $node;

        public function setUp() {
            $this->dom = new fDOMDocument();
            $this->dom->loadXML('<?xml version="1.0" ?><root><node><child/></node><node /></root>');
            $this->node = $this->dom->documentElement;
        }

        /**
         * The query is a forwarder to the DOMDocument, so just checking if the forwarding works is enough
         */
        public function testQueryReturnsNodelist() {
            $list = $this->node->query('//node');
            $this->assertInstanceOf('DOMNodelist', $list);
            $this->assertEquals(2, $list->length);
        }

        /**
         * The query is a forwarder to the DOMDocument, so just checking if the forwarding works is enough
         */
        public function testQueryOneReturnsNode() {
            $node = $this->node->queryOne('//root');
            $this->assertSame($this->node, $node);
        }

        public function testAppendingAnXMLStringCreatesAFragment() {
            $frag = $this->node->appendXML('<append />');
            $this->assertInstanceOf('TheSeer\fDOM\fDOMDocumentFragment', $frag);
            $this->assertEquals(1, $this->node->query('count(append)'));
        }

        public function testAppendingANewElement() {
            $node = $this->node->appendElement('append', 'text');
            $this->assertInstanceOf('TheSeer\fDOM\fDOMElement', $node);
            $this->assertEquals(1, $this->node->query('count(append)'));
            $this->assertEquals('text', $node->nodeValue);
        }

        public function testAppendingANewElementAsTextNode() {
            $node = $this->node->appendElement('append', 'test & demo', true);
            $this->assertInstanceOf('TheSeer\fDOM\fDOMElement', $node);
            $this->assertEquals(1, $this->node->query('count(append)'));
            $this->assertEquals('test & demo', $node->nodeValue);
        }

        public function testAppendingANewElementWithinANamespace() {
            $node = $this->node->appendElementNS('test:uri', 'append', 'text');
            $this->dom->registerNamespace('t','test:uri');
            $this->assertInstanceOf('TheSeer\fDOM\fDOMElement', $node);
            $this->assertEquals(1, $this->node->query('count(t:append)'));
            $this->assertEquals('text', $node->nodeValue);
        }

        public function testAppendingANewElementWithinANamespaceAsTextNode() {
            $node = $this->node->appendElementNS('test:uri', 'append', 'test & demo', true);
            $this->dom->registerNamespace('t','test:uri');
            $this->assertInstanceOf('TheSeer\fDOM\fDOMElement', $node);
            $this->assertEquals(1, $this->node->query('count(t:append)'));
            $this->assertEquals('test & demo', $node->nodeValue);
        }

        public function testAppendingANewElementWithinANamespaceByPrefix() {
            $this->dom->registerNamespace('t','test:uri');
            $node = $this->node->appendElementPrefix('t', 'append', 'text');
            $this->assertInstanceOf('TheSeer\fDOM\fDOMElement', $node);
            $this->assertEquals(1, $this->node->query('count(t:append)'));
            $this->assertEquals('text', $node->nodeValue);
        }

        public function testAppendingANewElementWithinANamespaceAsTextNodeByPrefix() {
            $this->dom->registerNamespace('t','test:uri');
            $node = $this->node->appendElementPrefix('t', 'append', 'test & demo', true);
            $this->assertInstanceOf('TheSeer\fDOM\fDOMElement', $node);
            $this->assertEquals(1, $this->node->query('count(t:append)'));
            $this->assertEquals('test & demo', $node->nodeValue);
        }

        public function testAppendingATextAsTextnode() {
            $node = $this->node->appendTextNode('test & demo');
            $found = $this->node->queryOne('text()');
            $this->assertSame($node, $found);
            $this->assertEquals('test & demo', $node->nodeValue);
        }

        public function testGettingNonExistingAttributeReturnsDefaultValue() {
            $res = $this->node->getAttribute('missing','default');
            $this->assertEquals('default', $res);
        }

        public function testGettingNonExistingAttributeWithNamespaceReturnsDefaultValue() {
            $res = $this->node->getAttributeNS('some:uri', 'missing','default');
            $this->assertEquals('default', $res);
        }

        public function testSettingAttributeValueWithPlainValue() {
            $attr = $this->node->setAttribute('test', 'value');
            $this->assertTrue($this->node->hasAttribute('test'));
            $this->assertInstanceOf('DOMAttr', $attr);
            $this->assertEquals('value', $this->node->getAttribute('test'));
        }

        public function testSettingAttributeValueWithEntitiesEncodesProperly() {
            $attr = $this->node->setAttribute('test', '&amp;');
            $this->assertTrue($this->node->hasAttribute('test'));
            $this->assertInstanceOf('DOMAttr', $attr);
            $this->assertEquals('&amp;', $this->node->getAttribute('test'));
        }

        public function testSettingAttributeValueWithEntitiesAndKeepEntitiesEnabledDoesNotEncode() {
            $attr = $this->node->setAttribute('test', '&amp;', true);
            $this->assertTrue($this->node->hasAttribute('test'));
            $this->assertInstanceOf('DOMAttr', $attr);
            $this->assertEquals('&', $this->node->getAttribute('test'));
        }

        public function testSettingNamespacedAttributeValueWithPlainValue() {
            $this->node->setAttributeNS('some:uri','s:attr', 'value');
            $this->assertTrue($this->node->hasAttributeNS('some:uri','attr'));
            $this->assertEquals('value', $this->node->getAttributeNS('some:uri','attr'));
        }

        public function testSettingNamespacedAttributeValueWithEntitiesEncodesProperly() {
            $this->node->setAttributeNS('test:uri', 't:test', '&amp;');
            $this->assertTrue($this->node->hasAttributeNS('test:uri', 'test'));
            $this->assertEquals('&amp;', $this->node->getAttributeNS('test:uri','test'));
        }

        public function testSettingNamespacedAttributeValueWithEntitiesAndKeepEntitiesEnabledDoesNotEncode() {
            $attr = $this->node->setAttributeNS('test:uri', 't:test', '&amp;', true);
            $this->assertTrue($this->node->hasAttributeNS('test:uri', 'test'));
            $this->assertInstanceOf('DOMAttr', $attr);
            $this->assertEquals('&', $this->node->getAttributeNS('test:uri', 'test'));
        }

        public function testSettingMultipleAttributesFromArray() {
            $attrs = array('a1' => 'v1', 'a2' => 'v2');
            $this->node->setAttributes($attrs);
            $this->assertEquals('v1', $this->node->getAttribute('a1'));
            $this->assertEquals('v2', $this->node->getAttribute('a2'));
        }

        public function testSettingMultipleAttributesWithNamespaceFromArray() {
            $attrs = array('a1' => 'v1', 'a2' => 'v2');
            $this->node->setAttributesNS('some:uri','s', $attrs);
            $this->assertEquals('v1', $this->node->getAttributeNS('some:uri', 'a1'));
            $this->assertEquals('v2', $this->node->getAttributeNS('some:uri', 'a2'));
        }

        public function testGetChildrenByTagnameReturnsCorrectNodelist() {
            $list = $this->node->getChildrenByTagName('node');
            $this->assertInstanceOf('DOMNodeList', $list);
            $this->assertEquals(2, $list->length);
        }

        public function testGetChildrenByTagnameNSReturnsCorrectNodelist() {
            $this->dom->loadXML('<?xml version="1.0" ?><root xmlns="test:uri"><node><child/></node><node /></root>');
            $this->node = $this->dom->documentElement;
            $list = $this->node->getChildrenByTagNameNS('test:uri', 'node');
            $this->assertInstanceOf('DOMNodeList', $list);
            $this->assertEquals(2, $list->length);
        }

        public function testInSameDocumentForwardsToOwnerDocumentAndReturnsCorrectValue() {
            $rc = $this->node->inSameDocument($this->node->firstChild);
            $this->assertTrue($rc);
        }

    }

}
