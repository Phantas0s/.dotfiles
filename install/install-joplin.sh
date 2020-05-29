#!/bin/bash

JOPLIN_CONFIG_DIR=$HOME/.config/joplin/

mkdir -p $JOPLIN_CONFIG_DIR

rm -rf $JOPLIN_CONFIG_DIR/keymap.json

ln -sf $DOTFILES/joplin/* ${JOPLIN_CONFIG_DIR}/
