# hash_*() compat

[![Latest Version](https://img.shields.io/github/release/indigophp/hash-compat.svg?style=flat-square)](https://github.com/indigophp/hash-compat/releases)
[![Software License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square)](LICENSE)
[![Build Status](https://img.shields.io/travis/indigophp/hash-compat.svg?style=flat-square)](https://travis-ci.org/indigophp/hash-compat)
[![Code Coverage](https://img.shields.io/scrutinizer/coverage/g/indigophp/hash-compat.svg?style=flat-square)](https://scrutinizer-ci.com/g/indigophp/hash-compat)
[![Total Downloads](https://img.shields.io/packagist/dt/indigophp/hash-compat.svg?style=flat-square)](https://packagist.org/packages/indigophp/hash-compat)

**Backports hash_* functionality to older PHP versions.**


## Install

Via Composer

``` bash
$ composer require indigophp/hash-compat
```

You can safely install this package on systems, where these functions already exist, there won't be any conflict.

Since these functions have no dependencies, you can also include `src/{FUNCTION_NAME}.php` in your project.


## Usage

The backported functions provide the same functionality as the built-in in every way.

Currently supported functions:
- [hash_equals](http://php.net/manual/en/function.hash-equals.php)
- [hash_pbkdf2](http://php.net/manual/en/function.hash-pbkdf2.php)


## Testing

``` bash
$ composer test
```


## Contributing

Please see [CONTRIBUTING](CONTRIBUTING.md) for details.


## Security

If you discover any security related issues, please contact us at [security@indigophp.com](mailto:security@indigophp.com).


## Credits

- [Márk Sági-Kazár](https://github.com/sagikazarmark)
- [All Contributors](https://github.com/indigophp/hash-compat/contributors)


## License

The MIT License (MIT). Please see [License File](LICENSE) for more information.
