#!/bin/bash

# Install guru
if [ ! -f $HOME/workspace/go/bin/guru ];
    then
        echo -e "Installing Guru for Go"
        cd $GOPATH/bin
        go get -u golang.org/x/tools/cmd/guru
        go build golang.org/x/tools/cmd/guru
        cd -
fi
