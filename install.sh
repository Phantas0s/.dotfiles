#!/bin/bash

#############
# variables #
#############

ROOT_CONFIG=".terminal_config"

############
# includes #
############

. $HOME/$ROOT_CONFIG/colors

########################
# uninstall everything #
########################

echo -e $green"uninstall..."

sh $HOME/.terminal_config/uninstall.sh

# TODO: install diff so fancy?
# install prezto
. $HOME/$ROOT_CONFIG/install/install-prezto.sh

###################
# Create symlinks #
###################

## install git config
. $HOME/$ROOT_CONFIG/install/install-git.sh

echo 'Create symlinks for personnal config...'

ln -s -f $HOME/$ROOT_CONFIG/bash/bashrc $HOME/.bashrc
ln -s -f $HOME/$ROOT_CONFIG/tmux/tmux.conf $HOME/.tmux.conf
ln -s -f $HOME/$ROOT_CONFIG/urxvt/Xdefaults $HOME/.Xdefaults
ln -s -f $HOME/$ROOT_CONFIG/urxvt/autostart/urxvtd.desktop $HOME/.config/autostart/

