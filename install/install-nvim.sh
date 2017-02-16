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

if [ ! -d $HOME/nvim/colors ]
  then
    mkdir $HOME/nvim/colors
fi

if [ ! -d $HOME/nvim/UltiSnips ]
  then
    mkdir $HOME/nvim/UltiSnips
fi

# installing colorscheme for lightline
if [ ! -f $HOME/nvim/plugged/lightline.vim/autoload/lightline/colorscheme/hypnos256.vim ]
  then
    ln -s $HOME/$ROOT_CONFIG/vim/plugged/lightline.vim/colorscheme/hypnos256.vim $HOME/nvim/plugged/lightline.vim/autoload/lightline/colorscheme/hypnos256.vim
fi

if [ ! -f $HOME/nvim/projects.nvimrc ]
  then
    echo "${blue} installing template project file for neovim"
    cp $HOME/$ROOT_CONFIG/vim/projects.nvimrc $HOME/nvim/projects.nvimrc
fi

ln -s -f $HOME/$ROOT_CONFIG/vim/pluggedconf $HOME/nvim/pluggedconf
ln -s -f $HOME/$ROOT_CONFIG/vim/colors/* $HOME/nvim/colors
ln -s -f $HOME/$ROOT_CONFIG/vim/UltiSnips/* $HOME/nvim/UltiSnips

echo "${green}...done"
