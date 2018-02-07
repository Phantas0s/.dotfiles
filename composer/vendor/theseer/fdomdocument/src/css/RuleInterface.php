<?php
namespace TheSeer\fDOM\CSS {

    interface RuleInterface {

        /**
         * @param $selector
         *
         * @return string
         */
        public function apply($selector);

    }

}
