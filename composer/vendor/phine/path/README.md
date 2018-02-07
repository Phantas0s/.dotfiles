Path
====

[![Build Status][]](https://travis-ci.org/phine/lib-path)
[![Coverage Status][]](https://coveralls.io/r/phine/lib-path)
[![Latest Stable Version][]](https://packagist.org/packages/phine/path)
[![Total Downloads][]](https://packagist.org/packages/phine/path)

This library provides a utility methods for file system paths.

Usage
-----

```php
use Phine\Path\Path;

var_export(Path::canonical('/path/to/../canonicalize'));
// /path/canonicalize

var_export(Path::copy('/path/to/copy', '/path/to/copy/to'));
// 123 (number of files or empty directories copied)

var_export(Path::current());
// /home/user

var_export(Path::isAbsolute('/path/to/../test'));
// true

var_export(Path::isAbsolute('../test'));
// false

var_export(Path::isLocal('path/to/test'));
// true

var_export(Path::isLocal('\\windows\share'));
// false

var_export(Path::isLocal('http://example.com/'));
// false

var_export(Path::join(array('path', 'to', 'test'));
// path/to/test
// path\\to\\test

var_export(Path::remove('/path/to/recursively/remove'));
// 123 (number of paths removed)

var_export(Path::split('/path/to/test'));
// array('path', 'to', 'test')

var_export(Path::split('C:\\path\\to\\test'));
// array('C:', 'path', 'to', 'test')
```

Requirement
-----------

- PHP >= 5.3.3
- [Phine Exception][] >= 1.0

Installation
------------

Via [Composer][]:

    $ composer require "phine/path=~1.0"

Documentation
-------------

You can find the documentation in the [`docs/`](docs/) directory.

License
-------

This library is available under the [MIT license](LICENSE).

[Build Status]: https://travis-ci.org/phine/lib-path.png?branch=master
[Coverage Status]: https://coveralls.io/repos/phine/lib-path/badge.png
[Latest Stable Version]: https://poser.pugx.org/phine/path/v/stable.png
[Total Downloads]: https://poser.pugx.org/phine/path/downloads.png
[Phine Exception]: https://github.com/phine/lib-exception
[Composer]: http://getcomposer.org/
