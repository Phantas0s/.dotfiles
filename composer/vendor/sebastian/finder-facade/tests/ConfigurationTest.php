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

class ConfigurationTest extends \PHPUnit_Framework_TestCase
{
    protected $fixtureDir;

    protected function setUp()
    {
        $this->fixtureDir = __DIR__ . DIRECTORY_SEPARATOR . 'fixture' . DIRECTORY_SEPARATOR;
    }

    /**
     * @covers SebastianBergmann\FinderFacade\Configuration::__construct
     * @covers SebastianBergmann\FinderFacade\Configuration::parse
     * @covers SebastianBergmann\FinderFacade\Configuration::toAbsolutePath
     */
    public function testXmlFileCanBeParsed()
    {
        $configuration = new Configuration($this->fixtureDir . 'test.xml');

        $this->assertEquals(
            array(
                'items' => array(
                    $this->fixtureDir . 'foo',
                    $this->fixtureDir . 'bar.phtml'
                ),
                'excludes'                  => array('bar'),
                'names'                     => array('*.php'),
                'notNames'                  => array('*.fail.php'),
                'regularExpressionExcludes' => array()
            ),
            $configuration->parse()
        );
    }
}
