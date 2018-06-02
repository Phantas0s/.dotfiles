echo -e "${blue} Update npm packages..."

if [ ! -d $NPMBIN/bin ];
then
    npm update -g
fi

echo -e "${green} ...done\n"
