echo -e "${blue}Installing / Updating testomatic \n"

cd $GOPATH/bin
go get -u github.com/Phantas0s/testomatic
cd -

echo -e "${green}...done\n"
