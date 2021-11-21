#!/usr/bin/env bash
FREEMIND_CONFIG_DIR=$HOME/.freemind

mkdir -p $FREEMIND_CONFIG_DIR
ln -sf $DOTFILES/freemind/* $FREEMIND_CONFIG_DIR/
