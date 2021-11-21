#!/usr/bin/env bash

rm "$XDG_CONFIG_HOME/pgcli/config" &>/dev/null
mkdir -p "$XDG_CONFIG_HOME/pgcli"
ln -s "$DOTFILES/pgcli/config" "$XDG_CONFIG_HOME/pgcli/config"
