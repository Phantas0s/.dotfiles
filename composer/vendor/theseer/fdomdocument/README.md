fDOMDocument
============

The classes contained within this repository extend the standard DOM to use exceptions at
all occasions of errors instead of PHP warnings or notices. They also add various custom methods
and shortcuts for convenience and to simplify the usage of DOM.

[![Build Status](https://travis-ci.org/theseer/fDOMDocument.png)](https://travis-ci.org/theseer/fDOMDocument)

Requirements
------------

    PHP: 5.3.3 (5.3.0-5.3.2 had serious issues with spl stacked autoloaders)
    Extensions: dom, libxml


Installation
------------
Apart from cloning this repository, fDOMDocument can be installed using by any of the following methods.

##### Composer
As fDOMDocument is a library and does not provide any cli tools, you can only add it to your own project:

    {
        "require": {
            "theseer/fdomdocument": "^1.6"
        }
    }


##### YUM/DNF (Fedora / Redhat / CentOS)
The following command will install fDOMDocument via its RPM package:

    sudo yum install php-theseer-fDOMDocument


Usage
-----

fDOMDocument is designed as a drop in replacement for DOMDocument. You can either use the composer generated
autoloader or the provided one.

Usage Samples
-------------
    <?php

    require '/path/to/autoload.php';

    $dom = new TheSeer\fDOM\fDOMDocument();
    try {
        $dom->loadXML('<?xml version="1.0" ?><root><child name="foo" /></root>');
    } catch (fDOMException $e) {
        die($e);
    }

    $child = $dom->queryOne('//child');
    print_r($child->getAttribute('name'));
    print_r($child->getAttribute('missing','DefaultValue'));

    ?>

Changelog
---------
##### Release 1.6.6
* Merge PRs 33+34: Add support for parameter "asTextNode" to fDOMElement::appendElement(). 
  fDOMElement::appendElementNS() and fDOMElement::appendElementPrefix

##### Releaes 1.6.5
* Revert git exports limitations as they cause unwanted side effects

##### Releaes 1.6.4
* Merge PR 31 to optimize travis builds and git exports (Thanks to @willemstuursma)

##### Releaes 1.6.3
* Merge PR 29 to fix issues with PHP 7.2

##### Release 1.6.2
* Handle empty string warings from PHP

##### Release 1.6.1
* Added Workaround for [HHVM Issue #5412](https://github.com/facebook/hhvm/issues/5412)

##### Release 1.6.0
* Added ```createElement*``` to ```fDOMEmenet``` and ```fDOMDocumentFragment``` as shortcuts
* Added ```appendElement*``` to ```fDOMDocumentFragment``` as shortcuts
* Enhanced the exception messages of save errors with filenames to contain the filename
* Fixed fDomDocumentFragment::__toString to actually work
* Updated / Added some tests

##### Release 1.5.0
* Added ```select``` to ```fDOMDocument```,```fDOMElement``` and ```fDOMNode``` to support
  CSS Selectors in favor of XPath only to find nodes

* Added ```query``` and ```queryOne``` forwardes to ```fDOMNode```

##### Release 1.4.3
* Added ```saveXML``` and ```saveHTML``` to ```fDOMNode``` and ```fDOMElement``` as a
  shortcut to calling those methods on the ownerDocument

##### Release 1.4.2
* Added ```__toString``` support to ```fDOMNode```, ```fDOMElement```, ```fDOMDocument``` and ```fDOMDocumentFragment```

##### Release 1.4.1
* Removed unused Interface ```fDOMNodeInterface``` from code base

##### Release 1.4.0
* Added XPathQuery helper object, allowing for a prepared statement alike API around XPath

##### Release 1.3.2
* Added ```__clone``` method to reset domxpath object when domdocument gets cloned (Thanks to Markus Ineichen for pointing it out)

##### Release 1.3.1
* PHP 5.3 compatibility: changed interal behavior for incompatible changes from PHP 5.3 to 5.4 (Thanks to Jens Graefe for pointing it out)

##### Release 1.3.0
* Added appendTextNode method (Thanks to Markus Ineichen)
* Added appendElement / appendElementNS to DOMDocument to support documentElement "creation" (Thanks to Markus Ineichen)
* Overwrite createElement / createElementNS to throw exception on error
* Removed fDOMFilter code: Unmaintained and broken in its current form
* Added (static) Flag for fDOMException to globally enable full exception message
* Added Unit tests

##### Release 1.2.4
* PHP 5.4 compatibilty: added support for optional options bitmask on additional methods

##### Release 1.2.3
* Cleanup code style to adhere coding standard
* Added entity support for Attributes
* Added phpcs file to make coding standard public

##### Release 1.2.2
* Fix Exception to not overwrite final methods of \Exception

##### Release 1.2.1
* Changed fDOMDocument to be no longer final, use lsb to lookup actual class in constructor.
  This should fix test/mock issues.

##### Release 1.2.0
* Changed fException to be more compatible with standard exceptions by adding a switch to get full info by getMessage()
* Merged setAttributes() and setAttributesNS() methods from Andreas
* Fixed internal registerNamespace variable mixup

##### Release 1.1.0
* Renamed files to mimic classname cases
* Fixed inSameDocument to support DOMDocument as well as DOMNodes
* Added fDOMXPath class providing queryOne(), qoute() and prepare()
* Adjusted forwarders in fDOMDocument to make use of new object
* Fixed various return values to statically return true for compatibility with original API
* Applied Workaround to fix potential problems with lost references to instances of fDOMDocument
* Support registerPHPFunctions
* Bump Copyright
* Added missing docblocks

##### Release 1.0.2
* Indenting and typo fixes, minor bugfixes

##### Release 1.0.1
* Bugfix: typehints corrected

##### Release 1.0.0
* Initial release
