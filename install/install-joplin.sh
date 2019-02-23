#!/bin/bash

JOPLIN_CONFIG_DIR=$HOME/.config/joplin/

if [ ! -d JOPLIN_CONFIG_DIR ]
  then
    mkdir JOPLIN_CONFIG_DIR
fi


echo -e "${red}Delete the keymap for Joplin..."
rm -rf $JOPLIN_CONFIG_DIR/keymap.json
echo -e "${green}...Done!\n"

echo -e "\n${blue}Install Joplin config..."
ln -sf $DOTFILES/joplin/* ${JOPLIN_CONFIG_DIR}/
echo -e "${green}...Done!\n"
