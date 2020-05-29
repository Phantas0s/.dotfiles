#!/bin/bash
rm $COMPOSER_HOME/composer.json &>/dev/null
ln -s $DOTFILES/composer/composer.json $COMPOSER_HOME/composer.json
