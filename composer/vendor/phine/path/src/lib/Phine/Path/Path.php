<?php

namespace Phine\Path;

use Phine\Exception\Exception;
use Phine\Path\Exception\PathException;

/**
 * Provides utility methods for file system paths.
 *
 * @author Kevin Herrera <kevin@herrerea.io>
 */
class Path
{
    /**
     * Canonicalizes the file system path.
     *
     * @param string $path The path to canoncalize.
     *
     * @return string The canoncalized path.
     */
    public static function canonical($path)
    {
        $path = self::split($path);
        $canon = array();

        foreach ($path as $segment) {
            if ('..' === $segment) {
                array_pop($canon);
            } elseif ('.' !== $segment) {
                $canon[] = $segment;
            }
        }

        return self::join($canon);
    }

    /**
     * Copies an existing file or directory path to a destination.
     *
     * @param string  $from      The path to copy from.
     * @param string  $to        The path to copy to.
     * @param boolean $overwrite Overwrite existing files?
     *
     * @return integer The number of files or empty directories copied.
     *
     * @throws Exception
     * @throws PathException If the path could not be copied.
     */
    public static function copy($from, $to, $overwrite = true)
    {
        if (!file_exists($from)) {
            throw PathException::createUsingFormat(
                'The path "%s" does not exist.',
                $from
            );
        }

        $count = 0;

        if (is_file($from)) {
            if (file_exists($to) && !$overwrite) {
                return $count;
            }

            if (!@copy($from, $to)) {
                throw PathException::createUsingLastError();
            }

            $count++;
        } else {
            if (!file_exists($to) && !@mkdir($to)) {
                throw PathException::createUsingLastError();
            }

            if (!($handle = @opendir($from))) {
                throw PathException::createUsingLastError();
            }

            $empty = true;

            while (false !== ($entry = readdir($handle))) {
                if (('.' === $entry) || ('..' === $entry)) {
                    continue;
                }

                $empty = false;

                $count += self::copy(
                    $from . DIRECTORY_SEPARATOR . $entry,
                    $to . DIRECTORY_SEPARATOR . $entry,
                    $overwrite
                );
            }

            if ($empty) {
                $count++;
            }

            closedir($handle);
        }

        return $count;
    }

    /**
     * Returns the current working directory path.
     *
     * The `getcwd()` function may return `false` if the parent of the current
     * working directory is not readable. To workaround this issue, this method
     * will check environment variables that may be set by the operating system
     * for the current path.
     *
     * @param boolean $env Only use the environment variables?
     *
     * @return string The current working directory path.
     *
     * @throws Exception
     * @throws PathException If the path could not be found.
     */
    public static function current($env = false)
    {
        if ($env || (false === ($cwd = getcwd()))) {
            if (isset($_SERVER['PWD'])) {
                $cwd = $_SERVER['PWD'];
            } elseif (isset($_SERVER['CD'])) {
                $cwd = $_SERVER['CD'];
            } else {
                throw new PathException('The current working directory path could not be found.');
            }
        }

        return $cwd;
    }

    /**
     * Checks if a file system path is absolute.
     *
     * @param string $path The path to check.
     *
     * @return boolean Returns `true` if absolute, `false` if not.
     */
    public static function isAbsolute($path)
    {
        return (preg_match('/^([\\\\\/]|[a-zA-Z]\:[\\\\\/])/', $path)
            || (false !== filter_var($path, FILTER_VALIDATE_URL)));
    }

    /**
     * Checks if a path is a local file system path.
     *
     * @param string $path The path to check.
     *
     * @return boolean Returns `true` if local, `false` if not.
     */
    public static function isLocal($path)
    {
        return ((false === filter_var($path, FILTER_VALIDATE_URL))
            && !preg_match('/^(?:\\\\|\/\/)/', $path));
    }

    /**
     * Joins a split file system path.
     *
     * @param array $path The split path.
     *
     * @return string The joined path.
     */
    public static function join(array $path)
    {
        return join(DIRECTORY_SEPARATOR, $path);
    }

    /**
     * Recursively removes a file system path.
     *
     * @param string $path The path to remove.
     *
     * @return integer The number of paths removed.
     *
     * @throws Exception
     * @throws PathException If the path could not be removed.
     */
    public static function remove($path)
    {
        $removed = 0;

        if (file_exists($path)) {
            if (is_dir($path)) {
                if (false === ($handle = @opendir($path))) {
                    throw PathException::createUsingLastError();
                }

                while (false !== ($item = readdir($handle))) {
                    if (('.' === $item) || ('..' === $item)) {
                        continue;
                    }

                    $removed += self::remove($path . DIRECTORY_SEPARATOR . $item);
                }

                closedir($handle);

                if (!@rmdir($path)) {
                    throw PathException::createUsingLastError();
                }
            } elseif (!@unlink($path)) {
                throw PathException::createUsingLastError();
            }

            $removed++;
        }

        return $removed;
    }

    /**
     * Splits the file system path.
     *
     * @param string $path The path to split.
     *
     * @return array The split path.
     */
    public static function split($path)
    {
        return preg_split('/[\\\\\/]+/', $path);
    }
}
