#!/bin/bash

echo -e "${blue}Installing neovim configuration..."

# Create all necessary folder for neovim
if [ ! -d $HOME/nvim ]
  then
    mkdir $HOME/nvim

    # install neovim plugin manager
    curl -fLo ~/.dotfiles/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# install nvim config
ln -sf $HOME/$ROOT_CONFIG/nvim/init.vim $HOME/nvim/init.vim

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

# Install Go tool
if [ ! -d $HOME/nvim/godoctor.vim ]
  then
    git clone https://github.com/godoctor/godoctor.vim ~/nvim/godoctor.vim
fi

# If no projects configured create an empty file
if [ ! -f $HOME/nvim/projects.nvimrc ]
  then
    touch $HOME/nvim/projects.nvimrc
fi

# configuration of different plugins
ln -sf $HOME/$ROOT_CONFIG/nvim/pluggedconf/ $HOME/nvim/pluggedconf

# color schemes
ln -sf $HOME/$ROOT_CONFIG/nvim/colors/* $HOME/nvim/colors/

# snippets
ln -sf $HOME/$ROOT_CONFIG/nvim/UltiSnips/* $HOME/nvim/UltiSnips/

# see :help ftplugin
ln -sf $HOME/$ROOT_CONFIG/nvim/ftplugin/ $HOME/nvim/ftplugin

# see :help autoload
ln -sf $HOME/$ROOT_CONFIG/nvim/autoload/* $HOME/nvim/autoload/

# projects.nvimrc is installed from the cloud

# Update all the plugins
nvim --noplugin +PlugUpdate +qa

# installing colorscheme for lightline
ln -sf $HOME/$ROOT_CONFIG/nvim/plugged/lightline.vim/colorscheme/hypnos256.vim \
$HOME/nvim/plugged/lightline.vim/autoload/lightline/colorscheme/hypnos256.vim

echo -e "${green}...done\n"
