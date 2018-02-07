<?php

namespace WyriHaximus\React\ChildProcess\Messenger\Messages;

class RpcNotify implements \JsonSerializable, ActionableMessageInterface
{
    /**
     * @var string
     */
    protected $uniqid;

    /**
     * @var Payload
     */
    protected $payload;

    /**
     * @param string  $uniqid
     * @param Payload $payload
     */
    public function __construct($uniqid, Payload $payload)
    {
        $this->uniqid = $uniqid;
        $this->payload = $payload;
    }

    /**
     * @return Payload
     */
    public function getPayload()
    {
        return $this->payload;
    }

    /**
     * @return string
     */
    public function jsonSerialize()
    {
        return [
            'type' => 'rpc_notify',
            'uniqid' => $this->uniqid,
            'payload' => $this->payload,
        ];
    }

    /**
     * @param $bindTo
     * @param $source
     */
    public function handle($bindTo, $source)
    {
        $cb = function ($payload, $uniqid) {
            $this->getOutstandingCall($uniqid)->progress($payload);
        };
        $cb = $cb->bindTo($bindTo);
        $cb($this->payload, $this->uniqid);
    }
}
