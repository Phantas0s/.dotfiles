echo -e "Installing zb for Go\n"
cd $GOPATH/bin
go get jrubin.io/zb
go build jrubin.io/zb
cd -
