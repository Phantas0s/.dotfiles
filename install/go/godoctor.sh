echo -e "${blue}Installing / Updating godoctor for Go\n"

cd $GOPATH/bin
go get -u github.com/godoctor/godoctor
cd -

echo -e "${green}...done\n"
