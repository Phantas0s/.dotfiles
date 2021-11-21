#!/usr/bin/env bash

mkdir -p "$XDG_CONFIG_HOME/clojure"
ln -sf "$DOTFILES/clojure/rebel_readline.edn" "$XDG_CONFIG_HOME/clojure"
