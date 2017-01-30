echo ""
echo "${red}Delete the actual config..."

echo ""
echo "${red}Delete the i3 config..."

rm -rf $HOME/.config/i3/
rm -rf $HOME/.i3

echo "${green}...done!"

echo ""
echo "${red}Delete the zprezto config..."

rm $HOME/.zlogin
rm $HOME/.zlogout
#rm -rf $HOME/.zprezto
rm $HOME/.zpreztorc
rm $HOME/.zprofile
rm $HOME/.zshenv

echo "${green}...done!"

echo ""
echo "${red}Delete the zsh config..."

rm $HOME/.zshrc

echo ""
echo "${red}Delete the vim config..."

echo "${green}...done!"

rm $HOME/.vim/vimrc

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
echo "${red}Delete the xorg-server config..."

rm $HOME/.Xresources
rm $HOME/.xinitrc

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

