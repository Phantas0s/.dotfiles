<?php

namespace WyriHaximus\React\ChildProcess\Messenger\Messages;

interface ActionableMessageInterface
{
    /**
     * @param $bindTo
     * @param $source
     */
    public function handle($bindTo, $source);
}
