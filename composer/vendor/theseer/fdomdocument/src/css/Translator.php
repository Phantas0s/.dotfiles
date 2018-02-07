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

namespace TheSeer\fDOM\CSS {

    /**
     * Class Translator
     *
     * The regular expressions used in this class are heavily inspired by and mostly adopted from
     * the css2xpath.js code by Andrea Giammarchi (http://code.google.com/p/css2xpath/).
     * The JavaScript version (css2xpath.js) is licensed under the MIT License
     *
     */
    class Translator {

        /**
         * @var array
         */
        private $rules;

        /**
         * @param string $selector A CSS Selector string
         *
         * @return string
         */
        public function translate($selector) {
            foreach($this->getRules() as $rule) {
                /** @var RuleInterface $rule */
                $selector = $rule->apply($selector);
            }
            return '//' . $selector;
        }

        /**
         * @return array
         */
        private function getRules() {
            if ($this->rules != NULL) {
                return $this->rules;
            }

            $this->rules = array(

                // prefix|name
                new RegexRule('/([a-zA-Z0-9\_\-\*]+)\|([a-zA-Z0-9\_\-\*]+)/', '$1:$2'),

                // add @ for attribs
                new RegexRule("/\[([^\]~\$\*\^\|\!]+)(=[^\]]+)?\]/", '[@$1$2]'),

                // multiple queries
                new RegexRule("/\s*,\s*/", '|'),

                // , + ~ >
                new RegexRule("/\s*(\+|~|>)\s*/", '$1'),

                //* ~ + >
                new RegexRule("/([a-zA-Z0-9\_\-\*])~([a-zA-Z0-9\_\-\*])/", '$1/following-sibling::$2'),
                new RegexRule("/([a-zA-Z0-9\_\-\*])\+([a-zA-Z0-9\_\-\*])/", '$1/following-sibling::*[1]/self::$2'),
                new RegexRule("/([a-zA-Z0-9\_\-\*])>([a-zA-Z0-9\_\-\*])/", '$1/$2'),

                // all unescaped stuff escaped
                new RegexRule("/\[([^=]+)=([^'|'][^\]]*)\]/", '[$1="$2"]'),

                // all descendant or self to //
                new RegexRule("/(^|[^a-zA-Z0-9\_\-\*])(#|\.)([a-zA-Z0-9\_\-]+)/", '$1*$2$3'),
                new RegexRule("/([\>\+\|\~\,\s])([a-zA-Z\*]+)/", '$1//$2'),
                new RegexRule("/\s+\/\//", '//'),

                // :first-child
                new RegexRule("/([a-zA-Z0-9\_\-\*]+):first-child/", '*[1]/self::$1'),

                // :last-child
                new RegexRule("/([a-zA-Z0-9\_\-\*]+):last-child/", '$1[not(following-sibling::*)]'),

                // :only-child
                new RegexRule("/([a-zA-Z0-9\_\-\*]+):only-child/", '*[last()=1]/self::$1'),

                // :empty
                new RegexRule("/([a-zA-Z0-9\_\-\*]+):empty/", '$1[not(*) and not(normalize-space())]'),

                // :not
                new NotRule($this),

                // :nth-child
                new NthChildRule(),

                // :contains(selectors)
                new RegexRule('/:contains\(([^\)]*)\)/', '[contains(string(.),"$1")]'),

                // |= attrib
                new RegexRule("/\[([a-zA-Z0-9\_\-]+)\|=([^\]]+)\]/", '[@$1=$2 or starts-with(@$1,concat($2,"-"))]'),

                // *= attrib
                new RegexRule("/\[([a-zA-Z0-9\_\-]+)\*=([^\]]+)\]/", '[contains(@$1,$2)]'),

                // ~= attrib
                new RegexRule("/\[([a-zA-Z0-9\_\-]+)~=([^\]]+)\]/", '[contains(concat(" ",normalize-space(@$1)," "),concat(" ",$2," "))]'),

                // ^= attrib
                new RegexRule("/\[([a-zA-Z0-9\_\-]+)\^=([^\]]+)\]/", '[starts-with(@$1,$2)]'),

                // $= attrib
                new DollarEqualRule(),

                // != attrib
                new RegexRule("/\[([a-zA-Z0-9\_\-]+)\!=([^\]]+)\]/", '[not(@$1) or @$1!=$2]'),

                // ids and classes
                new RegexRule("/#([a-zA-Z0-9\_\-]+)/", '[@id="$1"]'),
                new RegexRule("/\.([a-zA-Z0-9\_\-]+)/", '[contains(concat(" ",normalize-space(@class)," ")," $1 ")]'),

                // normalize multiple filters
                new RegexRule("/\]\[([^\]]+)/", ' and ($1)')

            );
            return $this->rules;
        }
    }

}
