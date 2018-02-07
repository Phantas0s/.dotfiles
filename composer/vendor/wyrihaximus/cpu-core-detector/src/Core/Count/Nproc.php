<?php

namespace WyriHaximus\CpuCoreDetector\Core\Count;

use React\ChildProcess\Process;
use React\EventLoop\LoopInterface;
use React\Promise\PromiseInterface;
use Tivie\OS\Detector;
use WyriHaximus\CpuCoreDetector\Core\CountInterface;
use WyriHaximus\React\ProcessOutcome;

class Nproc implements CountInterface
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
        return $detector->isUnixLike();
    }

    /**
     * @var LoopInterface
     */
    protected $loop;

    /**
     * @param LoopInterface $loop
     */
    public function __construct(LoopInterface $loop)
    {
        $this->loop = $loop;
    }

    /**
     * @return string
     */
    public function getCommandName()
    {
        return 'nproc';
    }

    /**
     * @return PromiseInterface
     */
    public function execute()
    {
        return \WyriHaximus\React\childProcessPromise(
            $this->loop,
            new Process('nproc')
        )->then(function (ProcessOutcome $outcome) {
            if ($outcome->getExitCode() == 0) {
                return \React\Promise\resolve((int) trim($outcome->getStdout()));
            }

            return \React\Promise\reject();
        });
    }
}
