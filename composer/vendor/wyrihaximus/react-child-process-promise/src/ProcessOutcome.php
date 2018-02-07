<?php

namespace WyriHaximus\React;

class ProcessOutcome
{
    /**
     * @var int
     */
    protected $exitCode;

    /**
     * @var string
     */
    protected $stderr;

    /**
     * @var string
     */
    protected $stdout;

    /**
     * ProcessOutcome constructor.
     * @param int $exitCode
     * @param string $stderr
     * @param string $stdout
     */
    public function __construct($exitCode, $stderr, $stdout)
    {
        $this->exitCode = $exitCode;
        $this->stderr = trim($stderr);
        $this->stdout = trim($stdout);
    }

    /**
     * @return int
     */
    public function getExitCode()
    {
        return $this->exitCode;
    }

    /**
     * @return string
     */
    public function getStderr()
    {
        return $this->stderr;
    }

    /**
     * @return string
     */
    public function getStdout()
    {
        return $this->stdout;
    }
}
