<?php

namespace WyriHaximus\React\ChildProcess\Messenger\Messages;

class Message implements \JsonSerializable, ActionableMessageInterface
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
            'type' => 'message',
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
            $this->emit('message', [
                $payload,
                $this,
            ]);
        };
        $cb = $cb->bindTo($bindTo);
        $cb($this->payload);
    }
}
