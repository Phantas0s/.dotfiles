#!/usr/bin/env bash

# From cloud
ln -sf "$DOTFILES_CLOUD/tmuxp" "$XDG_CONFIG_HOME"

if [ ! -d "$XDG_CONFIG_HOME/tmux" ]
  then
    mkdir "$XDG_CONFIG_HOME/tmux"
    git clone https://github.com/tmux-plugins/tpm "$XDG_CONFIG_HOME/tmux/plugins/tpm"
    "$XDG_CONFIG_HOME/tmux/plugins/tpm/bin/install_plugins"
fi

ln -sf "$DOTFILES/tmux/tmux.conf" "$XDG_CONFIG_HOME/tmux"

# Generate default tmux conf
# tmux -f /dev/null show-options -s \; show-options -g \; list-keys > "$DOTFILES/tmux/tmux.defaults.conf"

if [ ! -d "$XDG_CONFIG_HOME/tmux/plugins/tpm" ]
then
    git clone https://github.com/tmux-plugins/tpm "$XDG_CONFIG_HOME/tmux/plugins/tpm"
fi

