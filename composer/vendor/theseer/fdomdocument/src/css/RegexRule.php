<?php
namespace TheSeer\fDOM\CSS {

    class RegexRule implements RuleInterface {

        /**
         * @var string
         */
        private $regex;

        /**
         * @var string
         */
        private $replacement;

        /**
         * @param string $regex
         * @param string $replacement
         */
        public function __construct($regex, $replacement) {
            $this->regex = $regex;
            $this->replacement = $replacement;
        }

        /**
         * @param $selector
         *
         * @return string
         */
        public function apply($selector) {
            return preg_replace($this->regex, $this->replacement, $selector);
        }

    }

}
