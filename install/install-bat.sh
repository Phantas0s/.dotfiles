#!/bin/bash

echo ""
echo "${blue}Install bat config..."

BAT_CONFIG_DIR=$(bat --config-dir)

mkdir -p $BAT_CONFIG_DIR
ln -sf $DOTFILES/bat/* ${BAT_CONFIG_DIR}/


