#!/bin/bash

echo -e "${blue} installing Go environement..."

if [ ! -d $GOPATH/bin ];
then
    mkdir -d $GOPATH/bin
fi

if [ ! -f $GOPATH/bin/guru ];
    then
        echo -e "Installing Guru for Go"
        cd $GOPATH/bin
        go get golang.org/x/tools/cmd/guru
        go build golang.org/x/tools/cmd/guru
        cd -
fi

if [ ! -f $GOPATH/bin/zb ];
    then
        echo -e "Installing zb for Go"
        cd $GOPATH/bin
        go get jrubin.io/zb
        go build jrubin.io/zb
        cd -
fi

echo -e "${green} ...done"
