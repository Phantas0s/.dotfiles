echo -e "${blue}Installing / Updating zb for Go\n"

cd $GOPATH/bin
go get -u jrubin.io/zb
cd -

echo -e "${green}...done\n"
