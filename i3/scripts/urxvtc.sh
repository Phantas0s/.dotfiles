#!/usr/bin/env bash

urxvtc "$@"
if [ $? -eq 2 ]; then
   urxvtd -q -o -f
   urxvtc "$@"
fi
