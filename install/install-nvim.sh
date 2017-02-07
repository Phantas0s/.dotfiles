#!/bin/bash

echo "${blue} installing neovim configuration..."
# install neovim plugin manager

if [ ! -d $HOME/nvim ]
  then
    mkdir $HOME/nvim
    
    curl -fLo ~/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    ln -s $HOME/$ROOT_CONFIG/vim/nvimrc $HOME/nvim/init.vim
fi

if [ ! -d $HOME/nvim/backup ]
  then
    mkdir $HOME/nvim/backup
fi

if [ ! -d $HOME/nvim/undo ]
  then
    mkdir $HOME/nvim/undo
fi

if [ ! -d $HOME/nvim/swap ]
  then
    mkdir $HOME/nvim/swap
fi

if [ ! -d $HOME/nvim/plugged ]
  then
    mkdir $HOME/nvim/plugged
fi

if [ ! -d $HOME/nvim/pluggedconf ]
  then
    mkdir $HOME/nvim/pluggedconf
fi

if [ ! -d $HOME/nvim/colors ]
  then
    mkdir $HOME/nvim/colors
fi

ln -s -f $HOME/$ROOT_CONFIG/vim/pluggedconf/* $HOME/nvim/pluggedconf
ln -s -f $HOME/$ROOT_CONFIG/vim/colors/* $HOME/nvim/colors

echo "${green}...done"
