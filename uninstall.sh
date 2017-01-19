echo ""
echo "${red}Delete the actual config..."

echo ""
echo "${red}Delete the zprezto config..."

rm $HOME/.zlogin
rm $HOME/.zlogout
rm -rf $HOME/.zprezto
rm $HOME/.zpreztorc
rm $HOME/.zprofile
rm $HOME/.zshenv

echo "${green}...done!"

echo ""
echo "${red}Delete the zsh config..."

rm $HOME/.zshrc

echo "${green}...done!"

echo ""
echo "${red}Delete the tmux config..."

rm $HOME/.tmux.conf

echo "${green}...done!"

echo ""
echo "${red}Delete the bashrc config..."

rm $HOME/.bashrc

echo "${green}...done!"

echo ""
echo "${red}Delete the urxvt config..."

rm $HOME/.Xdefaults
rm $HOME/.config/autostart/urxvtd.desktop

echo "${green}...done!"

echo ""
echo "${red}Delete the git config..."

rm $HOME/.gitconfig

echo "${green}...done!"

