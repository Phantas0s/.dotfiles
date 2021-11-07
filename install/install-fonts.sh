#!/bin/bash
# see https://github.com/ryanoasis/nerd-fonts#patched-fonts for many fonts

[ ! -d "$DOTFILES/fonts/fonts" ] && ln -s "$DOTFILES/fonts/fonts" "$XDG_DATA_HOME"
ln -sf "$DOTFILES/fonts/fontconfig" "$XDG_CONFIG_HOME"
