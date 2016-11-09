function fish_user_key_bindings
    fish_vi_key_bindings
    fish_vi_cursor xterm

    # vi keybindings miss this
    bind -M insert \cl 'clear; commandline -f repaint'
    
    # Add emacs bindings to insert mode, because why not?
    bind -M insert \ck kill-line
    bind -M insert \ca beginning-of-line
    bind -M insert \ce end-of-line
    bind -M insert \ch backward-delete-char
    bind -M insert \cp up-or-search
    bind -M insert \cn down-or-search
    bind -M insert \cf forward-char
    bind -M insert \cb backward-char
    bind -M insert \ct transpose-chars
end
