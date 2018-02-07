<?php

namespace WyriHaximus\React\ChildProcess\Messenger;

use React\EventLoop\LoopInterface;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Payload;

class ReturnChild implements ChildInterface
{
    /**
     * @var bool
     */
    protected $ran = false;

    protected function __construct(Messenger $messenger, LoopInterface $loop)
    {
        $messenger->registerRpc('return', function (Payload $payload) {
            return \React\Promise\resolve($payload->getPayload());
        });
        $this->ran = true;
    }

    public static function create(Messenger $messenger, LoopInterface $loop)
    {
        new static($messenger, $loop);
    }

    public function getRan()
    {
        return $this->ran;
    }
}
