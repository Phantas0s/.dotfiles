echo -e "Installing/Updating Guru for Go\n"
cd $GOPATH/bin
go get golang.org/x/tools/cmd/guru
go build golang.org/x/tools/cmd/guru
cd -
