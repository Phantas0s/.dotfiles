#!/bin/bash

echo -e "\n${blue}Install composer global json file..."
ln -s $DOTFILES/composer/composer.json $COMPOSER_HOME/composer.json
echo -e "${green}Done."
