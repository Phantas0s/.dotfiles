mkdir -p $XDG_CONFIG_HOME/mpd
mkdir -p $XDG_CONFIG_HOME/ncmpcpp

ln -sf $DOTFILES/mpd/mpd/mpd.conf $XDG_CONFIG_HOME/mpd/mpd.conf
ln -sf $DOTFILES/mpd/ncmpcpp/config $XDG_CONFIG_HOME/ncmpcpp/config
ln -sf $DOTFILES/mpd/ncmpcpp/bindings $XDG_CONFIG_HOME/ncmpcpp/bindings

ln -sf $CLOUD/dotfiles/mpd/* $XDG_CONFIG_HOME/mpd
