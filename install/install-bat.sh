#!/bin/bash

BAT_CONFIG_DIR=$(bat --config-dir)
rm -rf "$BAT_CONFIG_DIR"

mkdir -p "$BAT_CONFIG_DIR"
ln -sf "$DOTFILES/bat/*" "${BAT_CONFIG_DIR}/"
bat cache --build
