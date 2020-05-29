#!/bin/bash

rm $HOME/.gitconfig &>/dev/null
rm $DOTFILES/git/gitconfig >/dev/null
cp $DOTFILES/git/gitconfig_template $DOTFILES/git/gitconfig

if [ -z "$GIT_EMAIL" ]
  then
    echo "Git config - Please enter your email address \n"
    echo "> "
    read GIT_EMAIL
    echo "GIT_EMAIL=$GIT_EMAIL" >> $DOTFILES/install_config
fi

sed -i -e "s/<email>/${GIT_EMAIL}/g" $DOTFILES/git/gitconfig

if [ -z "$GIT_USER" ]
  then
    echo "Git config - Please enter your name \n"
    echo "> "
    read GIT_USER
    echo "GIT_USER=$GIT_USER" >> $DOTFILES/install_config
fi

sed -i -e "s/<name>/${GIT_USER}/g" $DOTFILES/git/gitconfig

ln -s -f $DOTFILES/git/gitconfig $HOME/.gitconfig
ln -s -f $DOTFILES/git/gitignore $HOME/.gitignore

# Set the global hooks
git config --global init.templatedir "$DOTFILES/git/templates"
