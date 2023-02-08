#!/usr/bin/env zsh

source /usr/share/fzf/key-bindings.zsh

# Rebind ALT-c to CTRL-e
bindkey -rM emacs '\ec'
bindkey -rM vicmd '\ec'
bindkey -rM viins '\ec'

zle     -N            fzf-cd-widget
bindkey -M emacs '^e' fzf-cd-widget
bindkey -M vicmd '^e' fzf-cd-widget
bindkey -M viins '^e' fzf-cd-widget

# zle     -N   fzf-completion
# bindkey '^e' fzf-completion

source /usr/share/fzf/completion.zsh

source $DOTFILES/zsh/scripts_fzf.zsh # fzf Scripts
# _fzf_comprun() {
#     local command=$1
#     shift

#     case "$command" in
#         cd)           find . -type d | fzf --height 50% --border sharp --margin 5% --preview 'tree -C {} | head -n 10' "$@";;
#         *)            fzf "$@" ;;
#     esac
# }

# Search with fzf and open selected file with Vim
# bindkey -s '^v' 'vim $(fzf);^M'

_fzf_compgen_path() {
    rg --files --glob "!.git" "$1"
}

_fzf_compgen_dir() {
   fd --type d --hidden --follow --exclude ".git" "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    tree)           find . -type d | fzf --height 50% --border sharp --preview 'tree -C {}' "$@";;
    *)            fzf "$@" ;;
  esac
}
