#!/bin/bash

echo 'Installing git config... \n'

rm $HOME/.terminal_config/git/gitconfig
cp $HOME/.terminal_config/git/gitconfig_template $HOME/.terminal_config/git/gitconfig

echo "Git config - Please enter your email address \n"
echo "> "
read answer

sed -i -e 's/<email>/'"$answer"'/g' $HOME/.terminal_config/git/gitconfig

echo "Git config - Please enter your name \n"
echo "> "
read answer

sed -i -e 's/<name>/'"$answer"'/g' $HOME/.terminal_config/git/gitconfig

echo 'Create symlink for gitconfig...'

ln -s -f $HOME/$ROOT_CONFIG/git/gitconfig $HOME/.gitconfig


