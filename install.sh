#!/bin/bash

############
# includes #
############

. ./install_config
. $HOME/$ROOT_CONFIG/colors

################
# presentation #
################

echo ""
echo "${light_gray}######################################"
echo "${light_gray}# Welcome to my installation script! #"
echo "${light_gray}######################################"
echo ""

echo "${yellow}!${red}WARNING${yellow}!"
echo "${light_red}This script will delete all your configuration!"
echo "${light_red}Use it if you know what you are doing..."
echo "${light_red}Press a key to continue..."
read key;

###########
# INSTALL #
###########

# Uninstall everything 
# TODO: let the choice to backup :D
. $HOME/$ROOT_CONFIG/uninstall.sh

# install project config from private cloud
. $HOME/$ROOT_CONFIG/install/install-from-cloud.sh

# install fonts
. $HOME/$ROOT_CONFIG/install/install-fonts.sh

# install i3 configuration
. $HOME/$ROOT_CONFIG/install/install-i3.sh

# install prezto
. $HOME/$ROOT_CONFIG/install/install-prezto.sh

# install git config
. $HOME/$ROOT_CONFIG/install/install-git.sh

# install neovim 
. $HOME/$ROOT_CONFIG/install/install-nvim.sh

# install xressource config
. $HOME/$ROOT_CONFIG/install/install-xorg-server.sh

# install tmux config
. $HOME/$ROOT_CONFIG/install/install-tmux.sh

echo "${blue}Create symlinks for personnal config..."

ln -s $HOME/$ROOT_CONFIG/bash/bashrc $HOME/.bashrc
ln -s $HOME/$ROOT_CONFIG/urxvt/Xdefaults $HOME/.Xdefaults
ln -s $HOME/$ROOT_CONFIG/xorg-server/Xmodmap $HOME/.Xmodmap

echo "${green} ...done"

# install phpstorm symlink
. $HOME/$ROOT_CONFIG/install/install-phpstorm.sh
