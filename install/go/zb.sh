echo -e "${blue}Installing / Updating zb for Go\n"

cd $GOPATH/bin
go get jrubin.io/zb
go build jrubin.io/zb
cd -

echo -e "${green}...done\n"
