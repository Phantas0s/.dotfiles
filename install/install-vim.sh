#!/bin/bash

echo "${blue} installing vim configuration..."

if [ ! -d $HOME/.vim ]
  then
    mkdir $HOME/.vim
fi

ln -s $HOME/$ROOT_CONFIG/vim/vimrc $HOME/.vim/vimrc

echo "${green}...done"
