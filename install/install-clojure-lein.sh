#!/bin/bash

rm -rf $XDG_CONFIG_HOME/.lein &>/dev/null

ln -s $DOTFILES/clojure/lein $HOME/.lein
