echo -e "${blue} Update npm packages..."
npm install -g npm
npm update -g
echo -e "${green} ...done\n"

#---------------------------------------

echo -e "${blue} Update composer global packages..."
composer self-update
cgr update
# cgr phpstan/phpstan
# cgr pdepend/pdepend
# cgr dephpend/dephpend
# cgr bmitch/churn-php
# cgr phpmd/phpmd
# cgr phploc/phploc
# cgr squizlabs/php_codesniffer
# cgr friendsofphp/php-cs-fixer
# cgr phpbench/phpbench
# cgr povils/phpmnd
# cgr wapmorgan/php-code-fixer
# cgr phpmetrics/phpmetrics
echo -e "${green} ...done\n"

#---------------------------------------

echo -e "${blue} Update go packages..."
cd $DOTFILES/install/go
for f in *.sh; do
    sh "$f"
done
cd -
echo -e "${green} ...done\n"

#---------------------------------------

echo -e "${blue} Update neovim plugins..."
# Update all the plugins
nvim --noplugin +PlugUpdate +qa
echo -e "${green} ...done\n"

#---------------------------------------

echo -e "${blue} Update tmux plugins..."
$HOME/.tmux/plugins/tpm/bin/update_plugins all
echo -e "${green} ...done\n"
