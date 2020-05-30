#!/bin/bash

if [ ! -f $XDG_CONFIG_HOME/.fzf.zsh ];
then
    sh $XDG_CONFIG_HOME/.fzf/install > /dev/null
fi
