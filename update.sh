sudo echo "Activate sudo"
echo -e "${blue} Update npm packages..."
npm install -g npm
npm update -g
echo -e "${green} ...done\n"

#---------------------------------------

echo -e "${blue} Update composer global packages..."
sudo composer self-update
cgr update
echo -e "${green} ...done\n"

#---------------------------------------

echo -e "${blue} Update go packages..."
cd $DOTFILES/install/go
for f in *.sh; do
    sh "$f"
done
cd -
echo -e "${green} ...done\n"

#---------------------------------------

echo -e "${blue} Update neovim plugins..."
# Update all the plugins
nvim --noplugin +PlugUpdate +qa
echo -e "${green} ...done\n"

#---------------------------------------

echo -e "${blue} Update tmux plugins..."
$HOME/.tmux/plugins/tpm/bin/update_plugins all
echo -e "${green} ...done\n"
