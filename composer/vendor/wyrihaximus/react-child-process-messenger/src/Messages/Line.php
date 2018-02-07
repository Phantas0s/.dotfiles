<?php

namespace WyriHaximus\React\ChildProcess\Messenger\Messages;

class Line implements LineInterface
{
    /**
     * @var \JsonSerializable
     */
    protected $payload;

    /**
     * @param \JsonSerializable $payload
     */
    public function __construct(\JsonSerializable $payload, array $options)
    {
        $this->payload = $payload;
    }

    /**
     * @return string
     */
    public function __toString()
    {
        return json_encode($this->payload) . LineInterface::EOL;
    }

    /**
     * @return \JsonSerializable
     */
    public function getPayload()
    {
        return $this->payload;
    }
}
