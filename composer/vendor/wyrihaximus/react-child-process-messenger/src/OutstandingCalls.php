<?php

namespace WyriHaximus\React\ChildProcess\Messenger;

class OutstandingCalls
{
    /**
     * @var OutstandingCall[]
     */
    protected $calls = [];

    /**
     * @param  callable        $canceller
     * @return OutstandingCall
     */
    public function newCall(callable $canceller = null)
    {
        $uniqid = $this->getNewUniqid();

        $this->calls[$uniqid] = new OutstandingCall($uniqid, $canceller, function (OutstandingCall $call) {
            unset($this->calls[$call->getUniqid()]);
        });

        return $this->calls[$uniqid];
    }

    /**
     * @param string $uniqid
     *
     * @return OutstandingCall
     */
    public function getCall($uniqid)
    {
        return $this->calls[$uniqid];
    }

    /**
     * @return string
     */
    protected function getNewUniqid()
    {
        do {
            $uniqid = uniqid('', true);
        } while (isset($this->calls[$uniqid]));

        return $uniqid;
    }
}
