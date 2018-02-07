<?php

namespace WyriHaximus\React\ChildProcess\Messenger;

use React\Promise\Deferred;

class OutstandingCall
{
    /**
     * @var string
     */
    protected $uniqid;

    /**
     * @var Deferred
     */
    protected $deferred;

    /**
     * @var callable
     */
    protected $cleanup;

    /**
     * @param string   $uniqid
     * @param callable $canceller
     */
    public function __construct($uniqid, callable $canceller = null, callable $cleanup = null)
    {
        if ($canceller !== null) {
            $canceller = \Closure::bind($canceller, $this, 'WyriHaximus\React\ChildProcess\Messenger\OutstandingCall');
        }

        $this->uniqid = $uniqid;
        $this->deferred = new Deferred($canceller);

        if (!is_callable($cleanup)) {
            $cleanup = function () {
            };
        }
        $this->cleanup = $cleanup;
    }

    /**
     * @return mixed
     */
    public function getUniqid()
    {
        return $this->uniqid;
    }

    /**
     * @return Deferred
     */
    public function getDeferred()
    {
        return $this->deferred;
    }

    /**
     * @param mixed $value
     */
    public function resolve($value)
    {
        $cleanup = $this->cleanup;
        $cleanup($this);

        return $this->deferred->resolve($value);
    }

    /**
     * @param mixed $value
     */
    public function progress($value)
    {
        $cleanup = $this->cleanup;
        $cleanup($this);

        return $this->deferred->progress($value);
    }

    /**
     * @param mixed $value
     */
    public function reject($value)
    {
        $cleanup = $this->cleanup;
        $cleanup($this);

        return $this->deferred->reject($value);
    }
}
