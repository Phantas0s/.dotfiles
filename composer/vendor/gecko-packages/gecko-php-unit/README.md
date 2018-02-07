#### GeckoPackages

# PHPUnit extensions

Provides additional asserts to be used in [PHPUnit](https://phpunit.de/) tests.
The asserts are provided using Traits so no changes are needed in the hierarchy of test classes.

The additional asserts are provided through the Traits:

- **AliasAssertTrait**<br/>
  Provides alias/short hand asserts.
- **FileExistsAssertTrait**<br/>
  Replaces the PHPUnit `assertFileExists` method. This assert does not pass if there is a directory rather than a file.
- **FileSystemAssertTrait**<br/>
  Provides asserts for testing directories, files and symbolic links.
- **RangeAssertTrait**<br/>
  Provides asserts for testing values with ranges.
- **StringsAssertTrait**<br/>
  Provides asserts for testing of strings.
- **XMLAssertTrait**<br/>
  Additional PHPUnit asserts for testing XML based logic.

See Traits and asserts listing for more details.

### Requirements

PHP 7<br/>
PHPUnit 6

<sub>Use ^v2.0 if you are using PHPUnit 5.</sub>

### Install

The package can be installed using [Composer](https://getcomposer.org/).
Add the package to your `composer.json`.

```
"require-dev": {
    "gecko-packages/gecko-php-unit" : "^3.0"
}
```

<sub>Please note we hint `-dev` here because typically you only need tests during development.</sub>

### Usage

Example usage of `FileSystemAssertTrait`.

```php
class myTest extends \PHPUnit_Framework_TestCase
{
    use \GeckoPackages\PHPUnit\Asserts\FileSystemAssertTrait;

    public function testFilePermissionsOfThisFile()
    {
        $this->assertFileHasPermissions('lrwxrwxrwx', __FILE__);
    }
}

```

# Traits and asserts listing

## AliasAssertTrait
###### GeckoPackages\PHPUnit\Asserts\AliasAssertTrait
Additional alias/shorthand PHPUnit asserts to test for some types etc.


### Methods

#### assertArray()
###### assertArray(mixed $actual [,string $message = ''])
Assert value is an array.

The inverse assertion
#### assertNotArray()
###### assertNotArray(mixed $actual [,string $message = ''])
Assert value is not an array.


#### assertBool()
###### assertBool(mixed $actual [,string $message = ''])
Assert value is a bool (boolean).

The inverse assertion
#### assertNotBool()
###### assertNotBool(mixed $actual [,string $message = ''])
Assert value is not a bool (boolean).


#### assertFloat()
###### assertFloat(mixed $actual [,string $message = ''])
Assert value is a float (double, real).

The inverse assertion
#### assertNotFloat()
###### assertNotFloat(mixed $actual [,string $message = ''])
Assert value is not a float (double, real).


#### assertInt()
###### assertInt(mixed $actual [,string $message = ''])
Assert value is an int (integer).

The inverse assertion
#### assertNotInt()
###### assertNotInt(mixed $actual [,string $message = ''])
Assert value is not an int (integer).


#### assertScalar()
###### assertScalar(mixed $actual [,string $message = ''])
Assert value is a scalar.

The inverse assertion
#### assertNotScalar()
###### assertNotScalar(mixed $actual [,string $message = ''])
Assert value is not a scalar.


#### assertString()
###### assertString(mixed $actual [,string $message = ''])
Assert value is a string.

The inverse assertion
#### assertNotString()
###### assertNotString(mixed $actual [,string $message = ''])
Assert value is not a string.


## FileExistsAssertTrait
###### GeckoPackages\PHPUnit\Asserts\FileExistsAssertTrait
Replacement for PHPUnits `assertFileExists` and `assertFileNotExists`.
Asserts when the filename exists and is a regular file, i.e. directories do not pass (however a symlink to a file does).<br/>
<sub>Note. Since this changes the default behaviour of the PHPUnit assert this has been placed in a separate trait.</sub>


### Methods

#### assertFileExists()
###### assertFileExists(mixed $filename [,string $message = ''])
Assert the filename exists and is a regular file.

The inverse assertion
#### assertFileNotExists()
###### assertFileNotExists(mixed $filename [,string $message = ''])
Assert the filename does not exists or is not a regular file.


## FileSystemAssertTrait
###### GeckoPackages\PHPUnit\Asserts\FileSystemAssertTrait
Additional PHPUnit asserts for testing file (system) based logic.


### Methods

#### assertDirectoryEmpty()
###### assertDirectoryEmpty(mixed $filename [,string $message = ''])
Assert that a directory exists and is empty.

The inverse assertion
#### assertDirectoryNotEmpty()
###### assertDirectoryNotEmpty(mixed $filename [,string $message = ''])
Assert that a directory exists and is not empty.


#### assertFileHasPermissions()
###### assertFileHasPermissions(int|string $permissions, mixed $filename [,string $message = ''])
Asserts that a file permission matches, for example: 'drwxrwxrwx' or '0664'.

#### assertFileIsLink()
###### assertFileIsLink(mixed $filename [,string $message = ''])
Assert that a file is a symbolic link.

The inverse assertion
#### assertFileIsNotLink()
###### assertFileIsNotLink(mixed $filename [,string $message = ''])
Assert that a file is not a symbolic link.


#### assertFileIsValidLink()
###### assertFileIsValidLink(mixed $filename [,string $message = ''])
Assert given value is a string, symlink and points to a file or directory that exists.

#### assertFilePermissionMask()
###### assertFilePermissionMask(int $permissionMask, mixed $filename [,string $message = ''])
Asserts that a file permission matches mask, for example: '0007'.

The inverse assertion
#### assertFilePermissionNotMask()
###### assertFilePermissionNotMask(int $permissionMask, mixed $filename [,string $message = ''])
Asserts that a file permission does not matches mask, for example: '0607'.


## RangeAssertTrait
###### GeckoPackages\PHPUnit\Asserts\RangeAssertTrait
Additional PHPUnit asserts for testing if numbers are within or on ranges.


### Methods

#### assertNumberInRange()
###### assertNumberInRange(int|float $lowerBoundary, int|float $upperBoundary, mixed $actual [,string $message = ''])
Assert that a number is within a given range (a,b).

The inverse assertion
#### assertNumberNotInRange()
###### assertNumberNotInRange(int|float $lowerBoundary, int|float $upperBoundary, mixed $actual [,string $message = ''])
Assert that a number is not within a given range !(a,b).


#### assertNumberOnRange()
###### assertNumberOnRange(int|float $lowerBoundary, int|float $upperBoundary, mixed $actual [,string $message = ''])
Assert that a number is within a given range or on its boundaries [a,b].

The inverse assertion
#### assertNumberNotOnRange()
###### assertNumberNotOnRange(int|float $lowerBoundary, int|float $upperBoundary, mixed $actual [,string $message = ''])
Assert that a number is not within a given range and not on its boundaries ![a,b].


#### assertUnsignedInt()
###### assertUnsignedInt(mixed $actual [,string $message = ''])
Assert that given value is an unsigned int (>= 0).

## StringsAssertTrait
###### GeckoPackages\PHPUnit\Asserts\StringsAssertTrait


### Methods

#### assertSameStrings()
###### assertSameStrings(string $expected, mixed $actual [,string $message = ''])
Assert that strings are identical.

The inverse assertion
#### assertNotSameStrings()
###### assertNotSameStrings(string $expected, mixed $actual [,string $message = ''])
Assert that strings are not identical.


#### assertStringIsEmpty()
###### assertStringIsEmpty(mixed $actual [,string $message = ''])
Assert value is a string and is empty.

The inverse assertion
#### assertStringIsNotEmpty()
###### assertStringIsNotEmpty(mixed $actual [,string $message = ''])
Assert value is a string and is not empty.


#### assertStringIsWhiteSpace()
###### assertStringIsWhiteSpace(mixed $actual [,string $message = ''])
Assert value is a string and only contains white space characters (" \t\n\r\0\x0B").

The inverse assertion
#### assertStringIsNotWhiteSpace()
###### assertStringIsNotWhiteSpace(mixed $actual [,string $message = ''])
Assert value is a string and not only contains white space characters (" \t\n\r\0\x0B").


## XMLAssertTrait
###### GeckoPackages\PHPUnit\Asserts\XMLAssertTrait

Requires libxml (https://secure.php.net/manual/en/book.libxml.php).

### Methods

#### assertXMLMatchesXSD()
###### assertXMLMatchesXSD(string $XML, string $XSD [,string $message = ''])
Assert string is XML formatted as defined by the XML Schema Definition.

#### assertXMLValid()
###### assertXMLValid(string $XML [,string $message = ''])
Assert string is valid XML.

### License

The project is released under the MIT license, see the LICENSE file.

### Contributions

Contributions are welcome!<br/>
Visit us on [github :octocat:](https://github.com/GeckoPackages/GeckoPHPUnit)

### Semantic Versioning

This project follows [Semantic Versioning](http://semver.org/).

<sub>Kindly note:
We do not keep a backwards compatible promise on code annotated with `@internal`, the tests and tooling (such as document generation) of the project itself
nor the content and/or format of exception/error messages.</sub>

This project is maintained on [github :octocat:](https://github.com/GeckoPackages/GeckoPHPUnit)
