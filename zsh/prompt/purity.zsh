# Purity
# by Kevin Lanni
# https://github.com/therealklanni/purity
# MIT License

# For my own and others sanity
# git:
# %b => current branch
# %a => current action (rebase/merge)
# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)

# turns seconds into human readable time
# 165392 => 1d 21h 56m 32s

prompt_purity_human_time() {
    local tmp=$1
    local days=$(( tmp / 60 / 60 / 24 ))
    local hours=$(( tmp / 60 / 60 % 24 ))
    local minutes=$(( tmp / 60 % 60 ))
    local seconds=$(( tmp % 60 ))
    echo -n " "
    (( $days > 0 )) && echo -n "${days}d "
    (( $hours > 0 )) && echo -n "${hours}h "
    (( $minutes > 0 )) && echo -n "${minutes}m "
    echo "${seconds}s"
}

# displays the exec time of the last command if set threshold was exceeded
prompt_purity_cmd_exec_time() {
    local stop=$EPOCHSECONDS
    local start=${cmd_timestamp:-$stop}
    integer elapsed=$stop-$start
    (($elapsed > ${PURITY_CMD_MAX_EXEC_TIME:=5})) && prompt_purity_human_time $elapsed
}

prompt_purity_preexec() {
    cmd_timestamp=$EPOCHSECONDS

    # shows the current dir and executed command in the title when a process is active
    print -Pn "\e]0;"
    echo -nE "$PWD:t: $2"
    print -Pn "\a"
}

# string length ignoring ansi escapes
prompt_purity_string_length() {
    echo ${#${(S%%)1//(\%([KF1]|)\{*\}|\%[Bbkf])}}
}

prompt_purity_precmd() {
    # shows the full path in the title
    # print -Pn '\e]0;%~\a'

    # local prompt_purity_preprompt="%c$(git_prompt_info) $(git_prompt_status)"
    print -P ' %F{yellow}`prompt_purity_cmd_exec_time`%f'

    # check async if there is anything to pull
    (( ${PURITY_GIT_PULL:-1} )) && {
        # check if we're in a git repo
        command git rev-parse --is-inside-work-tree &>/dev/null &&
        # check check if there is anything to pull
        command git fetch &>/dev/null &&
        # check if there is an upstream configured for this branch
        command git rev-parse --abbrev-ref @'{u}' &>/dev/null &&
        (( $(command git rev-list --right-only --count HEAD...@'{u}' 2>/dev/null) > 0 )) &&
        # some crazy ansi magic to inject the symbol into the previous line
        print -Pn "%F{cyan}⇣%f"
    } &!

    # reset value since `preexec` isn't always triggered
    unset cmd_timestamp
}

zle-line-init zle-keymap-select() {
    case ${KEYMAP} in
        (vicmd)      PROMPT='%F{white}%~ %B%F{red}<%F{magenta}<%F{yellow}<%f%b ' ;;
        (main|viins) PROMPT=$'%F{white}%~ %B%F{white}>%F{green}>%F{blue}>%f%b ' ;;
        (*)          PROMPT=$'%F{white}%~ %B%F{white}>%F{green}>%F{blue}>%f%b ' ;;
    esac

    zle reset-prompt
}


prompt_purity_setup() {
    # prevent percentage showing up
    # if output doesn't end with a newline
    export PROMPT_EOL_MARK=''

    prompt_opts=(cr subst percent)

    zmodload zsh/datetime
    autoload -Uz vcs_info
    precmd_vcs_info() { vcs_info }
    precmd_functions+=( precmd_vcs_info )
    setopt prompt_subst
    zstyle ':vcs_info:git:*' formats '%b'

    add-zsh-hook precmd prompt_purity_precmd
    add-zsh-hook preexec prompt_purity_preexec

    # show username@host if logged in through SSH
    [[ "$SSH_CONNECTION" != '' ]] && prompt_purity_username='%n@%m '

    ZSH_THEME_GIT_PROMPT_PREFIX=" %F{yellow}λ:%f%F{blue}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%b"
    ZSH_THEME_GIT_PROMPT_DIRTY=""
    ZSH_THEME_GIT_PROMPT_CLEAN=""

    ZSH_THEME_GIT_PROMPT_ADDED="%F{green}+%f "
    ZSH_THEME_GIT_PROMPT_MODIFIED="%F{blue}%f "
    ZSH_THEME_GIT_PROMPT_DELETED="%F{red}x%f "
    ZSH_THEME_GIT_PROMPT_RENAMED="%F{magenta}➜%f "
    ZSH_THEME_GIT_PROMPT_UNMERGED="%F{yellow}═%f "
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{white}%f "
    ZSH_THEME_GIT_PROMPT_STASHED="%B%F{red}!S!%f%b "

    RPROMPT='$(git_prompt_info) $(git_prompt_status)'
    zle -N zle-line-init
    zle -N zle-keymap-select
}

prompt_purity_setup "$@"
