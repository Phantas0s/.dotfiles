#!/usr/bin/env bash

# Plugins
mkdir -p $HOME/.local/lib
rm -rf "$HOME/.local/lib/deadbeef" && ln -sf "$DOTFILES/deadbeef/plugins" "$HOME/.local/lib/deadbeef"

# Config
# Can't only synchronize the files - deadbeef automatically delete the symbolic link and create a proper file.
rm -rf "$XDG_CONFIG_HOME/deadbeef" && ln -sf "$DOTFILES/deadbeef/config" "$XDG_CONFIG_HOME/deadbeef"

# Playlists
rm -rf "$XDG_CONFIG_HOME/deadbeef/playlists" && ln -sf "$HOME/Music/playlists" "$XDG_CONFIG_HOME/deadbeef/playlists"
