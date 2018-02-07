# react-child-process-pool

[![Linux Build Status](https://travis-ci.org/WyriHaximus/reactphp-child-process-pool.png)](https://travis-ci.org/WyriHaximus/reactphp-child-process-pool)
[![Windows Build status](https://ci.appveyor.com/api/projects/status/b3l3s44sla00nygw?svg=true)](https://ci.appveyor.com/project/WyriHaximus/reactphp-child-process-pool)
[![Latest Stable Version](https://poser.pugx.org/WyriHaximus/react-child-process-pool/v/stable.png)](https://packagist.org/packages/WyriHaximus/react-child-process-pool)
[![Total Downloads](https://poser.pugx.org/wyrihaximus/react-child-process-pool/downloads.png)](https://packagist.org/packages/wyrihaximus/react-child-process-pool)
[![Code Coverage](https://scrutinizer-ci.com/g/WyriHaximus/react-child-process-pool/badges/coverage.png?b=master)](https://scrutinizer-ci.com/g/WyriHaximus/react-child-process-pool/?branch=master)
[![License](https://poser.pugx.org/wyrihaximus/react-child-process-pool/license.png)](https://packagist.org/packages/wyrihaximus/react-child-process-pool)
[![PHP 7 ready](http://php7ready.timesplinter.ch/WyriHaximus/reactphp-child-process-pool/badge.svg)](https://travis-ci.org/WyriHaximus/reactphp-child-process-pool)

## Installation ##

To install via [Composer](http://getcomposer.org/), use the command below, it will automatically detect the latest version and bind it with `~`.

```
composer require wyrihaximus/react-child-process-pool
```

## Pools ##

* `Dummy` - Meant for testing, doesn't do anything but complies to it's contract
* `Fixed` - Spawns a given fixed amount of workers
* `Flexible` - Spawns workers as a needed basis, given a minimum and maximum it will spawn within those values

## Usage ##

This package pools [`wyrihaximus/react-child-process-messenger`](https://github.com/WyriHaximus/reactphp-child-process-messenger), for basic messaging please see that package for details how to use it.

## Creating a pool ##

This package ships with a set factories:

* `Dummy` - Creates a `Dummy` pool
* `Fixed` - Creates a `Fixed` pool
* `Flexible` - Creates a `Flexible` pool
* `CpuCoreCountFixed` - Creates a `Fixed` pool with size set to the number of CPU cores
* `CpuCoreCountFlexible` - Creates a `Flexible` pool with max size set to the number of CPU cores

The following example will creates a flexible pool with max size set to the number of CPU cores. Where the `create` method requires you to give it a `React\ChildProcess\Process`. The `createFromClass` lets you pass a classname of a class implementing [`WyriHaximus\React\ChildProcess\Messenger\ChildInterface`](https://github.com/WyriHaximus/reactphp-child-process-messenger/blob/master/src/ChildInterface.php) that will be used as the worker in the client. Take a look at [`WyriHaximus\React\ChildProcess\Messenger\ReturnChild`](https://github.com/WyriHaximus/reactphp-child-process-messenger/blob/master/src/ReturnChild.php) to see how that works.

```php
<?php

require 'vendor/autoload.php';

use React\EventLoop\Factory as EventLoopFactory;
use WyriHaximus\React\ChildProcess\Pool\Factory\CpuCoreCountFixed;

$loop = EventLoopFactory::create();

CpuCoreCountFlexible::createFromClass('WyriHaximus\React\ChildProcess\Messenger\ReturnChild', $loop)->then(function (PoolInterface $pool) {
  // Do things with the pool here
});
```

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


### Contributors beyond the commit log
* Gabi Davila - Helping test if my github token will be secure for pull reuquests on AppVeyor
