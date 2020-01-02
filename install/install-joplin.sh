#!/bin/bash

JOPLIN_CONFIG_DIR=$HOME/.config/joplin/

mkdir -p JOPLIN_CONFIG_DIR

echo -e "${red}Delete the keymap for Joplin..."
rm -rf $JOPLIN_CONFIG_DIR/keymap.json
echo -e "${green}...Done!\n"

echo -e "\n${blue}Install Joplin config..."
ln -sf $DOTFILES/joplin/* ${JOPLIN_CONFIG_DIR}/
echo -e "${green}...Done!\n"
