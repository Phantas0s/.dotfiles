#!/usr/bin/env bash

mkdir -p "$XDG_CONFIG_HOME/ghostty"
ln -sf "$DOTFILES/ghostty/config" "$XDG_CONFIG_HOME/ghostty/config"
