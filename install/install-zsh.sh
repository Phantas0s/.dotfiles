#!/usr/bin/env bash

mkdir -p "$ZDOTDIR"

ln -sf "$DOTFILES/zsh/zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/zsh/zshrc" "$ZDOTDIR/.zshrc"

ln -sf "$DOTFILES/zsh/dircolors" "$ZDOTDIR/dircolors"

