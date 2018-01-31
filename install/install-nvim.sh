#!/bin/bash

echo "${blue} installing neovim configuration..."

# install nvim config
ln -sf $HOME/$ROOT_CONFIG/vim/nvimrc $HOME/nvim/init.vim

# installing colorscheme for lightline
ln -sf $HOME/$ROOT_CONFIG/vim/plugged/lightline.vim/colorscheme/hypnos256.vim $HOME/nvim/plugged/lightline.vim/autoload/lightline/colorscheme/hypnos256.vim

ln -sf $HOME/$ROOT_CONFIG/vim/pluggedconf $HOME/nvim/pluggedconf
ln -sf $HOME/$ROOT_CONFIG/vim/colors/* $HOME/nvim/colors
ln -sf $HOME/$ROOT_CONFIG/vim/UltiSnips/* $HOME/nvim/UltiSnips
ln -sf $HOME/$ROOT_CONFIG/vim/after $HOME/nvim/after

if [ ! -d $HOME/nvim ]
  then
    mkdir $HOME/nvim

    # install neovim plugin manager
    curl -fLo ~/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

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

if [ ! -f $HOME/nvim/projects.nvimrc ]
  then
    echo "${blue} installing template project file for neovim"
    cp $HOME/$ROOT_CONFIG/vim/projects.nvimrc $HOME/nvim/projects.nvimrc
fi


echo "${green}...done"
