<?php
/*
 * This file is part of the Finder Facade package.
 *
 * (c) Sebastian Bergmann <sebastian@phpunit.de>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace SebastianBergmann\FinderFacade;

class FinderFacadeTest extends \PHPUnit_Framework_TestCase
{
    protected $fixtureDir;

    protected function setUp()
    {
        $this->fixtureDir = __DIR__ . DIRECTORY_SEPARATOR . 'fixture' . DIRECTORY_SEPARATOR;
    }

    /**
     * @covers SebastianBergmann\FinderFacade\FinderFacade::__construct
     * @covers SebastianBergmann\FinderFacade\FinderFacade::findFiles
     */
    public function testFilesCanBeFoundBasedOnConstructorArguments()
    {
        $facade = new FinderFacade(
            array($this->fixtureDir, $this->fixtureDir . 'bar.phtml'),
            array('bar'),
            array('*.php'),
            array('*.fail.php')
        );

        $this->assertEquals(
            array(
                $this->fixtureDir . 'bar.phtml',
                $this->fixtureDir . 'foo' . DIRECTORY_SEPARATOR . 'bar.php'
            ),
            $facade->findFiles()
        );
    }

    /**
     * @covers SebastianBergmann\FinderFacade\FinderFacade::loadConfiguration
     */
    public function testFilesCanBeFoundBasedOnXmlConfiguration()
    {
        $facade = new FinderFacade;
        $facade->loadConfiguration($this->fixtureDir . 'test.xml');

        $this->assertEquals(
            array(
                $this->fixtureDir . 'bar.phtml',
                $this->fixtureDir . 'foo' . DIRECTORY_SEPARATOR . 'bar.php'
            ),
            $facade->findFiles()
        );
    }
}
