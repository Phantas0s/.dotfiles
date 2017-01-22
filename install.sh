#!/bin/bash

############
# includes #
############

. install/install_config
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

# install fonts

. $HOME/$ROOT_CONFIG/install/install-fonts.sh

# install i3 configuration

. $HOME/$ROOT_CONFIG/install/install-i3.sh

# TODO: install diff so fancy?

# install prezto
. $HOME/$ROOT_CONFIG/install/install-prezto.sh

## install git config
. $HOME/$ROOT_CONFIG/install/install-git.sh

echo ""
echo "${green}Create symlinks for personnal config..."
echo ""

ln -s $HOME/$ROOT_CONFIG/bash/bashrc $HOME/.bashrc
ln -s $HOME/$ROOT_CONFIG/tmux/tmux.conf $HOME/.tmux.conf
ln -s $HOME/$ROOT_CONFIG/urxvt/Xdefaults $HOME/.Xdefaults
ln -s $HOME/$ROOT_CONFIG/urxvt/autostart/urxvtd.desktop $HOME/.config/autostart/

# install phpstorm symlink

. $HOME/$ROOT_CONFIG/install/install-phpstorm.sh

# install tool softwares
sudo apt-get install arandr
sudo apt-get install keepassx 
