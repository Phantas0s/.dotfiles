#!/bin/bash

########################
# uninstall everything #
########################

echo 'uninstall...'

sh uninstall.sh

##################
# install Prezto #
##################

git clone git@github.com:MattCne/prezto ./.zsh/.zprezto

cd .zsh/.zprezto/ && git pull && git submodule update --init --recursive
cd ../../

rm ../.bashrc

echo 'Create symlinks for Prezto...'
ln -s -f .terminal_config/.zsh/.zprezto ../
ln -s -f .zprezto/runcoms/zlogin ../.zlogin
ln -s -f .zprezto/runcoms/zlogout ../.zlogout
ln -s -f .zprezto/runcoms/zpreztorc ../.zpreztorc
ln -s -f .zprezto/runcoms/zprofile ../.zprofile
ln -s -f .zprezto/runcoms/zshenv ../.zshenv
ln -s -f .zprezto/runcoms/zshrc ../.zshrc

echo 'Create symlinks for personnal config...'

ln -s -f .terminal_config/.zsh/.zshrc ../
ln -s -f .terminal_config/.bash/.bashrc ../
ln -s -f .terminal_config/.tmux.conf ../


chsh -s /bin/zsh

