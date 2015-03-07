#!/bin/bash
# ~/.bash_aliases: executed by .bashrc
# this file won't ever be clobbered by Ubuntu upgrades

# Because vim damages your brain
alias 'q'='exit'
alias ':q'='exit'
alias ':wq'='exit'
alias ':q!'='kill -9 $$' # hahaha

# TAR
alias mktar='tar -cvf'
alias untar='tar -xvf'
alias vwtar='tar -tvf'

# visudo
alias visudo='sudo visudo'

# Use vi-keys in info
alias info='info --vi-keys'

# ls and grep color support
alias ls='ls --color=auto'
if grep --color "a" <<<"a" &>/dev/null; then
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Ubuntu ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Ubuntu "alert" alias.
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# use less for paging in ack searches
alias ack='\ack --pager=less\ -XF'
alias ag='\ag --pager=less\ -XF'

