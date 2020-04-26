#!/bin/bash

REDSHIFT_CONFIG_DIR=$HOME/.config/redshift/

mkdir -p $REDSHIFT_CONFIG_DIR

echo -e "${red}Delete the config for redshift..."
rm -rf $REDSHIFT_CONFIG_DIR/redshift.conf
echo -e "${green}...Done!\n"

echo -e "\n${blue}Install redshift config..."
ln -sf $DOTFILES/redshift/* ${REDSHIFT_CONFIG_DIR}/
echo -e "${green}...Done!\n"
