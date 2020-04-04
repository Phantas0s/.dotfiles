#!/bin/bash

BAT_CONFIG_DIR=$(bat --config-dir)

echo -e "${red}Delete the bat config..."
rm -rf $BAT_CONFIG_DIR
echo -e "${green}...Done!\n"

echo -e "\n${blue}Install bat config..."
mkdir -p $BAT_CONFIG_DIR
ln -sf $DOTFILES/bat/* ${BAT_CONFIG_DIR}/
bat cache --build
echo -e "${green}...Done!\n"
