echo -e ""
echo -e "${red}Delete clojure lein config..."
rm $HOME/.lein &>/dev/null
echo -e "${green}...done!"

echo -e "${blue} Installing clojure lein config..."
ln -s $DOTFILES/clojure/lein $HOME/.lein
echo -e "${green} ...done"
