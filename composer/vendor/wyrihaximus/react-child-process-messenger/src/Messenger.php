<?php

namespace WyriHaximus\React\ChildProcess\Messenger;

use Evenement\EventEmitter;
use React\Promise\PromiseInterface;
use React\Promise\RejectedPromise;
use React\Stream\Stream;
use WyriHaximus\React\ChildProcess\Messenger\Messages\ActionableMessageInterface;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Error;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Factory as MessageFactory;
use WyriHaximus\React\ChildProcess\Messenger\Messages\LineInterface;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Message;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Rpc;

class Messenger extends EventEmitter
{
    const INTERVAL = 0.1;
    const TERMINATE_RPC = 'wyrihaximus.react.child-process.messenger.terminate';

    /**
     * @var Stream
     */
    protected $stdin;

    /**
     * @var Stream
     */
    protected $stdout;

    /**
     * @var Stream
     */
    protected $stderr;

    /**
     * @var OutstandingCalls
     */
    protected $outstandingRpcCalls;

    /**
     * @var array
     */
    protected $rpcs = [];

    /**
     * @var array
     */
    protected $options = [];

    /**
     * @var string[]
     */
    protected $buffers = [
        'stdin' => '',
        'stdout' => '',
        'stderr' => '',
    ];

    protected $defaultOptions = [
        'lineClass' => 'WyriHaximus\React\ChildProcess\Messenger\Messages\Line',
        'messageFactoryClass' => 'WyriHaximus\React\ChildProcess\Messenger\Messages\Factory',
        'lineOptions' => [],
    ];

    /**
     * @param Stream $stdin
     * @param Stream $stdout
     * @param Stream $stderr
     * @param array  $options
     */
    public function __construct(Stream $stdin, Stream $stdout, Stream $stderr, array $options)
    {
        $this->stdin  = $stdin;
        $this->stdout = $stdout;
        $this->stderr = $stderr;
        $this->options = $this->defaultOptions + $options;

        $this->outstandingRpcCalls = new OutstandingCalls();

        $this->attachMessenger();
    }

    /**
     * Forward any unknown calls when there is a call forward possible.
     *
     * @param string $name
     * @param array  $arguments
     *
     * @return mixed
     */
    public function __call($name, array $arguments)
    {
        if (isset($this->options['callForward'])) {
            $call = $this->options['callForward'];

            return $call($name, $arguments);
        }
    }

    /**
     * @param string   $target
     * @param callable $listener
     */
    public function registerRpc($target, callable $listener)
    {
        $this->rpcs[$target] = $listener;
    }

    /**
     * @param string $target
     */
    public function deregisterRpc($target)
    {
        unset($this->rpcs[$target]);
    }

    /**
     * @param  string $target
     * @return bool
     */
    public function hasRpc($target)
    {
        return isset($this->rpcs[$target]);
    }

    /**
     * @param $target
     * @param $payload
     * @return React\Promise\PromiseInterface
     */
    public function callRpc($target, $payload)
    {
        try {
            $promise = $this->rpcs[$target]($payload, $this);
            if ($promise instanceof PromiseInterface) {
                return $promise;
            }

            throw new \Exception('RPC must return promise');
        } catch (\Exception $exception) {
            return new RejectedPromise($exception);
        } catch (\Throwable $exception) {
            return new RejectedPromise($exception);
        }
    }

    /**
     * @param Message $message
     */
    public function message(Message $message)
    {
        $this->write($this->createLine($message));
    }

    /**
     * @param Error $error
     */
    public function error(Error $error)
    {
        $this->writeErr($this->createLine($error));
    }

    /**
     * @param  string          $uniqid
     * @return OutstandingCall
     */
    public function getOutstandingCall($uniqid)
    {
        return $this->outstandingRpcCalls->getCall($uniqid);
    }

    /**
     * @param  Rpc                    $rpc
     * @return \React\Promise\Promise
     */
    public function rpc(Rpc $rpc)
    {
        $callReference = $this->outstandingRpcCalls->newCall(function () {
        });

        $this->write($this->createLine($rpc->setUniqid($callReference->getUniqid())));

        return $callReference->getDeferred()->promise();
    }

    /**
     * @param  ActionableMessageInterface $line
     * @return LineInterface
     */
    public function createLine(ActionableMessageInterface $line)
    {
        $lineCLass = $this->options['lineClass'];

        return (string) new $lineCLass($line, $this->options['lineOptions']);
    }

    /**
     * @return \React\Promise\Promise
     */
    public function softTerminate()
    {
        return $this->rpc(MessageFactory::rpc(static::TERMINATE_RPC));
    }

    /**
     * @return Stream
     */
    public function getStdin()
    {
        return $this->stdin;
    }

    /**
     * @return Stream
     */
    public function getStdout()
    {
        return $this->stdout;
    }

    /**
     * @return Stream
     */
    public function getStderr()
    {
        return $this->stderr;
    }

    protected function attachMessenger()
    {
        /**
         * @todo duplicated code much?
         */
        if (isset($this->options['read_err'])) {
            $streamName = $this->options['read_err'];
            $this->$streamName->on('data', function ($data) use ($streamName) {
                $this->onData($data, $streamName);
            });
            unset($streamName);
        }

        if (isset($this->options['read'])) {
            $streamName = $this->options['read'];
            $this->$streamName->on('data', function ($data) use ($streamName) {
                $this->onData($data, $streamName);
            });
            unset($streamName);
        }
    }

    /**
     * @param string $line
     */
    protected function write($line)
    {
        if (isset($this->options['write'])) {
            $streamName = $this->options['write'];
            $this->$streamName->write($line);
            unset($streamName);
        }
    }

    /**
     * @param string $line
     */
    protected function writeErr($line)
    {
        if (isset($this->options['write_err'])) {
            $streamName = $this->options['write_err'];
            $this->$streamName->write($line);
            unset($streamName);
        }
    }

    /**
     * @param string $data
     * @param string $source
     */
    protected function onData($data, $source)
    {
        $this->emit('data', [$source, $data]);

        $this->buffers[$source] .= $data;

        if (strpos($this->buffers[$source], LineInterface::EOL) !== false) {
            $messages = explode(LineInterface::EOL, $this->buffers[$source]);
            $this->buffers[$source] = array_pop($messages);
            $this->iterateMessages($messages, $source);
        }
    }

    /**
     * @param array  $messages
     * @param string $source
     */
    protected function iterateMessages(array $messages, $source)
    {
        $messageFactory = $this->options['messageFactoryClass'];
        foreach ($messages as $message) {
            try {
                $messageFactory::fromLine($message, $this->options['lineOptions'])->handle($this, $source);
            } catch (\Exception $exception) {
                $this->emit('error', [$exception, $this]);
            } catch (\Throwable $exception) {
                $this->emit('error', [$exception, $this]);
            }
        }
    }
}
