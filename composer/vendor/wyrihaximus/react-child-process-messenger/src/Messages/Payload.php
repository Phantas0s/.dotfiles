<?php

namespace WyriHaximus\React\ChildProcess\Messenger\Messages;

class Payload implements \JsonSerializable, \ArrayAccess
{
    /**
     * @var array
     */
    protected $payload = [];

    public function __construct(array $payload = [])
    {
        $this->payload = $payload;
    }

    /**
     * @return array
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
        return $this->payload;
    }

    public function offsetSet($offset, $value)
    {
        if (is_null($offset)) {
            $this->payload[] = $value;
        } else {
            $this->payload[$offset] = $value;
        }
    }

    public function offsetExists($offset)
    {
        return isset($this->payload[$offset]);
    }

    public function offsetUnset($offset)
    {
        unset($this->payload[$offset]);
    }

    public function offsetGet($offset)
    {
        return isset($this->payload[$offset]) ? $this->payload[$offset] : null;
    }
}
