<?php
/**
 * -- php-os-detector -- 
 * DetectorTest.php created at 18-12-2014
 * 
 * Copyright 2014 Estevão Soares dos Santos
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

namespace Tivie\OS;

abstract class DetectorBase extends \PHPUnit_Framework_TestCase
{
    /**
     * @var Detector
     */
    protected $os;

    public function setUp()
    {
        $this->os = new Detector();
    }

    /**
     * @covers \Tivie\OS\Detector::getFamily
     * @covers \Tivie\OS\Detector::getType
     * @covers \Tivie\OS\Detector::getKernelName
     */
    public function testGetters()
    {
        self::assertTrue(is_int($this->os->getFamily()), "getFamily() is not returning an integer (and it should)");
        self::assertTrue(is_int($this->os->getType()), "getType() is not returning an integer (and it should)");
        self::assertTrue(is_string($this->os->getKernelName()), "getKernelName() is not returning a string (and it should)");

        return $this->os;
    }
}
