<?php

namespace WyriHaximus\React\ChildProcess\Pool;

use WyriHaximus\React\ChildProcess\Messenger\Messages\Rpc;

interface QueueInterface
{
    /**
     * @param Rpc $rpc
     * @return void
     */
    public function enqueue(Rpc $rpc);

    /**
     * @return Rpc
     */
    public function dequeue();

    /**
     * @return int
     */
    public function count();
}
