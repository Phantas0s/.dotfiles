#!/bin/bash

if [ ! -z "$1" ];
then
    ssh-keygen -f $HOME/.ssh/$1 -C "Key $1 added via create-ssh-key script"
fi

