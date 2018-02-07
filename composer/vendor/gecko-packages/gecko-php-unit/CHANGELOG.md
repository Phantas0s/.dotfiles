#### GeckoPackages

# CHANGELOG for PHPUnit extensions

This file contains the changelogs of the package.

### Changelog for v3.1
###### Jan 24, 2018

- add missing conflict with PHPUnit in composer.json

### Changelog for v3.0
###### Aug 23, 2017

For upgrading from 2.x to 3.x please see https://github.com/GeckoPackages/GeckoPHPUnit/blob/3.0/UPGRADE.md

### Changelog for v2.2
###### Aug 23, 2017

- Fix duplicate copy in README
- Travis - retry composer info, show packages installed
- Update CS to PHP-CS-Fixer 2.4
- Better exception messages on construction of `FilePermissionsIsIdenticalConstraint`
- More strict testing and remove useless escaping
- Remove dependency on `ctype` extension
- Add missing CHANGELOG.md file

### Changelog for v2.1
###### Jun 20, 2017

- Add fail message support for the asserts `assertStringIsEmpty`, `assertStringIsNotEmpty`, `assertStringIsWhiteSpace` and `assertStringIsNotWhiteSpace`

### Changelog for v2.0
###### Nov 22, 2016

- PHP 5.3 support for constraints (keradus/SpacePossum)
- Added `assertSameStrings` and `assertNotSameStrings` to the `StringsAssertTrait`. Added `SameStringsConstraint` (keradus)
- Renamed `FileExistsTrait` to `FileExistsAssertTrait`
- Added `RangeAssertTrait`, `UnsignedIntConstraint` and `NumberRangeConstraint`
- Added `assertFileIsValidLink` to `FileSystemAssertTrait` and added `FileIsValidLinkConstraint`
- README generation tweaks

### Changelog for v1.0
###### Nov 4, 2015

- First stable release

###### Notes

Kindly note:
Clean ups may be have be done in each release, these changes are not (always) listed in the change log. The changes may include:
- optimization updates (based on static code analysis for example)
- code style updates
- documentation updates, README (generation) updates
- typo fixes (which do not effect code execution)
- updates to the tests (suit) of the project

Full details on [github :octocat:](https://github.com/GeckoPackages/GeckoPHPUnit)
