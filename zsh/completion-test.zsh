# Define completers
zstyle ':completion:*' completer _extensions _complete _match _approximate

# Use cache for commands using cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

# SEE ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zle -C alias-expension complete-word _generic
bindkey '^A' alias-expension
zstyle ':completion:alias-expension:*' completer _expand_alias

# Insert all matches - works after completion
# zle -C all-matches complete-word _generic
# bindkey '^Xa' all-matches
# zstyle ':completion:all-matches:*' old-matches only
# zstyle ':completion:all-matches::::' completer _all_matches

# zstyle ':completion:*' completer _complete _match _approximate

# Verbose makes the completion more verbose (add description for option)
zstyle ':completion:*' verbose yes

# Use cache for commands which use it

# Allow you to select in a menu
zstyle ':completion:*' menu select

# zstyle ':completion:*' complete true
# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true

zstyle ':completion:*' file-sort modification

zstyle ':completion:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:descriptions' format '%F{blue}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
# zstyle ':completion:*:default' list-prompt '%S%M matches%s'
# # Required for completion to be in good groups (named after the tags)
# zstyle ':completion:*' group-name ''

zstyle ':completion:*' ignore-line other
zstyle ':completion:*' keep-prefix true
zstyle ':completion:*' squeeze-slashes true

# Doesn't work???
# zstyle ':completion:*:*:lynx:*:*' group-order urls file

# zstyle ':completion:*:*:-command-:*:commands' \
#     group-name LILILILI
# zstyle ':completion:*:*:-command-:*:functions' \
#     group-name LOLOLO
# zstyle ':completion:*:*:-command-:*:builtins' \
#     group-name LALAAL

# ???
# zstyle ':completion:*' global true

#??? Apparently works with substitle style???
# zstyle ':completion:*' glob false

zstyle ':completion:*' force-list always

# Complete files / directory with many details
# zstyle ':completion:*' file-list true
# zstyle ':completion:*' file-list list=5 insert=5

# complete first sh files and then
# zstyle ':completion:*:rm:*' file-patterns '*.sh:script-files' '%p:all-files'
# zstyle ':completion:*:rm:*' file-patterns all-files
# ???
# zstyle ':completion:*' file-patterns '%p:globbed-files' '*(-/):directories' '*:all-files'

# ????
# zstyle ':completion::complete:cd:*' tag-order \
# 'named-directories:-mine:extra\ directories
# named-directories:-normal:named\ directories *'
# zstyle ':completion::complete:cd:*:named-directories-mine' \
# fake-always /home/hypnos/Documents/Project /home/hypnos/Documents/backups
# zstyle ':completion::complete:cd:*:named-directories-mine' \
# ignored-patterns '*'
