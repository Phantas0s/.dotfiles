#!/bin/bash

rm $VIMCONFIG/pluggedconf &>/dev/null
rm $VIMCONFIG/colors/* &>/dev/null
rm $VIMCONFIG/ftplugin &>/dev/null
rm $VIMCONFIG/autoload/* &>/dev/null


# Create all necessary folder for neovim
if [ ! -d $VIMCONFIG ]
  then
    mkdir $VIMCONFIG

    # install neovim plugin manager
    curl -fLo ~/.dotfiles/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# From Cloud
ln -sf $DOTFILES_CLOUD/projects.nvimrc $VIMCONFIG/

# install vim session folder
mkdir -p $VIMCONFIG/sessions

# install nvim config
ln -sf $DOTFILES/nvim/init.vim $VIMCONFIG/init.vim

# Install all mandatory folders if they don't exist already
mkdir -p $VIMCONFIG/plugged
mkdir -p $VIMCONFIG/colors
mkdir -p $VIMCONFIG/ultisnips
mkdir -p $VIMCONFIG/autoload
mkdir -p $VIMCONFIG/backup
mkdir -p $VIMCONFIG/undo
mkdir -p $VIMCONFIG/swap
mkdir -p $VIMCONFIG/after/indent
mkdir -p $VIMCONFIG/lua
mkdir -p $VIMCONFIG/thesaurus
mkdir -p $VIMCONFIG/spell

# Install Godoctor for vim
if [ ! -d $VIMCONFIG/godoctor.vim ]
  then
    git clone https://github.com/godoctor/godoctor.vim $VIMCONFIG/godoctor.vim
fi

# If no projects configured create an empty file
if [ ! -f $VIMCONFIG/projects.nvimrc ]
  then
    touch $VIMCONFIG/projects.nvimrc
fi

# configuration of different plugins
ln -sf $DOTFILES/nvim/pluggedconf/ $VIMCONFIG/pluggedconf

# configuration of coc
ln -sf $DOTFILES/nvim/coc-settings.json $VIMCONFIG/coc-settings.json

# color schemes
ln -sf $DOTFILES/nvim/colors/* $VIMCONFIG/colors/

# indentation
ln -sf $DOTFILES/nvim/after/indent/* $VIMCONFIG/after/indent/

# lua
ln -sf $DOTFILES/nvim/lua/* $VIMCONFIG/lua/

# snippets
ln -sf $DOTFILES/nvim/ultisnips/* $VIMCONFIG/ultisnips/

# :help ftplugin
ln -sf $DOTFILES/nvim/ftplugin/ $VIMCONFIG/ftplugin

# :help ftdetect
ln -sf $DOTFILES/nvim/ftdetect/ $VIMCONFIG/ftdetect

# :help autoload
ln -sf $DOTFILES/nvim/autoload/* $VIMCONFIG/autoload/

# thesaurus
ln -sf $DOTFILES/nvim/thesaurus/* $VIMCONFIG/thesaurus/

# spell files
ln -sf $DOTFILES/nvim/spell/* $VIMCONFIG/spell/

# projects.nvimrc is installed from the cloud

# TODO crash when lightline pluggin is not installed...
# installing colorscheme for lightline
ln -sf $DOTFILES/nvim/plugged/lightline.vim/colorscheme/hypnos256.vim \
$VIMCONFIG/plugged/lightline.vim/autoload/lightline/colorscheme/hypnos256.vim
