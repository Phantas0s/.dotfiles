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
. $HOME/$ROOT_CONFIG/install/install-from-cloud.sh
. $HOME/$ROOT_CONFIG/install/install-fonts.sh
. $HOME/$ROOT_CONFIG/install/install-i3.sh
. $HOME/$ROOT_CONFIG/install/install-urxvt.sh
. $HOME/$ROOT_CONFIG/install/install-prezto.sh
. $HOME/$ROOT_CONFIG/install/install-git.sh
. $HOME/$ROOT_CONFIG/install/install-nvim.sh
. $HOME/$ROOT_CONFIG/install/install-xorg-server.sh
. $HOME/$ROOT_CONFIG/install/install-tmux.sh
. $HOME/$ROOT_CONFIG/install/install-dunst.sh
. $HOME/$ROOT_CONFIG/install/install-feh.sh
. $HOME/$ROOT_CONFIG/install/install-jrnl.sh
. $HOME/$ROOT_CONFIG/install/install-composer.sh

echo -e "${blue}Create symlinks for .bashrc config..."
ln -s $HOME/$ROOT_CONFIG/bash/bashrc $HOME/.bashrc
echo -e "${green} ...done"

echo -e "${blue}Create symlinks for Xmodmap key mapping...."
ln -s $HOME/$ROOT_CONFIG/xorg-server/Xmodmap $HOME/.Xmodmap
echo -e "${green} ...done"
