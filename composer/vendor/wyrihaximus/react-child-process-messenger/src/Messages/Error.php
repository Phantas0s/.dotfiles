<?php

namespace WyriHaximus\React\ChildProcess\Messenger\Messages;

class Error implements \JsonSerializable, ActionableMessageInterface
{
    /**
     * @var Payload
     */
    protected $payload;

    /**
     * @param Payload $payload
     */
    public function __construct(Payload $payload)
    {
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
            'type' => 'error',
            'payload' => $this->payload,
        ];
    }

    /**
     * @param $bindTo
     * @param $source
     */
    public function handle($bindTo, $source)
    {
        $cb = function ($payload) {
            $this->emit('error', [
                $payload,
                $this,
            ]);
        };
        $cb = $cb->bindTo($bindTo);
        $cb($this->payload);
    }
}
