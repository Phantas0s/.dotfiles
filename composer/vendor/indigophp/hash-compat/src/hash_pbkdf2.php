<?php

if (!function_exists('hash_pbkdf2')) {
    defined('USE_MB_STRING') or define('USE_MB_STRING', function_exists('mb_strlen'));

    /**
     * hash_pbkdf2 — Generate a PBKDF2 key derivation of a supplied password
     *
     * Arguments are null by default, so an appropriate warning can be triggered
     *
     * @param string  $algo
     * @param string  $password
     * @param string  $salt
     * @param integer $iterations
     * @param integer $length
     * @param boolean $raw_output
     *
     * @link http://php.net/manual/en/function.hash-pbkdf2.php
     *
     * @return boolean
     */
    function hash_pbkdf2($algo = null, $password = null, $salt = null, $iterations = null, $length = 0, $raw_output = false)
    {
        $argc = func_num_args();

        // Check the number of arguments
        if ($argc < 4) {
            trigger_error(sprintf('hash_pbkdf2() expects at least 4 parameters, %d given', $argc), E_USER_WARNING);

            return null;
        }

        // Check if a variable is acceptable as a string
        $notStringCastable = function($var) {
            return !is_scalar($var) && !is_null($var) && !(is_object($var) && method_exists($var, '__toString'));
        };

        // Check if a variable is acceptable as an integer
        $notIntegerCastable = function($var) {
            return !is_numeric($var) && !is_null($var) && !is_bool($var);
        };


        // Check $algo type
        // Any values that can be casted to string is valid
        if ($notStringCastable($algo)) {
            trigger_error(sprintf('hash_pbkdf2() expects parameter 1 to be string, %s given', gettype($algo)), E_USER_WARNING);

            return null;
        }

        // Check $password type
        // Any values that can be casted to string is valid
        if ($notStringCastable($password)) {
            trigger_error(sprintf('hash_pbkdf2() expects parameter 2 to be string, %s given', gettype($password)), E_USER_WARNING);

            return null;
        }

        // Check $salt type
        // Any values that can be casted to string is valid
        if ($notStringCastable($salt)) {
            trigger_error(sprintf('hash_pbkdf2() expects parameter 3 to be string, %s given', gettype($salt)), E_USER_WARNING);

            return null;
        }

        // Check $iterations type
        // Any values that can be casted to integer is valid (null is evaluated to 0)
        if ($notIntegerCastable($iterations)) {
            trigger_error(sprintf('hash_pbkdf2() expects parameter 4 to be long, %s given', gettype($iterations)), E_USER_WARNING);

            return null;
        }

        // Check $length type
        // Any values that can be casted to integer is valid (null is evaluated to 0)
        if ($notIntegerCastable($length)) {
            trigger_error(sprintf('hash_pbkdf2() expects parameter 5 to be long, %s given', gettype($length)), E_USER_WARNING);

            return null;
        }

        // Check $raw_output type
        // Any values that can be casted to boolean is valid (null is evaluated to false)
        if (!is_scalar($raw_output) and !is_null($raw_output)) {
            trigger_error(sprintf('hash_pbkdf2() expects parameter 6 to be boolean, %s given', gettype($raw_output)), E_USER_WARNING);

            return null;
        }

        // Check the algorithm
        if (!in_array($algo, hash_algos(), true)) {
            trigger_error('hash_pbkdf2(): Unknown hashing algorithm: '.$algo, E_USER_WARNING);

            return false;
        }

        // Ensures raw binary string length returned
        $strlen = function($string) {
            if (USE_MB_STRING) {
                return mb_strlen($string, '8bit');
            }

            return strlen($string);
        };

        // Check salt length
        // @codeCoverageIgnoreStart
        if ($salt_len = $strlen($salt) > PHP_INT_MAX - 4) {
            trigger_error(sprintf('hash_pbkdf2(): Supplied salt is too long, max of PHP_INT_MAX - 4 bytes: %d supplied', $salt_len), E_USER_WARNING);

            return false;
        }
        // @codeCoverageIgnoreEnd

        // Check $iterations is a positive integer
        if ($iterations < 1) {
            trigger_error('hash_pbkdf2(): Iterations must be a positive integer: ' . (int) $iterations, E_USER_WARNING);

            return false;
        }

        // Check $length is greater than or equal to 0 and integer
        if ($length < 0) {
            trigger_error('hash_pbkdf2(): Length must be greater than or equal to 0: ' . (int) $length, E_USER_WARNING);

            return false;
        }

        // Type casting
        $algo = (string) $algo;
        $password = (string) $password;
        $salt = (string) $salt;
        $iterations = (int) $iterations;
        $length = (int) $length;
        $raw_output = (bool) $raw_output;

        $hash_length = $strlen(hash($algo, null, true));

        if ($length == 0) {
            $length = $raw_output ? $hash_length : $hash_length * 2;
        }

        $digest_length = $length;

        if (!$raw_output) {
            $digest_length = ceil($digest_length / 2);
        }

        $block_count = ceil($digest_length / $hash_length);
        $hash = '';

        for ($i = 1; $i <= $block_count; $i++) {
            $key = $digest = hash_hmac($algo, $salt . pack('N', $i), $password, true);

            for ($j = 1; $j < $iterations; $j++) {
                $digest ^= $key = hash_hmac($algo, $key, $password, true);
            }

            $hash .= $digest;
        }

        // Built-in function returns the length of string, not the length of bytes (not RFC compatible)
        return substr($raw_output ? $hash : bin2hex($hash), 0, $length);
    }
}
