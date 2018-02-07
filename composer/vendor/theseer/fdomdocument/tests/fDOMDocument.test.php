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

    /**
     *
     * @author     Arne Blankerts <arne@blankerts.de>
     * @copyright  Arne Blankerts <arne@blankerts.de>, All rights reserved.
     */
    class fDOMDocumentTest extends \PHPUnit\Framework\TestCase {

        /**
         * @var fDOMDocument
         */
        private $dom;

        public function setUp() {
            $this->dom = new fDOMDocument();
        }

        public function testloadingXMLStringWorks() {
            $this->dom->loadXML('<?xml version="1.0" ?><test />');
            $this->assertInstanceOf('TheSeer\fDOM\fDOMElement', $this->dom->documentElement);
        }

        public function testloadingXMLFileWorks() {
            $this->dom->load(__DIR__ . '/_data/valid.xml');
            $this->assertInstanceOf('TheSeer\fDOM\fDOMElement', $this->dom->documentElement);
        }

        public function testGetDomXPathReturnsXPathObject() {
            $this->dom->loadXML('<?xml version="1.0" ?><test />');
            $this->assertInstanceOf('TheSeer\fDOM\fDOMXpath', $this->dom->getDomXPath());
        }

        /**
         * @expectedException \TheSeer\fDOM\fDOMException
         */
        public function testAttemptingToLoadAnXMLStringWithAnUndefinedEntityThrowsException() {
            $this->dom->loadXML('<?xml version="1.0" ?><root>&undefined;</root>');
        }

        /**
         * @expectedException \TheSeer\fDOM\fDOMException
         */
        public function testAttemptingToLoadAnEmptyXMLStringThrowsException() {
            $this->dom->loadXML('');
        }

        /**
         * @expectedException \TheSeer\fDOM\fDOMException
         */
        public function testAttemptingToLoadWithEmptyFilenameThrowsException() {
            $this->dom->load('');
        }

        /**
         * @expectedException \TheSeer\fDOM\fDOMException
         */
        public function testAttemptingToLoadHTMLWithAnEmptyFilenameThrowsException() {
            $this->dom->loadHTMLFile('');
        }

        /**
         * @expectedException \TheSeer\fDOM\fDOMException
         */
        public function testAttemptingToLoadHMLWithAnEmptyStringThrowsException() {
            $this->dom->loadHTML('');
        }

        /**
         * @expectedException \TheSeer\fDOM\fDOMException
         */
        public function testloadingInvalidXMLStringThrowsException() {
            $this->dom->loadXML('<?xml version="1.0" ?><broken>');
        }

        /**
         * @expectedException \TheSeer\fDOM\fDOMException
         */
        public function testTryingToLoadNonExistingFileThrowsException() {
            $this->dom->load('_does_not_exist.xml');
        }

        /**
         * @expectedException \TheSeer\fDOM\fDOMException
         */
        public function testloadingBrokenXMLFileThrowsException() {
            $this->dom->load(__DIR__ . '/_data/broken.xml');
        }

        /**
         * @expectedException \TheSeer\fDOM\fDOMException
         */
        public function testAttemptingToLoadAnXMLFileWithAnUndefinedEntityThrowsException() {
            $this->dom->load(__DIR__ . '/_data/undefentity.xml');
        }

        /**
         * @covers \TheSeer\fDOM\fDOMDocument::query
         */
        public function testQueryReturnsNodeList() {
            $this->dom->load(__DIR__ . '/_data/valid.xml');
            $list = $this->dom->query('/test');
            $this->assertInstanceOf('DomNodelist', $list);
            $this->assertEquals(1, $list->length);
        }

        /**
         * @covers \TheSeer\fDOM\fDOMDocument::queryOne
         */
        public function testQueryOneReturnsElement() {
            $this->dom->load(__DIR__ . '/_data/valid.xml');
            $node = $this->dom->queryOne('/test');
            $this->assertInstanceOf('TheSeer\fDOM\fDOMElement', $node);
        }

        public function testSaveXMLReturnsCorrectXMLString() {
            $xml = file_get_contents(__DIR__ . '/_data/valid.xml');
            $this->dom->loadXML($xml);
            $this->assertEquals($xml, $this->dom->saveXML());
        }

        /**
         * @expectedException \TheSeer\fDOM\fDOMException
         */
        public function testSaveXMLThrowsExceptionWithReferenceToNodeFromOtherDocument() {
            $dom = new fDOMDocument();
            $this->dom->saveXML($dom->createElement('foo'));
        }

        /**
         * @covers \TheSeer\fDOM\fDOMDocument::nodeList2FragMent
         */
        public function testTransformNodeListToFragmentWorks() {
            $this->dom->loadXML('<?xml version="1.0" ?><root><node1/><node2 /></root>');
            $frag = $this->dom->nodeList2Fragment($this->dom->query('/root/*'));
            $this->assertInstanceOf('TheSeer\fDOM\fDOMDocumentFragment', $frag);
            $this->assertEquals(2, $frag->childNodes->length);
        }

        public function testPrepareQueryReturnsValidXPathString() {
            $values = array('key' => 'the "value" of \'values\'');
            $xpath = '//some[@value = :key]';
            $result = $this->dom->prepareQuery($xpath, $values);
            $this->assertEquals('//some[@value = concat("the ",\'"\',"value",\'"\'," of \'values\'")]', $result);
        }

        public function testRegisteringANamespaceWithPrefixWorks() {
            $this->dom->registerNamespace('test', 'test:uri');
            $this->assertAttributeEquals(array('test' => 'test:uri'), 'prefixes', $this->dom);
        }

        /**
         * @expectedException \TheSeer\fDOM\fDOMException
         */
        public function testCreatingElementWithInvalidNameThrowsException() {
            $node = $this->dom->createElement('in valid');
        }

        public function testCreatingElementWithoutText() {
            $node = $this->dom->createElement('name');
            $this->assertInstanceOf('TheSeer\fDOM\fDOMElement', $node);
            $this->assertEquals('name', $node->nodeName);
        }

        /**
         * @covers \TheSeer\fDOM\fDOMDocument::createElementPrefix
         */
        public function testCreatingNewElementByprefix() {
            $this->dom->registerNamespace('test', 'test:uri');
            $node = $this->dom->createElementPrefix('test', 'node');
            $this->assertEquals('test:uri', $node->namespaceURI);
        }

        /**
         * @covers \TheSeer\fDOM\fDOMDocument::createElementPrefix
         * @expectedException \TheSeer\fDOM\fDOMException
         */
        public function testTryingToCreateNewElementByprefixWithUndefinedPrefixThrowsException() {
            $this->dom->createElementPrefix('test', 'node');
        }

        public function testSettingContentUnescapedForNewElementRemainsIntact() {
            $node = $this->dom->createElement('test', "test &amp; demo");
            $this->assertInstanceOf('TheSeer\fDOM\fDOMElement', $node);
            $this->assertEquals('test & demo', $node->nodeValue);
        }

        /**
         * @expectedException \TheSeer\fDOM\fDOMException
         */
        public function testSettingContentUnescapedForNewElementThrowsExceptionOnInvalidEntity() {
            $node = $this->dom->createElement('test', "test & demo");
        }

        public function testSettingContentAsTextNodeForNewElementEncodesEntities() {
            $node = $this->dom->createElement('test', "test &amp; demo", TRUE);
            $this->assertEquals('test &amp; demo', $node->nodeValue);
        }

        public function testSettingContentUnescapedForNewElementWithNamespaceRemainsIntact() {
            $node = $this->dom->createElementNS('test:uri', 'test', "test &amp; demo");
            $this->assertInstanceOf('TheSeer\fDOM\fDOMElement', $node);
            $this->assertEquals('test & demo', $node->nodeValue);
        }

        /**
         * @expectedException  \TheSeer\fDOM\fDOMException
         */
        public function testSettingContentUnescapedForNewElementWithNamespaceThrowsExceptionOnInvalidEntity() {
            $node = $this->dom->createElementNS('test:uri', 'test', "test & demo");
        }

        public function testSettingContentAsTextNodeForNewElementWithNamespaceEncodesEntities() {
            $node = $this->dom->createElementNS('test:uri', 'test', "test &amp; demo", TRUE);
            $this->assertInstanceOf('TheSeer\fDOM\fDOMElement', $node);
            $this->assertEquals('test &amp; demo', $node->nodeValue);
        }

        /**
         * @covers \TheSeer\fDOM\fDOMDocument::queryOne
         */
        public function testThatTwoNodesAreIdentifiedAsBeingInTheSameDocument() {
            $this->dom->loadXML('<?xml version="1.0" ?><root><node /></root>');
            $node = $this->dom->queryOne('//node');
            $this->assertTrue($this->dom->inSameDocument($node));
        }

        /**
         * @covers \TheSeer\fDOM\fDOMDocument::inSameDocument
         */
        public function testThatANodeFromADifferentDocumentIsNotConsideredAsInSameDocument() {
            $dom = new fDOMDocument();
            $node = $dom->createElement('foo');

            $this->dom->loadXML('<?xml version="1.0" ?><root />');
            $this->assertFalse($this->dom->documentElement->inSameDocument($node));
        }

        /**
         * @covers \TheSeer\fDOM\fDOMDocument::inSameDocument
         */
        public function testInSameDocumentWorksForDOMDocument() {
            $dom = new fDOMDocument();
            $this->assertFalse($this->dom->inSameDocument($dom));
        }

        public function testAppendElementCreatesANewNodeAndAttachesIt() {
            $node = $this->dom->appendElement('test');
            $this->assertSame($node, $this->dom->documentElement);
        }

        public function testAppendElementNSCreatesANewNodeAndAttachesIt() {
            $node = $this->dom->appendElementNS('test:uri', 'test');
            $this->assertSame($node, $this->dom->documentElement);
        }

        /**
         * @covers \TheSeer\fDOM\fDOMDocument::__clone
         */
        public function testCloningTriggersCreationOfNewDOMXPathInstance() {
            $this->dom->loadXML('<?xml version="1.0" ?><test />');
            $xp1 = $this->dom->getDOMXPath();
            $clone = clone $this->dom;
            $xp2 = $clone->getDOMXPath();
            $this->assertNotSame($xp2, $xp1);
        }

        /**
         * @covers \TheSeer\fDOM\fDOMDocument::__clone
         */
        public function testRegisteredNamespacePrefixesGetCopiedToClonedDocument() {
            $this->dom->loadXML('<?xml version="1.0" ?><foo:test xmlns:foo="test:uri" />');
            $this->dom->registerNamespace('foo', 'test:uri');

            $clone = clone $this->dom;

            $node = $clone->queryOne('//foo:test');
            $this->assertSame($clone->documentElement, $node);
        }

        /**
         * https://github.com/theseer/fDOMDocument/issues/15
         */
        public function testQueryReturnsNodeFromClonedDocument() {
            $this->dom->loadXML('<?xml version="1.0" ?><test />');
            $clone = clone $this->dom;

            $node = $clone->queryOne('/test');
            $this->assertNotSame($this->dom->documentElement, $node);

        }

        public function testCSSSelectorReturnsCorrectNodes() {
            $this->dom->load(__DIR__ . '/_data/selector.xml');
            $result = $this->dom->select('child');
            $this->assertEquals(2, $result->length);
            $this->assertEquals('child', $result->item(0)->nodeName);
            $this->assertEquals('child', $result->item(1)->nodeName);
        }

        public function testCSSSelectorHonorsContextNode() {
            $this->dom->load(__DIR__ . '/_data/selector.xml');
            $ctx = $this->dom->getElementsByTagName('child')->item(0);
            $result = $this->dom->select('child', $ctx);
            $this->assertEquals(1, $result->length);
            $this->assertEquals('child', $result->item(0)->nodeName);
            $this->assertEquals('other', $result->item(0)->getAttribute('attr'));
        }

    }

}
