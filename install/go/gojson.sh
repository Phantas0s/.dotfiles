# Command line to get a struct from json / yaml
# cat <path_to_yaml> | gojson -fmt=yaml -name=hello
echo -e "${blue}Installing / Updating gojson for Go\n"
go get github.com/ChimeraCoder/gojson/gojson
echo -e "${green}...done\n"
