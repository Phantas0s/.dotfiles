echo -e "${blue}Installing / Updating gometalinter for Go\n"
go get -u gopkg.in/alecthomas/gometalinter.v2
cd $GOPATH/bin
mv gometalinter.v2 gometalinter
cd -
echo -e "${green}...done\n"
