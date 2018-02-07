#!/usr/bin/env bash

if [ -z "${ADDITIONAL_PHP_INI}" ]; then
    echo "$0 was called but env. var. ADDITIONAL_PHP_INI is not set!"
    exit 1
fi

if [ ! -f "${ADDITIONAL_PHP_INI}" ]; then
    echo "Custom php.ini path at ${ADDITIONAL_PHP_INI} not found (check ADDITIONAL_PHP_INI env. var.)"
    exit 1
fi

if [[ "${TRAVIS_OS_NAME}" == "osx" ]]; then
    if [[ "${_PHP}" == php* ]]; then
        PHP_INI_SCANDIR=$(php --ini | grep "files in" | cut -d " " -f 7)
        mkdir -v -p "${PHP_INI_SCANDIR}"
        cat "${ADDITIONAL_PHP_INI}" > "${PHP_INI_SCANDIR}/travis.ini"
        echo "Added php.ini from ${ADDITIONAL_PHP_INI} to ${PHP_INI_SCANDIR}/travis.ini"

    elif [[ "${_PHP}" == hhv* ]]; then
        echo "--Copy file for HHVM @ OSX--"
    fi

elif [[ "${TRAVIS_OS_NAME}" == "linux" ]]; then
    if [[ "${TRAVIS_PHP_VERSION}" == php* ]]; then
        phpenv config-add "${ADDITIONAL_PHP_INI}"
        echo "Added php.ini from ${ADDITIONAL_PHP_INI} to phpenv"

    elif [[ "${TRAVIS_PHP_VERSION}" == hhv* ]]; then
        cat build/.travis.php.ini >> /etc/hhvm/php.ini
        echo "Added php.ini content from ${ADDITIONAL_PHP_INI} to /etc/hhvm/php.ini"
    fi
fi
