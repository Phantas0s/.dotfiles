<?php
/**
 * -- php-os-detector --
 * Detector.php created at 18-12-2014
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

/**
 * Class OSDetector
 *
 * @copyright 2014 Estevão Soares dos Santos
 * @package Tivie\OS
 */
class Detector implements DetectorInterface
{
    /**
     * Canonical Kernel's name
     * @var string
     */
    protected $kernel;

    /**
     * OS Family
     * @var int
     */
    protected $family;

    /**
     * OS type constant
     * @var
     */
    protected $osConst;

    /**
     * Detect the OS this server is running on
     */
    public function __construct()
    {
        $this->kernel = strtoupper(PHP_OS);
        $this->parsePHPOS($this->kernel);
    }

    /**
     * If the Operating System is Unix Like
     * @return bool
     */
    public function isUnixLike()
    {
        return ($this->family === UNIX_FAMILY);
    }

    /**
     * If the Operating System is OSX
     * @return bool
     */
    public function isOSX()
    {
        return ($this->getType() === MACOSX);
    }

    /**
     * If the Operating System is Windows Like
     *
     * @return int
     */
    public function isWindowsLike()
    {
        return ($this->family === WINDOWS_FAMILY);
    }

    /**
     * Get the Family constant
     *
     * @return int
     */
    public function getFamily()
    {
        return $this->family;
    }

    /**
     * Get the Kernel's name as specified in uname
     *
     * @return string
     */
    public function getKernelName()
    {
        return $this->kernel;
    }

    /**
     * Get the Kernel type
     *
     * @return int
     */
    public function getType()
    {
        return $this->osConst;
    }

    protected function parsePHPOS($name, $repeat = true)
    {
        switch ($name) {

            case "WINDOWS":
            case "WINNT":
            case "WIN32":
            case "INTERIX":
            case "UWIN":
            case "UWIN-W7":
                $family  = WINDOWS_FAMILY;
                $osConst = WINDOWS;
                break;

            case "CYGWIN":
            case "CYGWIN_NT-5.1":
            case "CYGWIN_NT-6.1":
            case "CYGWIN_NT-6.1-WOW64":
                $family  = UNIX_ON_WINDOWS_FAMILY;
                $osConst = CYGWIN;
                break;

            case "MINGW":
            case "MINGW32_NT-6.1":
            case "MSYS_NT-6.1":
                $family  = UNIX_ON_WINDOWS_FAMILY;
                $osConst = MSYS;
                break;

            case "DARWIN":
                $family  = UNIX_FAMILY;
                $osConst = MACOSX;
                break;

            case "LINUX":
            case "GNU":
            case "GNU/LINUX":
                $family  = UNIX_FAMILY;
                $osConst = LINUX;
                break;

            //HP UNIX systems
            case "AIX":
                $family  = UNIX_FAMILY;
                $osConst = AIX;
                break;

            case "OS390":
            case "OS/390":
            case "OS400":
            case "OS/400":
            case "ZOS":
            case "Z/OS":
                $family  = UNIX_FAMILY;
                $osConst = ZOS;
                break;

            case "HP-UX":
                $family  = UNIX_FAMILY;
                $osConst = HP_UX;
                break;

            // SUN's UNIX systems
            case "SOLARIS":
            case "SUNOS":
                $family  = UNIX_FAMILY;
                $osConst = SUN_OS;
                break;

            // UNIX BSD Systems
            case "DRAGONFLY":
            case "OPENBSD":
            case "FREEBSD":
            case "NETBSD":
            case "GNU/KFREEBSD":
            case "GNU/FREEBSD":
            case "DEBIAN/FREEBSD":
                $family  = UNIX_FAMILY;
                $osConst = BSD;
                break;

            //Other UNIX systems
            case "MINIX":
            case "IRIX":
            case "IRIX64":
            case "OSF1":
            case "SCO_SV":
            case "ULTRIX":
            case "RELIANTUNIX-Y":
            case "SINIX-Y":
            case "UNIXWARE":
            case "SN5176":
            case "K-OS":
            case "KOS":
                $family  = UNIX_FAMILY;
                $osConst = GEN_UNIX;
                break;

            //Blackberry's Unix System
            case "QNX":
                $family  = UNIX_FAMILY;
                $osConst = QNX;
                break;

            // HAIKU
            case "BEOS":
            case "BE_OS":
            case "HAIKU":
                $family  = OTHER_FAMILY;
                $osConst = BE_OS;
                break;

            // NONSTOP
            case "NONSTOP KERNEL":
            case "NONSTOP":
                $family  = OTHER_FAMILY;
                $osConst = NONSTOP;
                break;

            default:
                $family  = 0;
                $osConst = 0;
        }

        if ($repeat && $osConst === 0) {
            $name = $this->normalizePHPOS($name);
            $this->parsePHPOS($name, false);
        }

        $this->family  = $family;
        $this->osConst = $osConst;
    }

    /**
     * This method normalizes some names for future compliance
     *
     * @param $name
     * @return string
     */
    protected function normalizePHPOS($name)
    {
        //Cygwin
        if (stripos($name, 'CYGWIN') !== false) {
            return 'CYGWIN';
        }

        //MinGW
        if (stripos($name, 'MSYS') !== false || stripos($name, 'MINGW') !== false) {
            return 'MINGW';
        }

        return $name;
    }
}
