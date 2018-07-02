#!/bin/bash

##################
# install Prezto #
##################

if [ ! -d $HOME/.zprezto ]
  then
    git clone https://github.com/sorin-ionescu/prezto ~/.zprezto
    cd $HOME/.zprezto && git pull && git submodule update --init --recursive
    cd -
fi

echo 'Create symlinks for Prezto...'
ln -s -f $HOME/.zprezto/runcoms/zlogin $HOME/.zlogin
ln -s -f $HOME/.zprezto/runcoms/zlogout $HOME/.zlogout
ln -s -f $DOTFILES/zsh/zprezto/config/zpreztorc $HOME/.zpreztorc
ln -s -f $HOME/.zprezto/runcoms/zprofile $HOME/.zprofile
ln -s -f $HOME/.zprezto/runcoms/zshenv $HOME/.zshenv
ln -s -f $DOTFILES/zsh/zprezto/config/zshrc $HOME/.zshrc

echo 'Create symlinks for personnal prezto themes'
ln -s -f $DOTFILES/zsh/zprezto/themes/prompt_sorin2_setup $HOME/.zprezto/modules/prompt/functions/
ln -s -f $DOTFILES/zsh/zprezto/themes/prompt_garrett_setup $HOME/.zprezto/modules/prompt/functions/
ln -s -f $DOTFILES/zsh/zprezto/themes/prompt_garrett2_setup $HOME/.zprezto/modules/prompt/functions/


