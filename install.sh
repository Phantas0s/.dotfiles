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

cd ../.zprezto && git pull && git submodule update --init --recursive
cd ../

echo 'Create symlinks for Prezto...'
ln -s -f .zprezto/runcoms/zlogin .zlogin
ln -s -f .zprezto/runcoms/zlogout .zlogout
ln -s -f $ROOT_CONFIG/.zsh/.zprezto/config/zpreztorc .zpreztorc
ln -s -f .zprezto/runcoms/zprofile .zprofile
ln -s -f .zprezto/runcoms/zshenv .zshenv
ln -s -f $ROOT_CONFIG/.zsh/.zprezto/config/zshrc .zshrc

echo 'Create symlinks for personnal config...'

ln -s -f $ROOT_CONFIG/.bash/.bashrc .
ln -s -f $ROOT_CONFIG/.tmux.conf .
ln -s -f $ROOT_CONFIG/urxvt/.Xdefaults .

echo 'Create symlinks for personnal prezto themes'

cd ~/.zprezto/modules/prompt/functions/
ln -s -f $HOME/$ROOT_CONFIG/.zsh/.zprezto/themes/prompt_sorin2_setup
ln -s -f $HOME/$ROOT_CONFIG/.zsh/.zprezto/themes/prompt_garrett_setup
ln -s -f $HOME/$ROOT_CONFIG/.zsh/.zprezto/themes/prompt_garrett2_setup

cd ~/.terminal_config


