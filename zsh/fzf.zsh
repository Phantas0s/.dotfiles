source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

source $DOTFILES/zsh/scripts_fzf.zsh # fzf Scripts
_fzf_comprun() {
    local command=$1
    shift

    case "$command" in
        cd)           find . -type d | fzf --height 50% --border sharp --margin 5% --preview 'tree -C {} | head -n 10';;
        *)            fzf "$@" ;;
    esac
}

# Search with fzf and open selected file with Vim
# bindkey -s '^v' 'vim $(fzf);^M'
