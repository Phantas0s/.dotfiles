<?php
namespace TheSeer\fDOM\CSS {

    class DollarEqualRule implements RuleInterface {

        /**
         * @param $selector
         *
         * @return string
         */
        public function apply($selector) {
            return preg_replace_callback(
                '/\[([a-zA-Z0-9\_\-]+)\$=([^\]]+)\]/',
                array($this, 'callback'),
                $selector
            );
        }

        /**
         * Build query from matches.
         *
         * @param array $matches
         *
         * @return string
         */
        private function callback(array $matches) {
            return '[substring(@' . $matches[1] . ',string-length(@' . $matches[1] . ')-' .  (strlen($matches[2]) - 3) . ')=' . $matches[1] . ']';
        }
    }

}
