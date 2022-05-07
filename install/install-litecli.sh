#!/usr/bin/env bash

rm "$XDG_CONFIG_HOME/litecli/config" &>/dev/null
mkdir -p "$XDG_CONFIG_HOME/litecli"
ln -s "$DOTFILES/litecli/config" "$XDG_CONFIG_HOME/litecli/config"
