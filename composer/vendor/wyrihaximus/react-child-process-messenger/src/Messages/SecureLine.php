<?php

namespace WyriHaximus\React\ChildProcess\Messenger\Messages;

class SecureLine implements LineInterface
{
    /**
     * @var Line
     */
    protected $line;

    /**
     * @var string
     */
    protected $key;

    /**
     * @param \JsonSerializable $line
     * @param array             $options
     */
    public function __construct(\JsonSerializable $line, array $options)
    {
        $this->line = $line;
        $this->key  = $options['key'];
    }

    /**
     * @return string
     */
    public function __toString()
    {
        $line = json_encode($this->line);

        return json_encode([
            'type' => 'secure',
            'line' => $line,
            'signature' => base64_encode(static::sign($line, $this->key)),
        ]) . LineInterface::EOL;
    }

    public static function fromLine($line, array $lineOptions)
    {
        if (static::validate(base64_decode($line['signature'], true), $line['line'], $lineOptions['key'])) {
            return Factory::fromLine($line['line'], $lineOptions);
        }

        throw new \Exception('Signature mismatch!');
    }

    protected static function sign($line, $key)
    {
        return hash_hmac('sha256', $line, $key, true);
    }

    protected static function validate($signature, $line, $key)
    {
        return hash_equals($signature, static::sign($line, $key));
    }
}
