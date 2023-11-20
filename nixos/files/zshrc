key[Backspace]="${terminfo[kbs]}"
[[ -n "{key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char

### Bindings
function foreground-last-job () {
    if (( ${#jobstates} )); then
        zle .push-input
        [[ -o hist_ignore_space ]] && BUFFER=' ' || BUFFER=''
        BUFFER="${BUFFER}fg"
        zle .accept-line
    else
        zle -M '[ShadowRZ/Zsh] No background jobs. Doing nothing.'
    fi
}
zle -N foreground-last-job

bindkey '^Z' foreground-last-job
bindkey -M emacs '^Z' foreground-last-job
bindkey -M viins '^Z' foreground-last-job

### Completions
# Select a completer
zstyle ':completion:*' completer _complete _match _correct _approximate _expand_alias _ignored _files
# Partial matching
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Allow completing user Git commands
zstyle ':completion:*:*:git:*' user-commands ${${(M)${(k)commands}:#git-*}/git-/}

# Auto rehash for new binaries
zstyle ':completion:*' rehash true
# Squeeze slashes
zstyle ':completion:*' squeeze-slashes true
# Preserve some prefix
zstyle ':completion:*' preserve-prefix '//[^/]##/'
# Add space
zstyle ':completion:*' add-space true
# Tweak cd
zstyle ':completion:*:cd:*' ignore-parents parent pwd .. directory
# > The following example sets special-dirs to `..' when the current prefix is
# > empty, is a single `.', or consists only of a path beginning with `../'.
# > Otherwise the value is `false'.
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'

### Rest modified from Grml config
# allow one error for every three characters typed in approximate completer
zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'
# don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '(*\~)'
# start menu completion only if it could find no unambiguous initial string
zstyle ':completion:*:correct:*'       insert-unambiguous true
zstyle ':completion:*:corrections'     format '%B%F{yellow}[ShadowRZ/Zsh/Complete]%f%b%F{red} From %BCorrected (%e errors)%b%f'
zstyle ':completion:*:correct:*'       original true
# activate color-completion
zstyle -e ':completion:*:default'         list-colors 'reply=(${(s.:.)LS_COLORS})'
# format on completion
zstyle ':completion:*:descriptions'    format '%B%F{yellow}[ShadowRZ/Zsh/Complete]%f%b%F{red} From %B%d%b%f'
# automatically complete 'cd -<tab>' and 'cd -<ctrl-d>' with menu
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
# insert all expansions for expand completer
zstyle ':completion:*:expand:*'        tag-order all-expansions
zstyle ':completion:*:history-words'   list false
# activate menu
zstyle ':completion:*:history-words'   menu yes
zstyle ':completion:*:*:*:*:*'         menu yes select
# ignore duplicate entries
zstyle ':completion:*:history-words'   remove-all-dups yes
zstyle ':completion:*:history-words'   stop yes
# match uppercase from lowercase
zstyle ':completion:*'                 matcher-list 'm:{a-z}={A-Z}'
# separate matches into groups
zstyle ':completion:*:matches'         group 'yes'
zstyle ':completion:*'                 group-name ''
zstyle ':completion:*:messages'        format '%d'
zstyle ':completion:*:options'         auto-description '%d'
# describe options in full
zstyle ':completion:*:options'         description 'yes'
# on processes completion complete all user processes
# [See ps(1) for help on this specification]
zstyle ':completion:*:processes'       command 'ps -u${USER} -o user,pid,cmd'
# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
# provide verbose completion information
zstyle ':completion:*'                 verbose true
# recent (as of Dec 2007) zsh versions are able to provide descriptions
# for commands (read: 1st word in the line) that it will list for the user
# to choose from. The following disables that, because it's not exactly fast.
zstyle ':completion:*:-command-:*:'    verbose false
# set format for warnings
zstyle ':completion:*:warnings'        format '%B%F{yellow}[ShadowRZ/Zsh/Complete]%f%b%F{red} No matches found. :(%f'
# define files to ignore for zcompile
zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'
zstyle ':completion:correct:'          prompt 'correct to: %e'
# Ignore completion functions for commands you don't have:
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'
# Provide more processes in completion of programs like killall:
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'
# complete manual by their section
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select

# Terminal Title
autoload -Uz add-zsh-hook
function set-xterm-terminal-title () {
    printf '\e]2;%s\a' "$@"
}
function precmd-set-terminal-title () {
    set-xterm-terminal-title "${(%):-"%n@%m: %~"}"
}
function preexec-set-terminal-title () {
    set-xterm-terminal-title "${(%):-"%n@%m: "}$2"
}
if [[ "$TERM" == (screen*|xterm*|rxvt*|tmux*|putty*|konsole*|gnome*) ]]; then
    add-zsh-hook -Uz precmd precmd-set-terminal-title
    add-zsh-hook -Uz preexec preexec-set-terminal-title
fi

# remove duplicates from paths
typeset -U path
typeset -U fpath

# Customized word selecting.
for f in backward-kill-word \
         backward-word \
         capitalize-word \
         down-case-word \
         forward-word \
         kill-word \
         transpose-words \
         up-case-word; do
    autoload -Uz $f-match
    zle -N $f $f-match
done

autoload -Uz select-word-style
select-word-style shell

autoload -Uz colors
colors

# Spelling correct prompt.
SPROMPT="%B%F{yellow}[ShadowRZ/Zsh/Correct]%f%b %B%F{red}%R%f%b -> %B%F{green}%r%f%b ? [%B(N)%b/y/a/e]"
REPORTTIME=5
CORRECT_IGNORE='_*'
# Time format.
() {
    local white_b=$fg_bold[white] yellow_b=$fg_bold[yellow] blue=$fg[blue] rst=$reset_color
    TIMEFMT=(
        "${yellow_b}[ShadowRZ/Zsh/Elpased] EST=%*Es$rst $white_b%J$rst"$'\n' # First line
        "${yellow_b} CPU$rst: USR: $blue%U$rst SYS: $blue%S$rst PER:$blue%P$rst"$'\n' # Second line
        "${yellow_b} MEM$rst: $blue%M$rst" # Third line
    )
}

# useful functions
autoload -Uz zmv zcalc zargs url-quote-magic bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# Colored man pages and more.
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
