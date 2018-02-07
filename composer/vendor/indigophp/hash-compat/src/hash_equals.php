<?php

if (!function_exists('hash_equals')) {
    defined('USE_MB_STRING') or define('USE_MB_STRING', function_exists('mb_strlen'));

    /**
     * hash_equals — Timing attack safe string comparison
     *
     * Arguments are null by default, so an appropriate warning can be triggered
     *
     * @param string $known_string
     * @param string $user_string
     *
     * @link http://php.net/manual/en/function.hash-equals.php
     *
     * @return boolean
     */
    function hash_equals($known_string = null, $user_string = null)
    {
        $argc = func_num_args();

        // Check the number of arguments
        if ($argc < 2) {
            trigger_error(sprintf('hash_equals() expects exactly 2 parameters, %d given', $argc), E_USER_WARNING);

            return null;
        }

        // Check $known_string type
        if (!is_string($known_string)) {
            trigger_error(sprintf('hash_equals(): Expected known_string to be a string, %s given', strtolower(gettype($known_string))), E_USER_WARNING);

            return false;
        }

        // Check $user_string type
        if (!is_string($user_string)) {
            trigger_error(sprintf('hash_equals(): Expected user_string to be a string, %s given', strtolower(gettype($user_string))), E_USER_WARNING);

            return false;
        }

        // Ensures raw binary string length returned
        $strlen = function($string) {
            if (USE_MB_STRING) {
                return mb_strlen($string, '8bit');
            }

            return strlen($string);
        };

        // Compare string lengths
        if (($length = $strlen($known_string)) !== $strlen($user_string)) {
            return false;
        }

        $diff = 0;

        // Calculate differences
        for ($i = 0; $i < $length; $i++) {
            $diff |= ord($known_string[$i]) ^ ord($user_string[$i]);
        }

        return $diff === 0;
    }
}
