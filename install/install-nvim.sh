#!/bin/bash

echo -e "${blue}Installing neovim configuration..."

# install nvim config
ln -sf $HOME/$ROOT_CONFIG/vim/nvimrc $HOME/nvim/init.vim

# installing colorscheme for lightline
ln -sf $HOME/$ROOT_CONFIG/vim/plugged/lightline.vim/colorscheme/hypnos256.vim $HOME/nvim/plugged/lightline.vim/autoload/lightline/colorscheme/hypnos256.vim

# Create all necessary folder for neovim
if [ ! -d $HOME/nvim ]
  then
    mkdir $HOME/nvim

    # install neovim plugin manager
    curl -fLo ~/.dotfiles/vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install all mandatory folders if they don't exist already
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

if [ ! -d $HOME/nvim/autoload ]
  then
    mkdir $HOME/nvim/autoload
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

# configuration of different plugins
ln -sf $HOME/$ROOT_CONFIG/vim/pluggedconf/ $HOME/nvim/pluggedconf

# color schemes
ln -sf $HOME/$ROOT_CONFIG/vim/colors/* $HOME/nvim/colors/

# snippets
ln -sf $HOME/$ROOT_CONFIG/vim/UltiSnips/* $HOME/nvim/UltiSnips/

# see :help ftplugin
ln -sf $HOME/$ROOT_CONFIG/vim/ftplugin/ $HOME/nvim/ftplugin

# see :help autoload
ln -sf $HOME/$ROOT_CONFIG/vim/autoload/* $HOME/nvim/autoload/

# projects.nvimrc is installed from the cloud

echo -e "${green}...done\n"
