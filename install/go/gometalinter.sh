echo -e "${blue}Installing / Updating gotags for Go\n"

cd $GOPATH/bin
go get -u gopkg.in/alecthomas/gometalinter.v2
cd -

echo -e "${green}...done\n"
