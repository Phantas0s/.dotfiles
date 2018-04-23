echo -e ""
echo -e "${red}Delete the actual config..."

echo -e ""
echo -e "${red}Delete the i3 config..."
rm -rf $HOME/.config/i3/ &>/dev/null
rm -rf $HOME/.i3 &>/dev/null
echo -e "${green}...done!"

echo -e ""
echo -e "${red}Delete the zprezto config..."
rm $HOME/.zlogin &>/dev/null
rm $HOME/.zlogout &>/dev/null
rm $HOME/.zpreztorc &>/dev/null
rm $HOME/.zprofile &>/dev/null
rm $HOME/.zshenv &>/dev/null
echo -e "${green}...done!"

echo -e ""
echo -e "${red}Delete the zsh config..."
rm $HOME/.zshrc &>/dev/null
echo -e "${green}...done!"

echo -e ""
echo -e "${red}Delete the scripts..."
rm $HOME/scripts &>/dev/null
echo -e "${green}...done!"

echo -e ""
echo -e "${red}Delete the tmux config..."
rm $HOME/.tmux.conf &>/dev/null
echo -e "${green}...done!"

echo -e ""
echo -e "${red}Delete the bashrc config..."
rm $HOME/.bashrc &>/dev/null
echo -e "${green}...done!"

echo -e ""
echo -e "${red}Delete the ranger config..."
rm -rf $HOME/ranger &>/dev/null
echo -e "${green}...done!"

echo -e ""
echo -e "${red}Delete the xorg-server config..."
rm $HOME/.Xresources &>/dev/null
rm $HOME/.xinitrc &>/dev/null
echo -e "${green}...done!"

echo -e ""
echo -e "${red}Delete the urxvt config..."
rm $HOME/.Xdefaults &>/dev/null
rm $HOME/.dircolors
echo -e "${green}...done!"

echo -e ""
echo -e "${red}Delete the git config..."
rm $HOME/.gitconfig &>/dev/null
echo -e "${green}...done!"

echo -e ""
echo -e "${red}Delete the dunst config..."
rm $HOME/.dunstrc &>/dev/null
rm -rf $HOME/.autotest &>/dev/null
echo -e "${green}...done!"

echo -e ""
echo -e "${red}Delete the tmuxinator config from the cloud..."
rm -rf $HOME/.tmuxinator &>/dev/null
echo -e "${green}...done!"

echo -e ""
echo -e "${red}Delete the Xmodmap config..."
rm $HOME/.Xmodmap &>/dev/null
echo -e "${green}...done!"

echo -e ""
echo -e "${red}Delete the wallpapers folder..."
rm -rf $HOME/wallpapers
echo -e "${green}...done!"

echo -e ""
echo -e "${red}Delete the feh config..."
rm $HOME/.fehbg &>/dev/null
echo -e "${green}...done!"

echo -e ""
echo -e "${red}Delete the jrnl config..."
rm -rf $HOME/jrnl &>/dev/null
echo -e "${green}...done!"

echo -e ""
echo -e "${red}Delete the composer json file..."
rm $COMPOSER_HOME/composer.json &>/dev/null
echo -e "${green}...done!\n"

echo -e "${red}Delete the wallpaper folder"
rm $HOME/wallpapers &>/dev/null
echo -e "${green}...done!\n"

echo -e "${red}Delete neovim config..."
rm $HOME/nvim/pluggedconf &>/dev/null
rm $HOME/nvim/colors/* &>/dev/null
rm $HOME/nvim/UltiSnips/* &>/dev/null
rm $HOME/nvim/ftplugin &>/dev/null
rm $HOME/nvim/autoload/* &>/dev/null
echo -e "${green}...done!\n"

echo -e ""
echo -e "${red}Delete the mycli config..."
rm $HOME/.myclirc &>/dev/null
echo -e "${green}...done!"

