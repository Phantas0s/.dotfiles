#!/bin/bash

#############
# Variables #
#############

ROOT_CONFIG=".terminal_config"

########################
# uninstall everything #
########################

echo 'uninstall...'
sh uninstall.sh

##################
# install Prezto #
##################

git clone git@github.com:sorin-ionescu/prezto ~/.zprezto

cd $HOME/.zprezto && git pull && git submodule update --init --recursive


###################
# Create symlinks #
###################

echo 'Create symlinks for Prezto...'
ln -s -f $HOME/.zprezto/runcoms/zlogin $HOME/.zlogin
ln -s -f $HOME/.zprezto/runcoms/zlogout $HOME/.zlogout
ln -s -f $HOME/$ROOT_CONFIG/zsh/zprezto/config/zpreztorc $HOME/.zpreztorc
ln -s -f $HOME/.zprezto/runcoms/zprofile $HOME/.zprofile
ln -s -f $HOME/.zprezto/runcoms/zshenv $HOME/.zshenv
ln -s -f $HOME/$ROOT_CONFIG/zsh/zprezto/config/zshrc $HOME/.zshrc

echo 'Create symlinks for personnal config...'

ln -s -f $HOME/$ROOT_CONFIG/bash/.bashrc $HOME
ln -s -f $HOME/$ROOT_CONFIG/.tmux.conf $HOME
ln -s -f $HOME/$ROOT_CONFIG/urxvt/.Xdefaults $HOME
ln -s -f $HOME/$ROOT_CONFIG/urxvt/autostart/urxvtd.desktop $HOME/.config/autostart/

echo 'Create symlinks for personnal prezto themes'

cd ~/.zprezto/modules/prompt/functions/
ln -s -f $HOME/$ROOT_CONFIG/zsh/zprezto/themes/prompt_sorin2_setup
ln -s -f $HOME/$ROOT_CONFIG/zsh/zprezto/themes/prompt_garrett_setup
ln -s -f $HOME/$ROOT_CONFIG/zsh/zprezto/themes/prompt_garrett2_setup

cd ~/.terminal_config


