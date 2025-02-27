## Use vi key bindings
set fish_key_bindings fish_user_key_bindings
set fish_bind_mode insert
set -g __fish_vi_mode 1
set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_visual block

## Prompt colors
set fish_color_user        green
set fish_color_user_root   red
set fish_color_host        green
set fish_color_host_remote green
set fish_color_cwd         blue
set fish_color_cwd_root    red

## Fish git prompt
set __fish_git_prompt_showdirtystate            1
set __fish_git_prompt_showstashstate            1
set __fish_git_prompt_showuntrackedfiles        1
set __fish_git_prompt_showupstream              1
set __fish_git_prompt_show_informative_status   1
set __fish_git_prompt_color_branch              magenta
set __fish_git_prompt_color_cleanstate          -o green
set __fish_git_prompt_color_dirtystate          blue
set __fish_git_prompt_color_invalidstate        red
set __fish_git_prompt_color_stagedstate         red
set __fish_git_prompt_color_stashstate          -o blue
set __fish_git_prompt_color_untrackedfiles      cyan
set __fish_git_prompt_color_upstream            blue
set __fish_git_prompt_color_prefix              magenta
set __fish_git_prompt_color_suffix              magenta

# Status Chars
set __fish_git_prompt_char_cleanstate           '✔ '
set __fish_git_prompt_char_dirtystate           '✚ '
set __fish_git_prompt_char_invalidstate         '✖ '
set __fish_git_prompt_char_stagedstate          '● '
set __fish_git_prompt_char_stashstate           '⚑ '
set __fish_git_prompt_char_stateseparator       '|'
set __fish_git_prompt_char_untrackedfiles       '…'
set __fish_git_prompt_char_upstream_ahead       '↑ '
set __fish_git_prompt_char_upstream_behind      '↓ '
set __fish_git_prompt_char_upstream_prefix      ''
set __fish_git_prompt_char_upstream_suffix      ''

## Fish svn prompt
set __fish_svn_prompt_color_revision                    yellow
set __fish_svn_prompt_char_separator                    '|'

set __fish_svn_prompt_char_added_display                'A'
set __fish_svn_prompt_char_added_color                  green

set __fish_svn_prompt_char_conflicted_display           'C'
set __fish_svn_prompt_char_conflicted_color             --underline magenta

set __fish_svn_prompt_char_deleted_display              'D'
set __fish_svn_prompt_char_deleted_color                red

set __fish_svn_prompt_char_ignored_display              'I'
set __fish_svn_prompt_char_ignored_color                --bold yellow

set __fish_svn_prompt_char_modified_display             'M'
set __fish_svn_prompt_char_modified_color               blue

set __fish_svn_prompt_char_replaced_display             'R'
set __fish_svn_prompt_char_replaced_color               cyan

set __fish_svn_prompt_char_unversioned_external_display 'X'
set __fish_svn_prompt_char_unversioned_external_color   --underline cyan

set __fish_svn_prompt_char_unversioned_display          '?'
set __fish_svn_prompt_char_unversioned_color            purple

set __fish_svn_prompt_char_missing_display              '!'
set __fish_svn_prompt_char_missing_color                yellow

set __fish_svn_prompt_char_versioned_obstructed_display '~'
set __fish_svn_prompt_char_versioned_obstructed_color   magenta

set __fish_svn_prompt_char_locked_display               'L'
set __fish_svn_prompt_char_locked_color                 --bold red

set __fish_svn_prompt_char_scheduled_display            '+'
set __fish_svn_prompt_char_scheduled_color              --bold green

set __fish_svn_prompt_char_switched_display             'S'
set __fish_svn_prompt_char_switched_color               --bold blue

set __fish_svn_prompt_char_token_present_display        'K'
set __fish_svn_prompt_char_token_present_color          --bold cyan

set __fish_svn_prompt_char_token_other_display          'O'
set __fish_svn_prompt_char_token_other_color            --underline purple

set __fish_svn_prompt_char_token_stolen_display         'T'
set __fish_svn_prompt_char_token_stolen_color           --bold purple

set __fish_svn_prompt_char_token_broken_display         'B'
set __fish_svn_prompt_char_token_broken_color           --bold magenta

## Environment
set -gx LESS "-RFXi"
set -gx MINICOM "-c on"
set -gx SSH_ENV ~/.ssh/environment
if set -q MSYSTEM
    set -gx PATH /c/Program\ Files/Pandoc $PATH
    set -gx PATH /c/Program\ Files/MiKTeX\ 2.9/miktex/bin/x64 $PATH
end

set -gx PATH ~/.cargo/bin $PATH
set -gx PATH ~/bin $PATH

## Aliases
alias visudo 'sudo visudo'
alias info 'info --vi-keys'
alias ack 'ack --pager less\ -XF'
alias ag 'ag --pager less\ -XF'

# vim damages your brain
alias 'q' 'exit'
alias ':q' 'exit'
alias ':wq' 'exit'

# TAR
alias mktar 'tar -cvf'
alias untar 'tar -xvf'
alias vwtar 'tar -tvf'

# neovim supremacy
alias vim 'nvim'
alias vimdiff 'nvim -d'
alias vims 'nvim -S Session.vim'
set -gx EDITOR 'nvim'

# svn diff
function svndiff
    svn diff --diff-cmd colordiff | less -FRSX
end

# SVN Repository
set engDev https://wsmuriel.roushnet.com:8443/svn/engDev
set ULA_IVF https://openproj.spacemicro.com/svn/ula-ivf

# start SSH agent
set -gx SSH_AUTH_SOCK /tmp/.ssh-socket
ssh-add -l > /dev/null 2>&1
if [ $status -eq 2 ]
    start_ssh_agent
end

# configure GPG agent
set -gx GPG_TTY (tty)
set -gx GPG_AGENT_INFO (gpgconf --list-dirs agent-socket | tr -d '\n' && echo -n '::')

# Launch tmux if interactive
# if status --is-interactive
#     if [ -z "$TMUX" ]
#         tmux; and exec true
#     end
# end
