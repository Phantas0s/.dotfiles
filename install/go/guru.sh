echo -e "${blue}Installing / Updating Guru for Go\n"

cd $GOPATH/bin
go get -u golang.org/x/tools/cmd/guru
cd -

echo -e "${green}...done\n"
