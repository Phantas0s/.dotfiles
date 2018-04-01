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
echo "${red}Delete the xorg-server config..."
rm $HOME/.Xresources
rm $HOME/.xinitrc
echo "${green}...done!"

echo ""
echo "${red}Delete the urxvt config..."
rm $HOME/.Xdefaults
echo "${green}...done!"

echo ""
echo "${red}Delete the git config..."
rm $HOME/.gitconfig
echo "${green}...done!"

echo ""
echo "${red}Delete the dunst config..."
rm $HOME/.dunstrc
rm -rf $HOME/.autotest
echo "${green}...done!"

echo ""
echo "${red}Delete the tmuxinator config from the cloud..."
rm -rf $HOME/.tmuxinator
echo "${green}...done!"

echo ""
echo "${red}Delete the Xmodmap config..."
rm $HOME/.Xmodmap
echo "${green}...done!"

echo ""
echo "${red}Delete the feh config..."
rm $HOME/.fehbg
echo "${green}...done!"

echo ""
echo "${red}Delete the jrnl config..."
rm -rf $HOME/jrnl
echo "${green}...done!"

echo ""
echo "${red}Delete the composer json file..."
rm $COMPOSER_HOME/composer.json
echo "${green}...done!\n"

echo -e "${red}Delete the wallpaper folder"
rm $HOME/wallpapers
echo -e "${green}...done!\n"

echo -e "${red}Delete neovim config..."
rm $HOME/nvim/pluggedconf
rm $HOME/nvim/colors/*
rm $HOME/nvim/UltiSnips/*
rm $HOME/nvim/ftplugin
rm $HOME/nvim/autoload/*
echo -e "${green}...done!\n"
