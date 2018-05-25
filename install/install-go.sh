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

if [ ! -f $GOPATH/bin/gocode ];
    then
        echo -e "Installing gocode for Go"
        cd $GOPATH/bin
        go get -u github.com/nsf/gocode
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

if [ ! -f $GOPATH/bin/gotags ];
    then
        echo -e "Installing gotags for Go"
        cd $GOPATH/bin
        go get -u github.com/jstemmer/gotags
        cd -
fi

if [ ! -f $GOPATH/bin/godef ];
    then
        echo -e "Installing godef for Go"
        cd $GOPATH/bin
        go get -u github.com/rogpeppe/godef
        cd -
fi

if [ ! -f $GOPATH/bin/dlv ];
    then
        echo -e "Installing delve for Go"
        cd $GOPATH/bin
        go get -u github.com/derekparker/delve/cmd/dlv
        cd -
fi

echo -e "${green} ...done"
