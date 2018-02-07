<?php

namespace TheSeer\fDOM\Tests {

    use TheSeer\fDOM\CSS\Translator;

    class TranslatorTest extends \PHPUnit\Framework\TestCase {

        /**
         * @dataProvider provider
         */
        public function testTranslatingCssSelectorReturnsCorrectXPath($selector, $xpath) {
            $translator = new Translator();
            $this->assertEquals($xpath, $translator->translate($selector));
        }

        public function provider() {
            return array(
                array("div", '//div'),
                array("body div", '//body//div'),
                array("div p", '//div//p'),
                array("div > p", '//div/p'),
                array("div + p", '//div/following-sibling::*[1]/self::p'),
                array("div ~ p", '//div/following-sibling::p'),
                array("div[class^=exa][class$=mple]", '//div[starts-with(@class,"exa") and (substring(@class,string-length(@class)-3)=class)]'),
                array("div p a", '//div//p//a'),
                array("div, p, a", '//div|//p|//a'),
                array(".note", '//*[contains(concat(" ",normalize-space(@class)," ")," note ")]'),
                array("div.example", '//div[contains(concat(" ",normalize-space(@class)," ")," example ")]'),
                array("ul .tocline2", '//ul//*[contains(concat(" ",normalize-space(@class)," ")," tocline2 ")]'),
                array("div.example, div.note", '//div[contains(concat(" ",normalize-space(@class)," ")," example ")]|//div[contains(concat(" ",normalize-space(@class)," ")," note ")]'),
                array("#title", '//*[@id="title"]'),
                array("h1#title", '//h1[@id="title"]'),
                array("div #title", '//div//*[@id="title"]'),
                array("ul.toc li.tocline2", '//ul[contains(concat(" ",normalize-space(@class)," ")," toc ")]//li[contains(concat(" ",normalize-space(@class)," ")," tocline2 ")]'),
                array("ul.toc > li.tocline2", '//ul[contains(concat(" ",normalize-space(@class)," ")," toc ")]/li[contains(concat(" ",normalize-space(@class)," ")," tocline2 ")]'),
                array("h1#title + div > p", '//h1[@id="title"]/following-sibling::*[1]/self::div/p'),
                array("h1[id]:contains(Selectors)", '//h1[@id and (contains(string(.),"Selectors"))]'),
                array("a[href][lang][class]", '//a[@href and (@lang) and (@class)]'),
                array("div[class]", '//div[@class]'),
                array("div[class=example]", '//div[@class="example"]'),
                array("div[class^=exa]", '//div[starts-with(@class,"exa")]'),
                array("div[class$=mple]", '//div[substring(@class,string-length(@class)-3)=class]'),
                array("div[class*=e]", '//div[contains(@class,"e")]'),
                array("div[class|=dialog]", '//div[@class="dialog" or starts-with(@class,concat("dialog","-"))]'),
                array("div[class!=made_up]", '//div[not(@class) or @class!="made_up"]'),
                array("div[class~=example]", '//div[contains(concat(" ",normalize-space(@class)," "),concat(" ","example"," "))]'),
                array("div:not(.example)", '//div[not(contains(concat(" ",normalize-space(@class)," ")," example "))]'),
                array("p:contains(selectors)", '//p[contains(string(.),"selectors")]'),
                array("p:nth-child(even)", '//*[position() mod 2=0 and position()>=0]/self::p'),
                array("p:nth-child(2n)", '//*[(position()-) mod 2=0 and position()>=]/self::p'),
                array("p:nth-child(odd)", '//p[(count(preceding-sibling::*) + 1) mod 2=1]'),
                array("p:nth-child(2n+1)", '//*[(position()-1) mod 2=0 and position()>=1]/self::p'),
                array("p:nth-child(n)", '//p'),
                array("p:only-child", '//*[last()=1]/self::p'),
                array("p:last-child", '//p[not(following-sibling::*)]'),
                array("p:first-child", '//*[1]/self::p'),
                array("foo|bar", '//foo:bar')
            );
        }
    }
}
