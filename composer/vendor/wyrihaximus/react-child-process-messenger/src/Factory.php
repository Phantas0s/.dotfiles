<?php

namespace WyriHaximus\React\ChildProcess\Messenger;

use React\ChildProcess\Process;
use React\EventLoop\LoopInterface;
use React\Promise\FulfilledPromise;
use React\Stream\Stream;
use React\Stream\Util;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Factory as MessengesFactory;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Payload;

class Factory
{
    const INTERVAL = 0.1;
    const TIMEOUT = 13;
    const TERMINATE_TIMEOUT = 1;
    const PROCESS_REGISTER = 'wyrihaximus.react.child-process.messenger.child.register';

    /**
     * @param  Process                         $process
     * @param  LoopInterface                   $loop
     * @param  array                           $options
     * @param  float                           $interval
     * @return \React\Promise\PromiseInterface
     */
    public static function parent(
        Process $process,
        LoopInterface $loop,
        array $options = [],
        $interval = self::INTERVAL
    ) {
        $process->start($loop, $interval);

        return \WyriHaximus\React\tickingPromise($loop, $interval, [$process, 'isRunning'])->
            then(function () use ($process, $options) {
                $messenger = new Messenger($process->stdin, $process->stdout, $process->stderr, [
                    'read_err' => 'stderr',
                    'read' => 'stdout',
                    'write' => 'stdin',
                    'callForward' => function ($name, $arguments) use ($process) {
                        return call_user_func_array([$process, $name], $arguments);
                    },
                ] + $options);

                Util::forwardEvents($process, $messenger, [
                    'exit',
                ]);

                return \React\Promise\resolve($messenger);
            })
        ;
    }

    /**
     * @param  LoopInterface $loop
     * @param  array         $options
     * @param  null          $termiteCallable
     * @return Messenger
     */
    public static function child(LoopInterface $loop, array $options = [], $termiteCallable = null)
    {
        $stdin  = new Stream(STDIN, $loop);
        $stdout = new Stream(STDOUT, $loop);
        $stderr = new Stream(STDERR, $loop);

        $messenger = new Messenger($stdin, $stdout, $stderr, [
            'read' => 'stdin',
            'write_err' => 'stderr',
            'write' => 'stdout',
        ] + $options);

        $closeNStop = function () use ($loop) {
            $loop->stop();
        };
        $stdin->on('close', $closeNStop);
        $stdout->on('close', $closeNStop);
        $stderr->on('close', $closeNStop);

        if ($termiteCallable === null) {
            $termiteCallable = function () use ($loop) {
                $loop->addTimer(
                    self::TERMINATE_TIMEOUT,
                    [
                        $loop,
                        'stop',
                    ]
                );
            };
        }

        $messenger->registerRpc(
            Messenger::TERMINATE_RPC,
            function (Payload $payload, Messenger $messenger) use ($loop, $termiteCallable) {
                $messenger->emit('terminate', [
                    $messenger,
                ]);
                $termiteCallable($payload, $messenger);

                return new FulfilledPromise([]);
            }
        );

        return $messenger;
    }

    /**
     * @param  string                          $className
     * @param  LoopInterface                   $loop
     * @param  array                           $options
     * @param  float                           $interval
     * @throws \Exception
     * @return \React\Promise\PromiseInterface
     */
    public static function parentFromClass(
        $className,
        LoopInterface $loop,
        array $options = [],
        $interval = self::INTERVAL
    ) {
        if (!is_subclass_of($className, 'WyriHaximus\React\ChildProcess\Messenger\ChildInterface')) {
            throw new \Exception('Given class doesn\'t implement ChildInterface');
        }

        $template = '%s';
        if (isset($options['cmdTemplate'])) {
            $template = $options['cmdTemplate'];
            unset($options['cmdTemplate']);
        }

        $phpBinary = PHP_BINARY . (PHP_SAPI === 'phpdbg' ? ' -qrr --' : '');
        $command = $phpBinary . ' ' . __DIR__ . DIRECTORY_SEPARATOR . 'child-process.php';
        $process = new Process(
            sprintf(
                $template,
                $command . ' ' . ArgvEncoder::encode($options)
            )
        );

        return static::parent(
            $process,
            $loop,
            $options,
            $interval
        )->then(function (Messenger $messenger) use ($className) {
            return $messenger->rpc(MessengesFactory::rpc(Factory::PROCESS_REGISTER, [
                'className' => $className,
            ]))->then(function () use ($messenger) {
                return \React\Promise\resolve($messenger);
            });
        });
    }
}
