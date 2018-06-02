echo -e "${blue}Installing / Updating gocode for Go"

cd $GOPATH/bin
go get -u github.com/nsf/gocode
cd -

echo -e "${green}...done\n"
