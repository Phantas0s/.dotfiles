rm -rf "$HOME/.local/lib/deadbeef" && ln -sf "$DOTFILES/deadbeef/plugins" "$HOME/.local/lib/deadbeef"
rm -rf "$XDG_CONFIG_HOME/deadbeef" && ln -sf "$DOTFILES/deadbeef/config" "$XDG_CONFIG_HOME/deadbeef"
