<?php

namespace WyriHaximus\CpuCoreDetector;

use Prophecy\Promise\PromiseInterface;
use React\Promise\RejectedPromise;
use WyriHaximus\CpuCoreDetector\Core\CoreCollectionInterface;
use WyriHaximus\CpuCoreDetector\Core\CountCollection;
use WyriHaximus\CpuCoreDetector\Core\CountInterface;

class DetectorCollection
{
    /**
     * @var DetectorInterface[]
     */
    protected $detectors;

    /**
     * DetectorCollection constructor.
     * @param DetectorInterface[] $detectors
     */
    public function __construct(array $detectors)
    {
        $this->detectors = $detectors;
    }

    /**
     * @param CoreCollectionInterface $possibilities
     * @return PromiseInterface
     */
    public function execute(CoreCollectionInterface $possibilities)
    {
        $promiseChain = new RejectedPromise();

        foreach ($possibilities as $possibility) {
            if (!$possibility->supportsCurrentOS()) {
                continue;
            }

            $promiseChain = $promiseChain->otherwise(function () use ($possibility) {
                return $this->tryDetectors($possibility)->then(function () use ($possibility) {
                    return $possibility;
                });
            });
        }

        return $promiseChain;
    }

    /**
     * @param CoreInterface $core
     * @return PromiseInterface
     */
    protected function tryDetectors(CoreInterface $core)
    {
        $promiseChain = new RejectedPromise();

        foreach ($this->detectors as $possibility) {
            if (!$possibility->supportsCurrentOS()) {
                continue;
            }

            $promiseChain = $promiseChain->otherwise(function () use ($core, $possibility) {
                return $possibility->execute($core->getCommandName());
            });
        }

        return $promiseChain;
    }
}
