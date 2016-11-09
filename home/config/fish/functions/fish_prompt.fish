function fish_prompt
    set -l last_status $status
    if test $last_status -eq 0
        set retc green
    else
        set retc red
    end

    tty|grep -q tty; and set tty tty; or set tty pts

    set_color $retc
    if [ $tty = tty ]
        echo -n .-
    else
        echo -n '┬─'
    end
    set_color -o green
    if test $USER = root -o $USER = toor
        set_color -o red
    else
        set_color -o green
    end
    echo -n $USER
    set_color -o white
    if [ -z "$SSH_CLIENT" ]
        set_color -o green
    else
        set_color -o cyan
    end
    echo -n @(hostname)
    set_color normal
    set_color magenta
    echo -n " $MSYSTEM "
    set_color $retc
    if test $last_status -ne 0
        echo -n "("$last_status")"
    end
    set_color -o blue
    echo -n (pwd|sed "s=$HOME=~=")
    set_color normal
    
    # Check if acpi exists
    if not set -q __fish_nim_prompt_has_acpi
    	if type acpi > /dev/null ^&1
            set -g __fish_nim_prompt_has_acpi ''
    	else
            set -g __fish_nim_prompt_has_acpi '' # empty string
    	end
    end
    	
    if test "$__fish_nim_prompt_has_acpi"
        if [ (acpi -a 2> /dev/null | grep off) ]
            echo -n '─['
            set_color -o red
            echo -n (acpi -b|cut -d' ' -f 4-)
            set_color -o green
            echo -n ']'
        end
    end

    # Line 2
    echo
    set_color normal
    for job in (jobs)
        if not echo "$job" | grep -q fish_right_prompt_async
            set_color $retc
            if [ $tty = tty ]
                echo -n '; '
            else
                echo -n '│ '
            end
            set_color brown
            echo $job
        end
    end
    set_color normal
    set_color $retc
    if [ $tty = tty ]
        echo -n "'->"
    else
        echo -n '╰─>'
    end
    set_color -o green
    echo -n '$ '
    set_color normal
end
