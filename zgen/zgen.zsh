
### zgen
ZGEN_RESET_ON_CHANGE=(${HOME}/.zshrc ${SCRIPT_PATH}/zgen/zgen.zsh)
# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
  echo "Creating a zgen save"

  # Disable loading default Prezto modules
  # This is necessary due to a quirk of zgen that will load these plugins after
  # our custom plugins, overwriting our customizations
  # https://github.com/tarjoilija/zgen/issues/74
  export ZGEN_PREZTO_LOAD_DEFAULT=0

  # prezto options
  zgen prezto editor key-bindings 'vi'
  zgen prezto prompt theme 'thanatos'

  # prezto and modules
  zgen prezto

  # Default plugins
  zgen load sorin-ionescu/prezto modules/environment
  zgen load sorin-ionescu/prezto modules/terminal
  zgen load sorin-ionescu/prezto modules/editor
  zgen load sorin-ionescu/prezto modules/history
  zgen load sorin-ionescu/prezto modules/directory
  # zgen load sorin-ionescu/prezto modules/spectrum
  zgen load sorin-ionescu/prezto modules/utility
  zgen load sorin-ionescu/prezto modules/completion
  zgen load sorin-ionescu/prezto modules/git
  # zgen load sorin-ionescu/prezto modules/prompt

  # Extra plugins
  # zgen load sorin-ionescu/prezto modules/history-substring-search

  # 3rd Party plugins
  zgen load robbyrussell/oh-my-zsh plugins/docker
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-completions

  zgen prezto command-not-found

  zgen load unixorn/autoupdate-zgen
  zgen load zsh-users/zsh-syntax-highlighting
  # zgen load denysdovhan/spaceship-prompt spaceship
  zgen load chauncey-garrett/zsh-prompt-garrett garrett

  # save all to init script
  zgen save
fi
