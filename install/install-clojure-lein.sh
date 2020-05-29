#!/bin/bash

rm -rf $HOME/.lein &>/dev/null

ln -s $DOTFILES/clojure/lein $HOME/.lein
