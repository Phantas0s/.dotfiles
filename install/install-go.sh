#!/bin/bash
# TODO to refactor - parsing a list instead of those if everywhere...

echo -e "${blue} installing Go environement..."

mkdir -p $GOPATH/bin

### Quality tools

# guru: a tool for answering questions about Go source code.
if [ ! -f $GOPATH/bin/guru ];
then
    sh ./install/go/guru.sh
fi

# An autocompletion daemon for the Go programming language
if [ ! -f $GOPATH/bin/gocode ];
then
    sh ./install/go/gocode.sh
fi

# Detect ineffectual assignments in Go code.
if [ ! -f $GOPATH/bin/ineffassign ];
then
    sh ./install/go/ineffassign.sh
fi

# megacheck runs staticcheck, gosimple and unused at once.
if [ ! -f $GOPATH/bin/megacheck ];
then
    sh ./install/go/megacheck.sh
fi

# A linter that suggests interface types.
if [ ! -f $GOPATH/bin/interfacer ];
then
    sh ./install/go/interfacer.sh
fi


# Inspects source code for security problems by scanning the Go AST.
if [ ! -f $GOPATH/bin/gas ];
then
    sh ./install/go/gas.sh
fi

# Golint is a linter for Go source code.
if [ ! -f $GOPATH/bin/golint ];
then
    sh ./install/go/golint.sh
fi

# Find repeated strings that could be replaced by a constant.
if [ ! -f $GOPATH/bin/goconst ];
then
    sh ./install/go/goconst.sh
fi

# Navigation and insight in Go
if [ ! -f $GOPATH/bin/motion ];
then
    sh ./install/go/motion.sh
fi

# an opinionated repo based tool for linting, testing and building go source
if [ ! -f $GOPATH/bin/zb ];
then
    sh ./install/go/zb.sh
fi

# Concurrently run Go lint tools and normalise their output
if [ ! -f $GOPATH/bin/gometalinter ];
then
    sh ./install/go/gometalinter.sh
fi

# ctags-compatible tag generator for Go
if [ ! -f $GOPATH/bin/gotags ];
then
    sh ./install/go/gotags.sh
fi

# Print where symbols are defined in Go source code
if [ ! -f $GOPATH/bin/godef ];
then
    sh ./install/go/godef.sh
fi

### Debugger

if [ ! -f $GOPATH/bin/dlv ];
then
    sh ./install/go/dlv.sh
fi

### Refactoring

if [ ! -f $GOPATH/bin/godoctor ];
then
    sh ./install/go/godoctor.sh
fi

### Projects

if [ ! -f $GOPATH/bin/testomatic ];
then
    sh ./install/go/testomatic.sh
fi

echo -e "${green} ...done\n"
