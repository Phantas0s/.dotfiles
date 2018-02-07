<?php

namespace WyriHaximus\React\ChildProcess\Messenger;

class ArgvEncoder
{
    public static function encode(array $argv)
    {
        return base64_encode(serialize($argv));
    }

    public static function decode($argv)
    {
        if (strlen($argv) == 0) {
            return [];
        }

        return unserialize(base64_decode($argv, true));
    }
}
