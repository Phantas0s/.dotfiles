echo -e ""
echo -e "${blue}Install composer global json file..."
ln -s $DOTFILES/composer/composer.json $COMPOSER_HOME/composer.json
composer global update
cgr update
echo -e "${green}Done."
