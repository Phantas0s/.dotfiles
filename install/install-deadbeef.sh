# Plugins
rm -rf "$HOME/.local/lib/deadbeef" && ln -sf "$DOTFILES/deadbeef/plugins" "$HOME/.local/lib/deadbeef"

# Config
ln -sf "$DOTFILES/deadbeef/config/config" "$XDG_CONFIG_HOME/deadbeef/config"
ln -sf "$DOTFILES/deadbeef/config/dspconfig" "$XDG_CONFIG_HOME/deadbeef/dspconfig"

# Playlists
rm -rf "$XDG_CONFIG_HOME/deadbeef/playlists" && ln -sf "$CLOUD/multimedia/music/deadbeef/playlists" "$XDG_CONFIG_HOME/deadbeef/playlists"
