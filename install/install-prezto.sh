#!/bin/bash

##################
# install Prezto #
##################

git clone git@github.com:sorin-ionescu/prezto ~/.zprezto
cd $HOME/.zprezto && git pull && git submodule update --init --recursive
cd -


echo 'Create symlinks for personnal prezto themes'

ln -s -f $HOME/$ROOT_CONFIG/zsh/zprezto/themes/prompt_sorin2_setup $HOME/.zprezto/modules/prompt/functions/
ln -s -f $HOME/$ROOT_CONFIG/zsh/zprezto/themes/prompt_garrett_setup $HOME/.zprezto/modules/prompt/functions/
ln -s -f $HOME/$ROOT_CONFIG/zsh/zprezto/themes/prompt_garrett2_setup $HOME/.zprezto/modules/prompt/functions/


