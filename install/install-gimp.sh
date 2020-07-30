for p in $DOTFILES/gimp/*; do
    file=$(basename ${p})
    ln -sf $DOTFILES/gimp/$file $XDG_CONFIG_HOME/GIMP/$GIMP_VERSION
done
