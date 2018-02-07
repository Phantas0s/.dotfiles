<?php

namespace WyriHaximus\CpuCoreDetector\Detector;

use React\ChildProcess\Process;
use React\EventLoop\LoopInterface;
use React\Promise\PromiseInterface;
use Tivie\OS\Detector;
use WyriHaximus\CpuCoreDetector\DetectorInterface;
use WyriHaximus\React\ProcessOutcome;

class Hash implements DetectorInterface
{
    /**
     * @return array
     */
    public function supportsCurrentOS(Detector $detector = null)
    {
        if ($detector === null) {
            $detector = new Detector();
        }
        return $detector->isUnixLike();
    }

    /**
     * @var LoopInterface
     */
    protected $loop;

    /**
     * Hash constructor.
     * @param LoopInterface $loop
     */
    public function __construct(LoopInterface $loop)
    {
        $this->loop = $loop;
    }

    /**
     * @param string $program
     * @return PromiseInterface
     */
    public function execute($program = '')
    {
        return \WyriHaximus\React\childProcessPromise(
            $this->loop,
            new Process('hash ' . $program)
        )->then(function (ProcessOutcome $outcome) {
            if ($outcome->getExitCode() == 0) {
                return \React\Promise\resolve();
            }

            return \React\Promise\reject();
        });
    }
}
