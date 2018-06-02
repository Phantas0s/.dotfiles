echo -e "Installing delve for Go\n"
cd $GOPATH/bin
go get -u github.com/derekparker/delve/cmd/dlv
cd -
