function fish_greeting
    if not set -q fish_greeting
        command -q fortune; and set -l quote "fortune"; or set -l quote ""
        set -l art ""

        if command -q cowfortune
            set art "$(cowfortune)"
        else if command -q fortune; and command -q cowsay
            set -l cow (find /usr/share/cows -type f -name "*.cow" | shuf -n1)
            set -l cowsay (shuf -n1 -e "cowsay" "cowthink")
            set art "\${c1}$(fortune | $cowsay -f $cow -W 60)"
        end

        if command -q neofetch
            if test -n "$art"
                set -g fish_greeting "$(neofetch --ascii "$art")"
                set quote ""
            else
                set -g fish_greeting "$(neofetch)"
            end
        else
            if test -n "$art"
                set -g fish_greeting "$art"
            end
        end
        if test -n "$quote"
            if set -q fish_greeting[1]
                set -g fish_greeting "$fish_greeting\n$quote"
            else
                set -g fish_greeting "$quote"
            end
        end
    end

    if set -q fish_private_mode
        set -l line (_ "fish is running in private mode, history will not be persisted.")
        if set -q fish_greeting[1]
            set -g fish_greeting "$fish_greeting\n$line"
        else
            set -g fish_greeting "$line"
        end
    end

    # The greeting used to be skipped when fish_greeting was empty (not just undefined)
    # Keep it that way to not print superfluous newlines on old configuration
    test -n "$fish_greeting"
    and echo $fish_greeting
end
