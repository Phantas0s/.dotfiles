<?php
namespace TheSeer\fDOM\CSS {

    class NotRule implements RuleInterface {

        /**
         * @var Translator
         */
        private $translator;

        /**
         * @param Translator $translator
         */
        public function __construct(Translator $translator) {
            $this->translator = $translator;
        }

        /**
         * @param $selector
         *
         * @return string
         */
        public function apply($selector) {
            return preg_replace_callback(
                '/([a-zA-Z0-9\_\-\*]+):not\(([^\)]*)\)/',
                array($this, 'callback'),
                $selector
            );
        }

        /**
         * @param array $matches
         *
         * @return string
         */
        private function callback(array $matches) {
            $subresult = preg_replace(
                '/^[^\[]+\[([^\]]*)\].*$/',
                '$1',
                $this->translator->translate($matches[2])
            );
            return $matches[1] .  '[not(' . $subresult . ')]';
        }

    }

}
