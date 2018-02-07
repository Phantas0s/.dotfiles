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
    use TheSeer\fDOM\fDOMXPath;

    /**
     *
     * @author     Arne Blankerts <arne@blankerts.de>
     * @copyright  Arne Blankerts <arne@blankerts.de>, All rights reserved.
     */
    class fDOMXPathTest extends \PHPUnit\Framework\TestCase {

        /**
         * @var TheSeer\fDOM\fDOMDocument
         */
        private $dom;

        /**
         * @var TheSeer\fDOM\fDOMXPath
         */
        private $xp;

        public function setUp() {
            $this->dom = new fDOMDocument();
            $this->dom->loadXML('<?xml version="1.0" ?><root><node attr="foo" /></root>');
            $this->xp = $this->dom->getDOMXPath();
        }

        /**
         * @covers TheSeer\fDOM\fDOMXPath::query
         * @expectedException TheSeer\fDOM\fDOMException
         */
        public function testExecutingAQueryWithInvalidXPathThrowsException() {
            $this->xp->query('//[invalid');
        }

        public function testQueryReturnsNodeList() {
            $res = $this->xp->query('//*');
            $this->assertInstanceOf('DOMNodeList', $res);
            $this->assertEquals(2, $res->length);
        }

        /**
         * @covers TheSeer\fDOM\fDOMXPath::evaluate
         * @expectedException TheSeer\fDOM\fDOMException
         */
        public function testExecutingAQueryWithEvaluateWithInvalidXPathThrowsException() {
            $this->xp->evaluate('//[invalid');
        }

        /**
         * @covers TheSeer\fDOM\fDOMXPath::quote
         */
        public function testPrepareReturnsStraightStringOnPlainText() {
            $this->assertEquals('"test"', $this->xp->quote('test'));
        }

        public function testQueryOneReturnsANode() {
            $this->assertSame($this->dom->documentElement, $this->xp->queryOne('//root'));
        }

        public function testPrepareReturnsUnmodifiedXPathOnEmptyArray() {
            $xpath = 'test';
            $this->assertEquals($xpath, $this->xp->prepare($xpath, array()));
        }

        public function testQueryOneReturnsValueOnNonNodeQuery() {
            $this->assertEquals('1', $this->xp->queryOne('count(//root)'));
        }

    }

}
