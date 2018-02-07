<?php

namespace Phine\Path\Tests;

use Phine\Path\Path;
use PHPUnit_Framework_TestCase as TestCase;

/**
 * Tests the methods for the `Phine\Path\Path` class.
 *
 * @author Kevin Herrera <kevin@herrera.io>
 */
class PathTest extends TestCase
{
    /**
     * Provides a suite of absolute and non-absolute paths for tests.
     *
     * @return array The list of paths.
     */
    public function getAbsolutePaths()
    {
        return array(
            array('/path/to/test', true),
            array('path/to/test', false),
            array('C:\\path\\to\\test', true),
            array('path\\to\\test', false),
            array('/path/../to/./test', true),
            array('C:\\path\\..\\to\\.\\test', true),
            array('http://path.com/to/test', true),
        );
    }

    /**
     * Provides a suite of canonical and non-canonical paths for tests.
     *
     * @return array The list of paths.
     */
    public function getCanonicalPaths()
    {
        $d = DIRECTORY_SEPARATOR;

        return array(
            array('path/to/./test', "path{$d}to{$d}test"),
            array('path\\to\\.\\test', "path{$d}to{$d}test"),
            array('path/to/../test', "path{$d}test"),
            array('path\\to\\..\\test', "path{$d}test"),
            array('/path/to/./test', "{$d}path{$d}to{$d}test"),
            array('C:\\path\\to\\.\\test', "C:{$d}path{$d}to{$d}test"),
            array('/path/to/../test', "{$d}path{$d}test"),
            array('C:\\path\\to\\..\\test', "C:{$d}path{$d}test"),
        );
    }

    /**
     * Provides a suite of local and non-local paths for tests.
     *
     * @return array The list of paths.
     */
    public function getLocalPaths()
    {
        return array(
            array('/path/to/test', true),
            array('path/to/test', true),
            array('C:\\path\\to\\test', true),
            array('path\\to\\test', true),
            array('http://path.com/to/test', false),
            array('//path.com/to/test', false),
            array('\\\\path\\to\\test', false),
            array('//path/to/test', false),
        );
    }

    /**
     * Provides a suite of split and non-split paths for tests.
     *
     * @return array The list of paths.
     */
    public function getSplitPaths()
    {
        return array(
            array('/path/to/test', array('', 'path', 'to', 'test')),
            array('C:\\path\\to\\test', array('C:', 'path', 'to', 'test')),
        );
    }

    /**
     * Performs a battery of tests against the `Path::canonical()` method
     * using the `getCanonicalPaths()` data provider. Any edge cases found
     * should be submitted as patch that will add a new entry to the data
     * provider.
     *
     * @dataProvider getCanonicalPaths
     *
     * @param string $input  The input path.
     * @param string $result The expected result.
     */
    public function testCanonical($input, $result)
    {
        $this->assertEquals($result, Path::canonical($input));
    }

    /**
     * Checks that a directory is recursively copied to another location. It
     * also checks to make sure that files are not overwritten if the flag is
     * disabled.
     */
    public function testCopy()
    {
        $dir = tempnam(sys_get_temp_dir(), 'path');

        unlink($dir);
        mkdir($dir);

        $this->assertEquals(1, Path::copy(__DIR__ . '/../../..', $dir));

        $this->assertFileEquals(
            __FILE__,
            $dir . '/Phine/Path/Tests/PathTest.php'
        );

        file_put_contents("$dir/Phine/Path/Tests/PathTest.php", 'test');

        $this->assertEquals(0, Path::copy(__DIR__ . '/../../..', $dir, false));

        $this->assertEquals(
            'test',
            file_get_contents($dir . '/Phine/Path/Tests/PathTest.php')
        );
    }

    /**
     * Checks that an exception is thrown if the path does not exist.
     */
    public function testCopyNotExist()
    {
        $this->setExpectedException(
            'Phine\\Path\\Exception\\PathException',
            'The path "/does/not/exist" does not exist.'
        );

        Path::copy('/does/not/exist', '/should/not/be/copied');
    }

