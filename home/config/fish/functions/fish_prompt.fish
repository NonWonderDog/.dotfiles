function fish_prompt
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

    set -l normal (set_color normal)

    # on MSYS prepend that to the prompt
    if set -q MSYSTEM
        set -l msys (set_color magenta) $MSYSTEM ' '
    end

    # pipestatus functions
    # set bold on change of status
    set -l status_bold --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if [ $__fish_prompt_status_generation = $status_generation ]
        set bold_flag
    end
    set -q fish_color_status; or set -g fish_color_status red
    set -l status_bracecolor (set_color $fish_color_status)
    set -l status_color (set_color $bold $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_bracecolor" "$status_color" $last_pipestatus)

    # change prompt for root
    set -l suffix '$'
    set -l color_cwd $fish_color_cwd
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end
    set -l cwd_color (set_color $color_cwd)

    set -l color_user $fish_color_user
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_user_root
            set color_user $fish_color_user_root
        end
    end
    set -l user_color (set_color $color_user)

    # fancy prompt
    if test "$fish_key_bindings" = fish_vi_key_bindings
        or test "$fish_key_bindings" = fish_hybrid_key_bindings
        switch $fish_bind_mode
            case default
                set suffix (set_color --bold red) 'N'
            case insert
                #set suffix (set_color --bold green) 'I'
            case replace_one
                #set suffix (set_color --bold green) 'R'
            case replace
                set suffix (set_color --bold cyan) 'R'
            case visual
                set suffix (set_color --bold magenta) 'V'
        end
    end
    set -l tty pts
    set -l leader    $user_color '┬─'
    set -l jobleader $user_color '│ ' (set_color brown)
    set -l suffix    $user_color '╰─' $suffix
    if [ $tty = tty ]
        set -l leader    $user_color ".-"
        set -l jobleader $user_color '; ' (set_color brown)
        set -l suffix    $user_color "'-" $suffix
    end

    echo    -s $leader $msys (prompt_login) ' ' $cwd_color (prompt_pwd) $normal (fish_vcs_prompt) $normal ' ' $prompt_status
    for job in (jobs); echo -s $jobleader $job; end
    echo -n -s $suffix ' ' $normal
end
