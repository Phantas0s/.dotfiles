#!/usr/bin/env bash

# save in ps.log the 10 processes which are the most CPU intensives, in order to debug server hang
while true; do (echo "%CPU %MEM ARGS $(date)" && ps -e -o pcpu,pmem,args --sort=pcpu | cut -d" " -f1-5 | tail) >> ps.log; sleep 60; done
