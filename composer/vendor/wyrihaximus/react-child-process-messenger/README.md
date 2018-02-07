# ChildProcessMessenger
[![Linux Build Status](https://travis-ci.org/WyriHaximus/reactphp-child-process-messenger.png)](https://travis-ci.org/WyriHaximus/reactphp-child-process-messenger)
[![Windows Build status](https://ci.appveyor.com/api/projects/status/1sfdh9g2pvbuw4pp?svg=true)](https://ci.appveyor.com/project/WyriHaximus/reactphp-child-process-messenger)
[![Latest Stable Version](https://poser.pugx.org/WyriHaximus/react-child-process-messenger/v/stable.png)](https://packagist.org/packages/WyriHaximus/react-child-process-messenger)
[![Total Downloads](https://poser.pugx.org/WyriHaximus/react-child-process-messenger/downloads.png)](https://packagist.org/packages/WyriHaximus/react-child-process-messenger)
[![Code Coverage](https://scrutinizer-ci.com/g/WyriHaximus/reactphp-child-process-messenger/badges/coverage.png?b=master)](https://scrutinizer-ci.com/g/WyriHaximus/reactphp-child-process-messenger/?branch=master)
[![License](https://poser.pugx.org/WyriHaximus/react-child-process-messenger/license.png)](https://packagist.org/packages/wyrihaximus/react-child-process-messenger)
[![PHP 7 ready](http://php7ready.timesplinter.ch/WyriHaximus/reactphp-child-process-messenger/badge.svg)](https://travis-ci.org/WyriHaximus/reactphp-child-process-messenger)

Plain messages and RPC style STDIN/OUT/ERR wrapper around [`react/child-process`](https://github.com/reactphp/child-process). For pooling messengers take a look at [`wyrihaximus/react-child-process-pool`](https://github.com/WyriHaximus/reactphp-child-process-pool)

### Installation ###

To install via [Composer](http://getcomposer.org/), use the command below, it will automatically detect the latest version and bind it with `~`.

```
composer require wyrihaximus/react-child-process-messenger 
```

## Hassle less Example ##

While this package supports several ways of setting up communication between parent and child the simplest way is to create class implementing `WyriHaximus\React\ChildProcess\Messenger\ChildInterface`. Up on calling `create` everything is set up and created to handle supported `RPC`'s and messages. 

```php
<?php

use React\EventLoop\LoopInterface;
use WyriHaximus\React\ChildProcess\Messenger\ChildInterface;
use WyriHaximus\React\ChildProcess\Messenger\Messages\Payload;

class ExampleChild implements ChildInterface
{
    public static function create(Messenger $messenger, LoopInterface $loop)
    {
        $messenger->registerRpc('example', function (Payload $payload) {
            return \React\Promise\resolve($payload->getPayload());
        });
    }
}
```

On the parent side you only need need to call to spawn a child running that class:

```php
MessengerFactory::parentFromClass('ExampleChild', $loop)->then(function (Messenger $messenger) {
    $messenger->rpc(/* etc etc */);
});
```

## More Examples ##

For both message and RPC examples seee the [examples](https://github.com/WyriHaximus/reactphp-child-process-messenger/tree/master/examples) directory

## Contributing ##

Please see [CONTRIBUTING](CONTRIBUTING.md) for details.

## License ##

Copyright 2015 [Cees-Jan Kiewiet](http://wyrihaximus.net/)

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
