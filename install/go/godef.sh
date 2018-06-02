echo -e "${blue} Installing / Updating godef for Go"

cd $GOPATH/bin
go get -u github.com/rogpeppe/godef
cd -

echo -e "${green}...done\n"
