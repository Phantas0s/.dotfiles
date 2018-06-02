echo -e "${blue}Installing / Updating motion for Go"

cd $GOPATH/bin
go get -u github.com/fatih/motion
cd -

echo -e "${green}...done\n"
