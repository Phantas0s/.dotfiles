#!/bin/bash

#############
# variables #
#############

ROOT_CONFIG=".terminal_config"

########################
# uninstall everything #
########################

echo 'uninstall...'
sh $HOME/.terminal_config/uninstall.sh

# install diff so fancy?
# install prezto
. $HOME/$ROOT_CONFIG/install/install-prezto.sh

###################
# Create symlinks #
###################

echo 'Installing git config... \n'
rm $HOME/.terminal_config/git/gitconfig
cp $HOME/.terminal_config/git/gitconfig_template $HOME/.terminal_config/git/gitconfig

echo -n "Git config - Please enter your email address \n"
echo -n "> "
read answer

sed -i -e 's/<email>/'"$answer"'/g' $HOME/.terminal_config/git/gitconfig

echo -n "Git config - Please enter your name \n"
echo -n "> "
read answer

sed -i -e 's/<name>/'"$answer"'/g' $HOME/.terminal_config/git/gitconfig

echo 'Create symlink for gitconfig...'

ln -s -f $HOME/$ROOT_CONFIG/git/gitconfig $HOME/.gitconfig

echo 'Create symlinks for personnal config...'

ln -s -f $HOME/$ROOT_CONFIG/bash/bashrc $HOME/.bashrc
ln -s -f $HOME/$ROOT_CONFIG/tmux/tmux.conf $HOME/.tmux.conf
ln -s -f $HOME/$ROOT_CONFIG/urxvt/Xdefaults $HOME/.Xdefaults
ln -s -f $HOME/$ROOT_CONFIG/urxvt/autostart/urxvtd.desktop $HOME/.config/autostart/

