#!/usr/bin/env bash

ln -sf "$DOTFILES/devdash" "$XDG_CONFIG_HOME"
\cp "$DOTFILES_CLOUD"/devdash/*.json "$XDG_CONFIG_HOME/devdash"
