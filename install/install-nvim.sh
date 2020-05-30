#!/bin/bash

rm $XDG_CONFIG_HOME/nvim/pluggedconf &>/dev/null
rm $XDG_CONFIG_HOME/nvim/colors/* &>/dev/null
rm $XDG_CONFIG_HOME/nvim/ftplugin &>/dev/null
rm $XDG_CONFIG_HOME/nvim/autoload/* &>/dev/null


# Create all necessary folder for neovim
if [ ! -d $XDG_CONFIG_HOME/nvim ]
  then
    mkdir $XDG_CONFIG_HOME/nvim

    # install neovim plugin manager
    curl -fLo ~/.dotfiles/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# install vim session folder
mkdir -p $XDG_CONFIG_HOME/nvim/sessions

# install nvim config
ln -sf $DOTFILES/nvim/init.vim $XDG_CONFIG_HOME/nvim/init.vim

# Install all mandatory folders if they don't exist already
mkdir -p $XDG_CONFIG_HOME/nvim/plugged
mkdir -p $XDG_CONFIG_HOME/nvim/colors
mkdir -p $XDG_CONFIG_HOME/nvim/ultisnips
mkdir -p $XDG_CONFIG_HOME/nvim/autoload
mkdir -p $XDG_CONFIG_HOME/nvim/backup
mkdir -p $XDG_CONFIG_HOME/nvim/undo
mkdir -p $XDG_CONFIG_HOME/nvim/swap
mkdir -p $XDG_CONFIG_HOME/nvim/after/indent
mkdir -p $XDG_CONFIG_HOME/nvim/lua
mkdir -p $XDG_CONFIG_HOME/nvim/thesaurus
mkdir -p $XDG_CONFIG_HOME/nvim/spell

# Install Godoctor for vim
if [ ! -d $XDG_CONFIG_HOME/nvim/godoctor.vim ]
  then
    git clone https://github.com/godoctor/godoctor.vim $XDG_CONFIG_HOME/nvim/godoctor.vim
fi

# If no projects configured create an empty file
if [ ! -f $XDG_CONFIG_HOME/nvim/projects.nvimrc ]
  then
    touch $XDG_CONFIG_HOME/nvim/projects.nvimrc
fi

# configuration of different plugins
ln -sf $DOTFILES/nvim/pluggedconf/ $XDG_CONFIG_HOME/nvim/pluggedconf

# configuration of coc
ln -sf $DOTFILES/nvim/coc-settings.json $XDG_CONFIG_HOME/nvim/coc-settings.json

# color schemes
ln -sf $DOTFILES/nvim/colors/* $XDG_CONFIG_HOME/nvim/colors/

# indentation
ln -sf $DOTFILES/nvim/after/indent/* $XDG_CONFIG_HOME/nvim/after/indent/

# lua
ln -sf $DOTFILES/nvim/lua/* $XDG_CONFIG_HOME/nvim/lua/

# snippets
ln -sf $DOTFILES/nvim/ultisnips/* $XDG_CONFIG_HOME/nvim/ultisnips/

# :help ftplugin
ln -sf $DOTFILES/nvim/ftplugin/ $XDG_CONFIG_HOME/nvim/ftplugin

# :help ftdetect
ln -sf $DOTFILES/nvim/ftdetect/ $XDG_CONFIG_HOME/nvim/ftdetect

# :help autoload
ln -sf $DOTFILES/nvim/autoload/* $XDG_CONFIG_HOME/nvim/autoload/

# thesaurus
ln -sf $DOTFILES/nvim/thesaurus/* $XDG_CONFIG_HOME/nvim/thesaurus/

# spell files
ln -sf $DOTFILES/nvim/spell/* $XDG_CONFIG_HOME/nvim/spell/

# projects.nvimrc is installed from the cloud

# installing colorscheme for lightline
ln -sf $DOTFILES/nvim/plugged/lightline.vim/colorscheme/hypnos256.vim \
$XDG_CONFIG_HOME/nvim/plugged/lightline.vim/autoload/lightline/colorscheme/hypnos256.vim
