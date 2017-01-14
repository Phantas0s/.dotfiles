#!/bin/bash

##################
# install Prezto #
##################

git clone git@github.com:MattCne/prezto ./.zsh/.zprezto
cd .zsh/.zprezto/ && git pull && git submodule update --init --recursive
cd ../../

rm ../.bashrc

ln -s -f .terminal_config/.zsh/.zprezto ../
ln -s -f .terminal_config/.zsh/.zshrc ../
ln -s -f .terminal_config/.bash/.bashrc ../
ln -s -f .terminal_config/.tmux.conf ../

chsh -s /bin/zsh

