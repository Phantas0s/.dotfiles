# Child Process Component

[![Build Status](https://secure.travis-ci.org/reactphp/child-process.png?branch=master)](http://travis-ci.org/reactphp/child-process) [![Code Climate](https://codeclimate.com/github/reactphp/child-process/badges/gpa.svg)](https://codeclimate.com/github/reactphp/child-process)

Library for executing child processes.

This library integrates [Program Execution](http://php.net/manual/en/book.exec.php)
with the [EventLoop](https://github.com/reactphp/event-loop).
Child processes launched may be signaled and will emit an
`exit` event upon termination.
Additionally, process I/O streams (i.e. STDIN, STDOUT, STDERR) are exposed
as [Streams](https://github.com/reactphp/stream).

**Table of contents**

* [Quickstart example](#quickstart-example)
* [Processes](#processes)
  * [EventEmitter Events](#eventemitter-events)
  * [Methods](#methods)
  * [Stream Properties](#stream-properties)
  * [Command](#command)
  * [Sigchild Compatibility](#sigchild-compatibility)
* [Install](#install)
* [Tests](#tests)
* [License](#license)

## Quickstart example

```php
$loop = React\EventLoop\Factory::create();

$process = new React\ChildProcess\Process('echo foo');
$process->start($loop);

$process->stdout->on('data', function ($chunk) {
    echo $chunk;
});

$process->on('exit', function($exitCode, $termSignal) {
    echo 'Process exited with code ' . $exitCode . PHP_EOL;
});

$loop->run();
```

See also the [examples](examples).

## Processes

### EventEmitter Events

* `exit`: Emitted whenever the process is no longer running. Event listeners
  will receive the exit code and termination signal as two arguments.

### Methods

* `start()`: Launches the process and registers its IO streams with the event
  loop. The stdin stream will be left in a paused state.
* `terminate()`: Send the process a signal (SIGTERM by default).

There are additional public methods on the Process class, which may be used to
access fields otherwise available through `proc_get_status()`.

### Stream Properties

Once a process is started, its I/O streams will be constructed as instances of
`React\Stream\Stream`. Before `start()` is called, these properties are `null`.
Once a process terminates, the streams will become closed but not unset.

* `$stdin`
* `$stdout`
* `$stderr`

Each of these implement the underlying
[`DuplexStreamInterface`](https://github.com/reactphp/stream#duplexstreaminterface)
and you can use any of its events and methods as usual:

```php
$process->stdout->on('data', function ($chunk) {
    echo $chunk;
});

$process->stdout->on('end', function () {
    echo 'ended';
});

$process->stdout->on('error', function (Exception $e) {
    echo 'error: ' . $e->getMessage();
});

$process->stdout->on('close', function () {
    echo 'closed';
});

$process->stdin->write($data);
$process->stdin->end($data = null);
$process->stdin->close();
// …
```

For more details, see the
[`DuplexStreamInterface`](https://github.com/reactphp/stream#duplexstreaminterface).

### Command

The `Process` class allows you to pass any kind of command line string:

```php
$process = new Process('echo test');
```

By default, PHP will launch processes by wrapping the given command line string
in a `sh` command, so that the above example will actually execute
`sh -c echo test` under the hood.

This is a very useful feature because it does not only allow you to pass single
commands, but actually allows you to pass any kind of shell command line and
launch multiple sub-commands using command chains (with `&&`, `||`, `;` and
others) and allows you to redirect STDIO streams (with `2>&1` and family).
This can be used to pass complete command lines and receive the resulting STDIO
streams from the wrapping shell command like this:

```php
$process = new Process('echo run && demo || echo failed');
```

In other words, the underlying shell is responsible for managing this command
line and launching the individual sub-commands and connecting their STDIO
streams as appropriate.
This implies that the `Process` class will only receive the resulting STDIO
streams from the wrapping shell, which will thus contain the complete
input/output with no way to discern the input/output of single sub-commands.

If you want to discern the output of single sub-commands, you may want to
implement some higher-level protocol logic, such as printing an explicit
boundary between each sub-command like this:

```php
$process = new Process('cat first && echo --- && cat second');
```

As an alternative, considering launching one process at a time and listening on
its `exit` event to conditionally start the next process in the chain.
This will give you an opportunity to configure the subsequent process I/O streams:

```php
$first = new Process('cat first');
$first->start($loop);

$first->on('exit', function () use ($loop) {
    $second = new Process('cat second');
    $second->start($loop);
});
```

Keep in mind that PHP uses the shell wrapper for ALL command lines.
While this may seem reasonable for more complex command lines, this actually
also applies to running the most simple single command:

```php
$process = new Process('yes');
```

This will actually spawn a command hierarchy similar to this:

```
5480 … \_ php example.php
5481 …    \_ sh -c yes
5482 …        \_ yes
```

This means that trying to get the underlying process PID or sending signals
will actually target the wrapping shell, which may not be the desired result
in many cases.

If you do not want this wrapping shell process to show up, you can simply
prepend the command string with `exec`, which will cause the wrapping shell
process to be replaced by our process:

```php
$process = new Process('exec yes');
```

This will show a resulting command hierarchy similar to this:

```
5480 … \_ php example.php
5481 …    \_ yes
```

This means that trying to get the underlying process PID and sending signals
will now target the actual command as expected.

Note that in this case, the command line will not be run in a wrapping shell.
This implies that when using `exec`, there's no way to pass command lines such
as those containing command chains or redirected STDIO streams.

As a rule of thumb, most commands will likely run just fine with the wrapping
shell.
If you pass a complete command line (or are unsure), you SHOULD most likely keep
the wrapping shell.
If you want to pass an invidual command only, you MAY want to consider
prepending the command string with `exec` to avoid the wrapping shell.

### Sigchild Compatibility

When PHP has been compiled with the `--enabled-sigchild` option, a child
process' exit code cannot be reliably determined via `proc_close()` or
`proc_get_status()`. Instead, we execute the child process with a fourth pipe
and use that to retrieve its exit code.

This behavior is used by default and only when necessary. It may be manually
disabled by calling `setEnhanceSigchildCompatibility(false)` on the Process
before it is started, in which case the `exit` event may receive `null` instead
of the actual exit code.

**Note:** This functionality was taken from Symfony's
[Process](https://github.com/symfony/process) compoment.

## Install

The recommended way to install this library is [through Composer](http://getcomposer.org).
[New to Composer?](http://getcomposer.org/doc/00-intro.md)

This will install the latest supported version:

```bash
$ composer require react/child-process:^0.4.3
```

More details about version upgrades can be found in the [CHANGELOG](CHANGELOG.md).

## Tests

To run the test suite, you first need to clone this repo and then install all
dependencies [through Composer](http://getcomposer.org):

```bash
$ composer install
```

To run the test suite, go to the project root and run:

```bash
$ php vendor/bin/phpunit
```

## License

MIT, see [LICENSE file](LICENSE).
