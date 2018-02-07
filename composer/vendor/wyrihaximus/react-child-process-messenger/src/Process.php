<?php

namespace WyriHaximus\React\ChildProcess\Messenger;

use React\EventLoop\LoopInterface;
use WyriHaximus\React\ChildProcess\Messenger\Factory as MessengerFactory;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Factory as MessagesFactory;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Payload;

class Process
{
    /**
     * @var LoopInterface
     */
    protected $loop;

    /**
     * @var Messenger
     */
    protected $messenger;

    /**
     * Process constructor.
     * @param LoopInterface $loop
     * @param Messenger     $messenger
     */
    protected function __construct(LoopInterface $loop, Messenger $messenger)
    {
        $this->loop = $loop;
        $this->messenger = $messenger;
        $this->messenger->registerRpc(
            MessengerFactory::PROCESS_REGISTER,
            function (Payload $payload) {
                if (!is_subclass_of($payload['className'], 'WyriHaximus\React\ChildProcess\Messenger\ChildInterface')) {
                    throw new \Exception('Given class doesn\'t implement ChildInterface');
                }

                $this->registerClass($payload['className']);
                $this->deregisterRpc();

                return \React\Promise\resolve([]);
            }
        );
    }

    /**
     * @param  LoopInterface $loop
     * @param  Messenger     $messenger
     * @return Process
     */
    public static function create(LoopInterface $loop, Messenger $messenger)
    {
        $reject = function ($exeption) use ($messenger, $loop) {
            $messenger->error(MessagesFactory::error([
                'message' => $exeption->getMessage(),
                'code' => $exeption->getCode(),
                'line' => $exeption->getLine(),
                'file' => $exeption->getFile(),
            ]));
            $loop->addTimer(1, function () use ($loop) {
                $loop->stop();
            });
        };
        try {
            return new Process($loop, $messenger);
        } catch (\Exception $exeption) {
            $reject($exeption);
        } catch (\Throwable $exeption) {
            $reject($exeption);
        }
    }

    /**
     * @param string $className
     */
    protected function registerClass($className)
    {
        call_user_func_array([
            $className,
            'create',
        ], [
            $this->messenger,
            $this->loop,
        ]);
    }

    protected function deregisterRpc()
    {
        $this->loop->futureTick(function () {
            $this->messenger->deregisterRpc(MessengerFactory::PROCESS_REGISTER);
        });
    }
}
