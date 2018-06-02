echo -e "Installing / Updating gotags for Go\n"
cd $GOPATH/bin
go get -u github.com/jstemmer/gotags
cd -
