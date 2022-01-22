#!/usr/bin/env bash

BAT_CONFIG_DIR=$(bat --config-dir)
rm -rf "$BAT_CONFIG_DIR"

mkdir -p "$BAT_CONFIG_DIR"
ln -s "$DOTFILES/bat/config" "${BAT_CONFIG_DIR}"
ln -s "$DOTFILES/bat/themes" "${BAT_CONFIG_DIR}"
bat cache --build
