#!/bin/bash

echo 'Installing git config... \n'

rm $HOME/.terminal_config/git/gitconfig
cp $HOME/.terminal_config/git/gitconfig_template $HOME/.terminal_config/git/gitconfig

if [ -z "$GIT_EMAIL" ]
  then
    echo "Git config - Please enter your email address \n"
    echo "> "
    read GIT_EMAIL
fi

sed -i -e "s/<email>/${GIT_EMAIL}/g" $HOME/.terminal_config/git/gitconfig


if [ -z "$GIT_USER" ]
  then
    echo "Git config - Please enter your name \n"
    echo "> "
    read GIT_USER
fi

sed -i -e "s/<name>/${GIT_USER}/g" $HOME/.terminal_config/git/gitconfig

echo 'Create symlink for gitconfig...'

ln -s -f $HOME/$ROOT_CONFIG/git/gitconfig $HOME/.gitconfig


