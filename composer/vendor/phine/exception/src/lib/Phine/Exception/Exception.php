<?php

namespace Phine\Exception;

/**
 * Builds on the `Exception` class to add more features.
 *
 * @author Kevin Herrera <kevin@herrera.io>
 */
class Exception extends \Exception
{
    /**
     * Creates a new exception using a formatted message.
     *
     * A new exception is created after formatting the given arguments using
     * `vsprintf()`. If the last argument is an instance of the `Exception`
     * class, it will be used as the `$previous` exception in the new one
     * that is created.
     *
     * @param string     $format    The message format.
     * @param mixed      $value,... A value to format.
     * @param \Exception $previous  A previous exception.
     *
     * @return Exception The new exception.
     */
    public static function createUsingFormat($format)
    {
        $previous = null;

        if (1 < func_num_args()) {
            $args = array_slice(func_get_args(), 1);

            // extract $previous exception
            if (end($args) instanceof \Exception) {
                $previous = array_pop($args);
            }

            if ($args) {
                $format = vsprintf($format, $args);
            }
        }

        return new static($format, 0, $previous);
    }

    /**
     * Uses the last error message to create a new exception.
     *
     * A new exception will be created using the last error message, which is
     * returned by the `error_get_last()` function. If no error message was
     * generated, the `$default` message will be used. By default, that message
     * is "(unknown error)".
     *
     * The message `$prefix` will be added to any message that is used. The
     * prefix "My prefix: " with the error message "my error" will result in
     * "My prefix: error message" being used as the exception message.
     *
     * @param string $prefix  The message prefix.
     * @param string $default The default message.
     *
     * @return Exception The new exception.
     */
    public static function createUsingLastError (
        $prefix = null,
        $default = '(unknown error)'
    ) {
        if (null === ($error = error_get_last())) {
            $error = array('message' => $default);
        }

        return new static($prefix . $error['message']);
    }
}
