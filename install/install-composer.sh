#!/usr/bin/env bash

# TODO experienced one crash here - might help?
# [ ! -d $COMPOSER_HOME ] && mkdir -p $COMPOSER_HOME
ln -sf $DOTFILES/composer/composer.json $COMPOSER_HOME/composer.json

if [ ! -f $COMPOSER_HOME/vendor/bin/cgr ]
then
      echo -e "${blue}Installing consolidation/cgr"
      composer global require consolidation/cgr
fi

if [ ! -f $COMPOSER_HOME/vendor/bin/phpstan ]
then
    cgr phpstan/phpstan
fi

if [ ! -f $COMPOSER_HOME/vendor/bin/pdepend ]
then
    cgr pdepend/pdepend
fi

if [ ! -f $COMPOSER_HOME/vendor/bin/dephpend ]
then
    cgr dephpend/dephpend
fi

if [ ! -f $COMPOSER_HOME/vendor/bin/churn ]
then
    cgr bmitch/churn-php
fi

if [ ! -f $COMPOSER_HOME/vendor/bin/phpmd ]
then
    cgr phpmd/phpmd
fi

if [ ! -f $COMPOSER_HOME/vendor/bin/phploc ]
then
    cgr phploc/phploc
fi

if [ ! -f $COMPOSER_HOME/vendor/bin/phpcs ]
then
    cgr squizlabs/php_codesniffer
fi

if [ ! -f $COMPOSER_HOME/vendor/bin/php-cs-fixer ]
then
    cgr friendsofphp/php-cs-fixer
fi

if [ ! -f $COMPOSER_HOME/vendor/bin/phpbench ]
then
    cgr phpbench/phpbench
fi

if [ ! -f $COMPOSER_HOME/vendor/bin/phpmnd ]
then
    cgr povils/phpmnd
fi

if [ ! -f $COMPOSER_HOME/vendor/bin/phpcf ]
then
    cgr wapmorgan/php-code-fixer
fi

if [ ! -f $COMPOSER_HOME/vendor/bin/phpmetrics ]
then
    cgr phpmetrics/phpmetrics
fi

if [ ! -f $COMPOSER_HOME/vendor/bin/psalm ]
then
    cgr vimeo/psalm
fi
