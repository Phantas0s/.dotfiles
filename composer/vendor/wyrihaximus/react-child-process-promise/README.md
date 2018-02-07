# ReactPHP Child Process Promise
[![Linux Build Status](https://travis-ci.org/WyriHaximus/reactphp-child-process-promise.png)](https://travis-ci.org/WyriHaximus/reactphp-child-process-promise)
[![Latest Stable Version](https://poser.pugx.org/WyriHaximus/react-child-process-promise/v/stable.png)](https://packagist.org/packages/WyriHaximus/react-child-process-promise)
[![Total Downloads](https://poser.pugx.org/WyriHaximus/react-child-process-promise/downloads.png)](https://packagist.org/packages/WyriHaximus/react-child-process-promise)
[![Code Coverage](https://scrutinizer-ci.com/g/WyriHaximus/reactphp-child-process-promise/badges/coverage.png?b=master)](https://scrutinizer-ci.com/g/WyriHaximus/reactphp-child-process-promise/?branch=master)
[![License](https://poser.pugx.org/WyriHaximus/react-child-process-promise/license.png)](https://packagist.org/packages/wyrihaximus/react-child-process-promise)
[![PHP 7 ready](http://php7ready.timesplinter.ch/WyriHaximus/reactphp-child-process-promise/badge.svg)](https://travis-ci.org/WyriHaximus/reactphp-child-process-promise)

Wrap a [ReactPHP child process](https://github.com/reactphp/child-process) in a promise, once the process ends the promise resolves with the exit code and `STDERR` and `STDOUT` buffers.

### Installation ###

To install via [Composer](http://getcomposer.org/), use the command below, it will automatically detect the latest version and bind it with `^`.

```
composer require wyrihaximus/react-child-process-promise 
```

## Examples ##

```php
\WyriHaximus\React\childProcessPromise($loop, new Process('uptime'))->then(function ($result) {
    var_export($result);
    /**
     * Example output: 
     * WyriHaximus\React\ProcessOutcome::__set_state(array(
     *   'exitCode' => 0,
     *   'stderr' => 'Error messages will go in this buffer',
     *   'stdout' => 'Normal output will go in this buffer',
     * ))
    */
});
```

For ready to use examples see the [examples](https://github.com/WyriHaximus/reactphp-child-process-promise/tree/master/examples) directory

## Contributing ##

Please see [CONTRIBUTING](CONTRIBUTING.md) for details.

## License ##

Copyright 2016 [Cees-Jan Kiewiet](http://wyrihaximus.net/)

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
