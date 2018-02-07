<?php

namespace WyriHaximus\CpuCoreDetector\Core\Affinity;

use React\Promise\PromiseInterface;
use Tivie\OS\Detector;
use WyriHaximus\CpuCoreDetector\Core\AffinityInterface;

class CmdExe implements AffinityInterface
{
    /**
     * @param Detector|null $detector
     * @return bool
     */
    public function supportsCurrentOS(Detector $detector = null)
    {
        if ($detector === null) {
            $detector = new Detector();
        }
        return $detector->isWindowsLike();
    }

    /**
     * @return string
     */
    public function getCommandName()
    {
        return 'cmd.exe';
    }

    /**
     * @return PromiseInterface
     */
    public function execute($address = 0, $cmd = '')
    {
        return \React\Promise\resolve('cmd.exe /C start /affinity ' . $address . ' ' . $cmd);
    }
}
