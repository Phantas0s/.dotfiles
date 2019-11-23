
### zgen
ZGEN_RESET_ON_CHANGE=(${HOME}/.zshrc ${SCRIPT_PATH}/zgen/zgen.zsh)

# if the init scipt doesn't exist
if ! zgen saved; then
echo "Creating a zgen save"
    # prezto options
    zgen prezto editor key-bindings 'vi'
    zgen prezto prompt theme 'sorin'

    # prezto and modules
    zgen prezto
    zgen prezto history
    zgen prezto directory
    zgen prezto utility
    zgen prezto git
    zgen prezto history-substring-search
    zgen prezto completion
    zgen prezto command-not-found
    zgen prezto syntax-highlighting


    # completions
    zgen load zsh-users/zsh-completions src

    # save all to init script
    zgen save
fi

