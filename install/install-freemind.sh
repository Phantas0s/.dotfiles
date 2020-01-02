FREEMIND_CONFIG_DIR=$HOME/.freemind

echo -e "${red}Delete freemind's config..."
rm -rf $FREEMIND_CONDIG_DIR/auto.properties
rm -rf $FREEMIND_CONDIG_DIR/patterns.xml
echo -e "${green}...Done!\n"

echo -e "\n${blue}Install freemind's config..."
mkdir -p $FREEMIND_CONFIG_DIR
ln -sf $DOTFILES/freemind/* $FREEMIND_CONFIG_DIR/
echo -e "${green}...Done!\n"
