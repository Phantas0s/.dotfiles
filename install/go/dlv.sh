echo -e "${blue}Installing / Updating delve for Go"

cd $GOPATH/bin
go get -u github.com/derekparker/delve/cmd/dlv
cd -

echo -e "${green}...done\n"
