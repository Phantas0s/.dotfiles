# rm -rf $XDG_CONFIG_HOME/GIMP/2.10/
# ln -s $DOTFILES/gimp/* $XDG_CONFIG_HOME/GIMP/$GIMP_VERSION

for p in $DOTFILES/gimp/*; do
    file=$(basename ${p})
    rm -rf $XDG_CONFIG_HOME/GIMP/$GIMP_VERSION/$file
    ln -s $DOTFILES/gimp/$file $XDG_CONFIG_HOME/GIMP/$GIMP_VERSION/$file
done
