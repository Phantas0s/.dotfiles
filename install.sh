#!/bin/bash

#############
# variables #
#############

ROOT_CONFIG=".terminal_config"

########################
# uninstall everything #
########################

echo 'uninstall...'
sh $HOME/.terminal_config/uninstall.sh

#########################
# install diff-so-fancy #
#########################

npm install -g diff-so-fancy

##################
# install Prezto #
##################

git clone git@github.com:sorin-ionescu/prezto ~/.zprezto
cd $HOME/.zprezto && git pull && git submodule update --init --recursive
cd -

###################
# Create symlinks #
###################

echo 'Installing git config... \n'
rm $HOME/.terminal_config/git/gitconfig
cp $HOME/.terminal_config/git/gitconfig_template $HOME/.terminal_config/git/gitconfig

echo -n "Git config - Please enter your email address \n"
echo -n "> "
read answer

sed -i -e 's/<email>/'"$answer"'/g' $HOME/.terminal_config/git/gitconfig

echo -n "Git config - Please enter your name \n"
echo -n "> "
read answer

sed -i -e 's/<name>/'"$answer"'/g' $HOME/.terminal_config/git/gitconfig

echo 'Create symlink for gitconfig...'

ln -s -f $HOME/$ROOT_CONFIG/git/gitconfig $HOME/.gitconfig

echo 'Create symlinks for Prezto...'
ln -s -f $HOME/.zprezto/runcoms/zlogin $HOME/.zlogin
ln -s -f $HOME/.zprezto/runcoms/zlogout $HOME/.zlogout
ln -s -f $HOME/$ROOT_CONFIG/zsh/zprezto/config/zpreztorc $HOME/.zpreztorc
ln -s -f $HOME/.zprezto/runcoms/zprofile $HOME/.zprofile
ln -s -f $HOME/.zprezto/runcoms/zshenv $HOME/.zshenv
ln -s -f $HOME/$ROOT_CONFIG/zsh/zprezto/config/zshrc $HOME/.zshrc

echo 'Create symlinks for personnal config...'

ln -s -f $HOME/$ROOT_CONFIG/bash/bashrc $HOME/.bashrc
ln -s -f $HOME/$ROOT_CONFIG/tmux/tmux.conf $HOME/.tmux.conf
ln -s -f $HOME/$ROOT_CONFIG/urxvt/Xdefaults $HOME/.Xdefaults
ln -s -f $HOME/$ROOT_CONFIG/urxvt/autostart/urxvtd.desktop $HOME/.config/autostart/

echo 'Create symlinks for personnal prezto themes'

ln -s -f $HOME/$ROOT_CONFIG/zsh/zprezto/themes/prompt_sorin2_setup $HOME/.zprezto/modules/prompt/functions/
ln -s -f $HOME/$ROOT_CONFIG/zsh/zprezto/themes/prompt_garrett_setup $HOME/.zprezto/modules/prompt/functions/
ln -s -f $HOME/$ROOT_CONFIG/zsh/zprezto/themes/prompt_garrett2_setup $HOME/.zprezto/modules/prompt/functions/

