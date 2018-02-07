Exception
=========

[![Build Status][]](https://travis-ci.org/phine/lib-exception)
[![Coverage Status][]](https://coveralls.io/r/phine/lib-exception)
[![Latest Stable Version][]](https://packagist.org/packages/phine/exception)
[![Total Downloads][]](https://packagist.org/packages/phine/exception)

Adds functionality to the standard `Exception` class.

- Create new exceptions based on `sprintf()` format.
- Create new exceptions using the last error (`error_get_last()`).

Usage
-----

```php
use Phine\Exception\Exception;

$exception = Exception::createUsingFormat(
    'This is my %s message.',
    'formatted',
    $previousException
);

echo $undefined;

$exception = Exception::createUsingLastError();
```

Requirement
-----------

- PHP >= 5.3.3

Installation
------------

Via [Composer][]:

    $ composer require "phine/exception=~1.0"

License
-------

This library is available under the [MIT license](LICENSE).

[Build Status]: https://travis-ci.org/phine/lib-exception.png?branch=master
[Coverage Status]: https://coveralls.io/repos/phine/lib-exception/badge.png
[Latest Stable Version]: https://poser.pugx.org/phine/exception/v/stable.png
[Total Downloads]: https://poser.pugx.org/phine/exception/downloads.png
[Composer]: http://getcomposer.org/
