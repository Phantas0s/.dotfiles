#!/bin/bash

# run ssh-agent and add every keys
if [ -z "$SSH_AUTH_SOCK" ];
then
  eval `ssh-agent -s`
  ssh-add
fi
