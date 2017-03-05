echo ""
echo "${blue}Install tmux..."

ln -s $HOME/$ROOT_CONFIG/tmux/tmux.conf $HOME/.tmux.conf

if [ ! -d $HOME/.tmux ]
  then
    mkdir $HOME/.tmux
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

echo "${green} ...done"

