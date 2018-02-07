PHP OS Detector
===============

[![Build Status](https://travis-ci.org/tivie/php-os-detector.svg?branch=master)](https://travis-ci.org/tivie/php-os-detector)
[![Latest Stable Version](https://poser.pugx.org/tivie/php-os-detector/v/stable.svg)](https://packagist.org/packages/tivie/php-os-detector)
[![Total Downloads](https://poser.pugx.org/tivie/php-os-detector/downloads.svg)](https://packagist.org/packages/tivie/php-os-detector)
[![License](https://poser.pugx.org/tivie/php-os-detector/license.svg)](https://packagist.org/packages/tivie/php-os-detector)

A small PHP utility library that detects the OS the server is running on.

## Compatibility

Although only tested in PHP 7, PHP OS Detector should be compatible with PHP 5.3 or greater

## Installation
You can install it by cloning the git repository or using composer.

### Git clone

    git clone https://github.com/tivie/php-os-detector.git

### Composer
Add these lines to your composer.json:
```json
    {
        "require": {
            "tivie/php-os-detector": "*"
        }
    }
```
or run the following command:

    php composer.phar require tivie/php-os-detector


## Usage Example

```php
$os = new \Tivie\OS\Detector();
$kernelName = $os->getKernelName();
if ($os->isUnixLike()) {
    echo "I'm using a Unix like system with kernel $kernelName";
} else if ($os->isWindowsLike()) {
    echo "I'm using a Windows like system with kernel $kernelName";
} else {
    echo "I'm using a non-Unix non-Windows system";
}
```

## Contribute
Feel free to contribute by forking or making suggestions.

Issue tracker: https://github.com/tivie/php-os-detector/issues

Source code: https://github.com/tivie/php-os-detector


## License
Command Library is released under Apache 2.0 license. For more information, please consult
the [LICENSE file in this repository](https://github.com/tivie/php-os-detector/blob/master/LICENSE) or
http://www.apache.org/licenses/LICENSE-2.0.txt.
