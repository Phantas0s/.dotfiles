<?php
namespace TheSeer\fDOM\CSS {

    class NthChildRule implements RuleInterface {

        /**
         * @param $selector
         *
         * @return string
         */
        public function apply($selector) {
            return preg_replace_callback(
                '/([a-zA-Z0-9\_\-\*]+):nth-child\(([^\)]*)\)/',
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
            switch($matches[2]){
                case 'n': {
                    return $matches[1];
                }
                case 'even': {
                    return '*[position() mod 2=0 and position()>=0]/self::' . $matches[1];
                }
                case 'odd': {
                    return $matches[1] . '[(count(preceding-sibling::*) + 1) mod 2=1]';
                }
                default: {
                    $b = !isset($matches[2]) || empty($matches[2]) ? '0' : $matches[2];
                    $b = preg_replace('/^([0-9]*)n.*?([0-9]*)$/', '$1+$2', $b);
                    $b = explode('+', $b);
                    if (!isset($b[1])) {
                        $b[1] = '0';
                    }
                    return '*[(position()-' . $b[1] . ') mod ' . $b[0] . '=0 and position()>=' . $b[1] . ']/self::' . $matches[1];
                }
            }
        }

    }

}
