echo -e "${blue} Update npm packages..."
npm update -g
echo -e "${green} ...done\n"

echo -e "${blue} Update go packages..."
cd install/go
for f in *.sh; do
    sh "$f" || break
done
cd -
echo -e "${green} ...done\n"