    /**
     * Checks that the `Path::current()` method is returning the working
     * directory path from `getcwd()`. If `getcwd()` returns false, the
     * test will be skipped.
     */
    public function testCurrentGetcwd()
    {
        if (false === ($path = getcwd())) {
            $this->markTestSkipped(
                'The current working directory path could not be retrieved.'
            );
        }

        $this->assertEquals($path, Path::current());
    }

    /**
     * Checks that `Path::current()` uses the `PWD` environment variable.
     */
    public function testCurrentPwd()
    {
        $_SERVER['PWD'] = '/test';

        $this->assertEquals('/test', Path::current(true));
    }

    /**
     * Checks that `Path::current()` uses the `CD` environment variable.
     */
    public function testCurrentCd()
    {
        unset($_SERVER['PWD']);

        $_SERVER['CD'] = '/test';

        $this->assertEquals('/test', Path::current(true));
    }

    /**
     * Makes sure that an exception is thrown if the path could not be
     * retrieved from any of the sources recognized by `Path::current()`.
     * This test will bypass the `getcwd()` method and remove all used
     * environment variables.
     */
    public function testGetCurrentError()
    {
        unset($_SERVER['PWD']);
        unset($_SERVER['CD']);

        $this->setExpectedException(
            'Phine\\Path\\Exception\\PathException',
            'The current working directory path could not be found.'
        );

        Path::current(true);
    }

    /**
     * Performs a battery of tests against the `Path::isAbsolute()` method
     * using the `getAbsolutePaths()` data provider. Any edge cases found
     * should be submitted as patch that will add a new entry to the data
     * provider.
     *
     * @dataProvider getAbsolutePaths
     *
     * @param string $input  The input path.
     * @param string $result The expected result.
     */
    public function testIsAbsolute($input, $result)
    {
        $this->assertSame($result, Path::isAbsolute($input));
    }

    /**
     * Performs a battery of tests against the `Path::isLocal()` method
     * using the `getLocalPaths()` data provider. Any edge cases found
     * should be submitted as patch that will add a new entry to the data
     * provider.
     *
     * @dataProvider getLocalPaths
     *
     * @param string $input  The input path.
     * @param string $result The expected result.
     */
    public function testIsLocal($input, $result)
    {
        $this->assertSame($result, Path::isLocal($input));
    }

    /**
     * Performs a simple test on the `Path::join()` method. Due to how simple
     * it is, the method is actually just re-implemented as part of the test
     * assertion.
     */
    public function testJoin()
    {
        $this->assertEquals(
            join(DIRECTORY_SEPARATOR, array('a', 'b', 'c')),
            Path::join(array('a', 'b', 'c'))
        );
    }

    /**
     * Checks that the `Path::remove()` method properly removes any path,
     * and the contents of the directory (if appropriate).
     */
    public function testRemove()
    {
        $dir = tempnam(sys_get_temp_dir(), 'path');

        unlink($dir);
        mkdir($dir);
        touch("$dir/file");
        mkdir("$dir/sub");
        touch("$dir/sub/file");

        $this->assertSame(4, Path::remove($dir));

        $this->assertFileNotExists($dir);

        $file = tempnam(sys_get_temp_dir(), 'path');

        $this->assertSame(1, Path::remove($file));

        $this->assertFileNotExists($file);
    }

    /**
     * Performs a battery of tests against the `Path::split()` method using
     * the `getSplitPaths()` data provider. Any edge cases found should be
     * submitted as patch that will add a new entry to the data provider.
     *
     * @dataProvider getSplitPaths
     *
     * @param string $input  The input path.
     * @param string $result The expected result.
     */
    public function testSplit($input, $result)
    {
        $this->assertEquals($result, Path::split($input));
    }
}
