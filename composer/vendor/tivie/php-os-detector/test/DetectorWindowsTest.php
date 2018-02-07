<?php
/**
 * -- php-os-detector --
 * DetectorWindowsTest.php created at 18-12-2014
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

require_once('DetectorBase.php');

class DetectorWindowsTest extends DetectorBase
{

    public function testGetters()
    {
        return parent::testGetters();
    }

    /**
     * @depends testGetters
     */
    public function testDetection()
    {
        self::assertEquals(WINDOWS_FAMILY, $this->os->getFamily());
        self::assertEquals(WINDOWS, $this->os->getType());
        $haystack = array('WINDOWS', 'WINNT', 'WIN32');
        self::assertContains($this->os->getKernelName(), $haystack, "", true);
    }
}
