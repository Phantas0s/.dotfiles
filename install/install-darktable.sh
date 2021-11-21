#!/usr/bin/env bash

# Install lua scripts
[ ! -d "$XDG_CONFIG_HOME/darktable/lua" ] && git clone https://github.com/darktable-org/lua-scripts.git "$XDG_CONFIG_HOME/darktable/lua"

ln -sf "$CLOUD/multimedia/photo/darktable/library.db" "$XDG_CONFIG_HOME/darktable/library.db"
ln -sf "$DOTFILES/darktable/darktablerc" "$XDG_CONFIG_HOME/darktable/darktablerc"
ln -sf "$DOTFILES/darktable/keyboardrc" "$XDG_CONFIG_HOME/darktable/keyboardrc"
ln -sf "$DOTFILES/darktable/data.db" "$XDG_CONFIG_HOME/darktable/data.db"
ln -sf "$DOTFILES/darktable/luarc" "$XDG_CONFIG_HOME/darktable/luarc"
