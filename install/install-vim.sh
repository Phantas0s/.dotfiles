#!/bin/bash

echo "${blue} installing vim configuration..."

if [ ! -d $HOME/.vim ]
  then
    mkdir $HOME/.vim
fi

if [ ! -d $HOME/nvim ]
  then
    ln -s $HOME/$ROOT_CONFIG/nvim $HOME/nvim
fi

if [ ! -d $HOME/.vim/backup ]
  then
    mkdir $HOME/.vim/backup
fi

if [ ! -d $HOME/.vim/undo ]
  then
    mkdir $HOME/.vim/undo
fi

if [ ! -d $HOME/.vim/swap ]
  then
    mkdir $HOME/.vim/swap
fi

ln -s $HOME/$ROOT_CONFIG/vim/vimrc $HOME/.vim/vimrc

echo "${green}...done"
