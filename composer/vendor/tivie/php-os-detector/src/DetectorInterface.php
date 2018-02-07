<?php
/**
 * -- php-os-detector --
 * DetectorInterface.php created at 18-12-2014
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

const OTHER_FAMILY                 = 0;
const UNIX_FAMILY                  = 1;
const WINDOWS_FAMILY               = 2;
const UNIX_ON_WINDOWS_FAMILY       = 4;

const WINDOWS                      = 10;    //     8 + 2
const GEN_UNIX                     = 17;    //    16 + 2
const MACOSX                       = 33;    //    32 + 1
const LINUX                        = 65;    //    64 + 1
const MSYS                         = 129;   //   128 + 1
const CYGWIN                       = 257;   //   256 + 1
const SUN_OS                       = 513;   //   512 + 1
const NONSTOP                      = 1024;  //  1024 + 0
const QNX                          = 2049;  //  2048 + 1
const BSD                          = 4097;  //  4096 + 1
const BE_OS                        = 8192;  //  8192 + 0
const HP_UX                        = 16385; // 16384 + 1
const ZOS                          = 32769; // 32768 + 1
const AIX                          = 65537; // 65536 + 1

/**
 * Interface DetectorInterface
 * @package Tivie\OS
 * @copyright 2014 Estevão Soares dos Santos
 */
interface DetectorInterface
{
    /**
     * If the Operating System is Unix Like
     * @return bool
     */
    public function isUnixLike();

    /**
     * If the Operating System is Windows Like
     *
     * @return int
     */
    public function isWindowsLike();

    /**
     * Get the Family constant
     *
     * @return int
     */
    public function getFamily();

    /**
     * Get the Kernel's name as specified in uname
     *
     * @return string
     */
    public function getKernelName();

    /**
     * Get the Kernel type
     *
     * @return int
     */
    public function getType();
}
