rm -rf $XDG_CONFIG_HOME/mpd
rm -rf $XDG_CONFIG_HOME/ncmpcpp

mkdir $XDG_CONFIG_HOME/mpd
mkdir $XDG_CONFIG_HOME/ncmpcpp

ln -s $DOTFILES/mpd/mpd/mpd.conf $XDG_CONFIG_HOME/mpd/mpd.conf
ln -s $DOTFILES/mpd/ncmpcpp/config $XDG_CONFIG_HOME/ncmpcpp/config
ln -s $DOTFILES/mpd/ncmpcpp/bindings $XDG_CONFIG_HOME/ncmpcpp/bindings

ln -s $CLOUD/dotfiles/mpd/* $XDG_CONFIG_HOME/mpd
