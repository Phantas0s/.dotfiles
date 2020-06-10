#!/bin/bash

rm $HOME/.zlogin &>/dev/null
rm $HOME/.zlogout &>/dev/null
rm $HOME/.zpreztorc &>/dev/null
rm $HOME/.zprofile &>/dev/null
rm $HOME/.zshenv &>/dev/null
rm $HOME/.zshrc &>/dev/null

if [ ! -d $HOME/.zprezto ]
  then
    git clone https://github.com/sorin-ionescu/prezto ~/.zprezto
    cd $HOME/.zprezto && git pull && git submodule update --init --recursive
    cd -
fi

# ln -s -f $HOME/.zprezto/runcoms/zlogin $HOME/.zlogin
# ln -s -f $HOME/.zprezto/runcoms/zlogout $HOME/.zlogout
ln -s -f $DOTFILES/zsh/zprezto/config/zpreztorc $HOME/.zpreztorc
# ln -s -f $HOME/.zprezto/runcoms/zprofile $HOME/.zprofile
# ln -s -f $HOME/.zprezto/runcoms/zshenv $HOME/.zshenv
ln -s -f $DOTFILES/zsh/zshrc $HOME/.zshrc

ln -s -f $DOTFILES/zsh/zprezto/themes/prompt_thanatos_setup $HOME/.zprezto/modules/prompt/functions/

# From cloud
if [ -f "$DOTFILES_CLOUD/zsh/.zhistory" ];
then
    rm $HOME/.zhistory
    ln -sf $DOTFILES_CLOUD/zsh/.zhistory $HOME/
fi
