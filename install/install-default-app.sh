#!/usr/bin/env bash

rm -rf "$XDG_DATA_HOME/applications"
ln -sf "$DOTFILES/default_app/applications" "$XDG_DATA_HOME"
ln -sf "$DOTFILES/default_app/mimeapps.list" "$XDG_CONFIG_HOME/mimeapps.list"
