TickingPromise
==============

[![Build Status](https://travis-ci.org/WyriHaximus/TickingPromise.png)](https://travis-ci.org/WyriHaximus/TickingPromise)
[![Latest Stable Version](https://poser.pugx.org/WyriHaximus/ticking-promise/v/stable.png)](https://packagist.org/packages/WyriHaximus/ticking-promise)
[![Total Downloads](https://poser.pugx.org/WyriHaximus/ticking-promise/downloads.png)](https://packagist.org/packages/WyriHaximus/ticking-promise)
[![Coverage Status](https://coveralls.io/repos/WyriHaximus/TickingPromise/badge.png)](https://coveralls.io/r/WyriHaximus/TickingPromise)
[![License](https://poser.pugx.org/wyrihaximus/ticking-promise/license.png)](https://packagist.org/packages/wyrihaximus/ticking-promise)

Wrapping event loop ticks into a promise. 

## Install ##

To install via [Composer](http://getcomposer.org/), use the command below, it will automatically detect the latest version and bind it with `~`.

```
composer require wyrihaximus/ticking-promise 
```

## Example ##

```php
<?php

$loop = \React\EventLoop\Factory::create();

\WyriHaximus\React\futurePromise($loop)->then(function () {
    echo 'Done', PHP_EOL;
});
\WyriHaximus\React\futurePromise($loop)->then(function ($message) {
    echo $message, PHP_EOL;
}, 'Also done');

$loop->run();
```

For more examples check the [examples directory](https://github.com/WyriHaximus/TickingPromise/tree/master/examples).

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
