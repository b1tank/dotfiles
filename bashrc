# ~/.bashrc — interactive bash configuration (macOS)
# Sourced by ~/.bash_profile for login shells and directly by non-login
# interactive shells (e.g. Vim's :terminal). Safe to keep in a dotfiles repo.

# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return;;
esac

# ---------------------------------------------------------------------------
# History
# ---------------------------------------------------------------------------
HISTCONTROL=ignoreboth   # ignore duplicate lines and lines starting with space
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend      # append to the history file, don't overwrite it
shopt -s checkwinsize    # keep LINES/COLUMNS in sync after each command

# ---------------------------------------------------------------------------
# Prompt (colored)
# ---------------------------------------------------------------------------
PS1='\[\033[01;36m\]\u\[\033[01;31m\]@\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;33m\]\W\[\033[01;00m\]\$ '

# If this is an xterm, also set the window title to user@host:dir.
case "$TERM" in
    xterm*|rxvt*) PS1="\[\e]0;\u@\h: \w\a\]$PS1";;
esac

# ---------------------------------------------------------------------------
# Colors: ls / grep / man pages
# ---------------------------------------------------------------------------
# macOS/BSD ls: CLICOLOR enables color, LSCOLORS sets the palette.
# https://geoff.greer.fm/lscolors/
export CLICOLOR=1
export LSCOLORS=FxBxcxdxGxegedabagacad

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Colorized man pages (via less termcap).
export LESS_TERMCAP_mb=$(printf '\e[01;31m')   # blinking  -> red
export LESS_TERMCAP_md=$(printf '\e[01;32m')   # bold      -> green
export LESS_TERMCAP_me=$(printf '\e[0m')       # reset
export LESS_TERMCAP_se=$(printf '\e[0m')       # end standout
export LESS_TERMCAP_so=$(printf '\e[01;33m')   # standout  -> yellow
export LESS_TERMCAP_us=$(printf '\e[04;36m')   # underline -> cyan
export LESS_TERMCAP_ue=$(printf '\e[0m')       # end underline

# ---------------------------------------------------------------------------
# Aliases
# ---------------------------------------------------------------------------
alias ll='ls -alFG'
alias la='ls -AG'
alias l='ls -CFG'

# Optional extra aliases in ~/.bash_aliases.
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# ---------------------------------------------------------------------------
# Misc
# ---------------------------------------------------------------------------
# Silence macOS "bash is deprecated, use zsh" notice.
export BASH_SILENCE_DEPRECATION_WARNING=1

# ---------------------------------------------------------------------------
# PATH (idempotent: only prepend if not already present)
# ---------------------------------------------------------------------------
prepend_path() {
    case ":$PATH:" in
        *":$1:"*) ;;                 # already present, skip
        *) [ -d "$1" ] && PATH="$1:$PATH";;
    esac
}
prepend_path "/opt/homebrew/bin"
prepend_path "$HOME/.local/bin"
export PATH

# ---------------------------------------------------------------------------
# Homebrew bash-completion (bash 4+; harmless if absent)
# ---------------------------------------------------------------------------
if ! shopt -oq posix; then
    if [ -r /opt/homebrew/etc/profile.d/bash_completion.sh ]; then
        . /opt/homebrew/etc/profile.d/bash_completion.sh
    fi
fi

# ---------------------------------------------------------------------------
# nvm
# ---------------------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                     # load nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # nvm completion
