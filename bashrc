# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# force unicode on Windows
if hash chcp.com 2>/dev/null; then
    chcp.com 65001
fi

# create a variable to signify that this ran, for msysgit compatibility
BASHRC=

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# don't put ls, bf, fg, or exit calls in history
HISTIGNORE="ls:ls *:[bf]g:exit" 

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# ignore first two ^D keypresses
IGNOREEOF=2

# fix minor typos in cd
shopt -s cdspell

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color support
alias ls='ls --color=auto'
if grep --color "a" <<<"a" &>/dev/null; then
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# use colors in less
man() {
    env \
        LESS_TERMCAP_mb=$'\E[01;31m' \
        LESS_TERMCAP_md=$'\E[01;32m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_so=$'\E[01;35m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[01;34m' \
        man "$@"
}

# use colors in minicom
export MINICOM="-c on"

# use vim as the man pager
#export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

# set default options for less
export LESS=-FRSXi
export LESSCHARSET=utf-8

# set editor to vim
export VISUAL=vim
export EDITOR=$VISUAL

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

#################################################
# Custom PS1
#################################################
set_prompt_title () {
    echo '\[\e]0;${PWD//[^[:ascii:]]/?}\007\]'
}
# runs once, for beginning of prompt
set_prompt_pre () {
    local reset="\[\e[00m\]"

    # Regular Colors
    local black="\[\e[0;30m\]"
    local red="\[\e[0;31m\]"
    local green="\[\e[0;32m\]"
    local yellow="\[\e[0;33m\]"
    local blue="\[\e[0;34m\]"
    local purple="\[\e[0;35m\]"
    local cyan="\[\e[0;36m\]"
    local white="\[\e[0;37m\]"

    # Bright Colors
    local bblack="\[\e[1;30m\]"
    local bred="\[\e[1;31m\]"
    local bgreen="\[\e[1;32m\]"
    local byellow="\[\e[1;33m\]"
    local bblue="\[\e[1;34m\]"
    local bpurple="\[\e[1;35m\]"
    local bcyan="\[\e[1;36m\]"
    local bwhite="\[\e[1;37m\]"

    # Symbols
    local fancyX="\342\234\227"
    local checkmark="\342\234\223"

    local prompt=""

    # Windows: Show user@host in blue for normal user, red for administrator
    net session >/dev/null 2>&1;
    if [ $? -eq 0 ]; then
        prompt+=$bred;
    else
        prompt+=$bgreen;
    fi
    prompt+="\u@\h"
    prompt+=$reset':'

    echo "$prompt"
}

# runs every prompt after _pre and before git branch
set_prompt_dynamic () {
    local returncode=$?
    local prompt=""

    local reset="\[\e[00m\]"
    local red="\[\e[0;31m\]"
    local bblue="\[\e[1;34m\]"

    # show (error code) for nonzero return
    if [ $returncode -ne 0 ]; then
        prompt+="$red($returncode)"
    fi

    # current directory
    prompt+="$bblue\w$reset"

    echo "$prompt"
}

# runs once, for prompt after git branch
set_prompt_post () {
    local reset="\[\e[00m\]"
    local bblue="\[\e[1;34m\]"

    local prompt=""

    # prompt on new line
    prompt+="\n"

    # show $ for normal user, # for root
    local prompt_char=""
    net session >/dev/null 2>&1;
    if [ $? -eq 0 ]; then
        prompt_char='#';
    else
        prompt_char='$';
    fi
    prompt+=$bblue$prompt_char$reset' '

    echo "$prompt"
}

set_prompt_gitformat () {
    local reset="\[\e[00m\]"
    local bblue="\[\e[1;34m\]"

    echo "\n$bblue($reset%s$bblue)$reset"
}

# these are slow on Windows...
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="verbose"
export GIT_PS1_SHOWCOLORHINTS=1	# requires that __git_ps1 is used as PROMPT_COMMAND

# __git_ps1 takes three arguments:
# 1: PS1 string before git status
# 2: PS1 string after git status
# 3: git status format (default " (%s)")
export PROMPT_COMMAND="__git_ps1 \"$(set_prompt_title)$(set_prompt_pre)\$(set_prompt_dynamic)\" '$(set_prompt_post)' '$(set_prompt_gitformat)'"

PS2='\[\e[1;34m\]>\[\e[00m\]'

