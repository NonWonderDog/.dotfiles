function fish_greeting
    if not set -q fish_greeting
        # The greeting used to be skipped when fish_greeting was empty (not just undefined)
        # Keep it that way to not print superfluous newlines on old configuration
        test -n "$fish_greeting"
        and return

        set -l cow ""
        if command -q cowsay
            if command -q cowthink
                set cow "$(shuf -n1 -e "cowsay" "cowthink")"
            else
                set cow "cowsay"
            end
        end

        if command -q fastfetch
            if command -q cowfortune
                cowfortune | fastfetch --logo -
            else if command -q fortune; and string match -q "$cow" "cowsay"
                fortune | cowsay -r -W 60 | fastfetch --logo -
            else if command -q fortune; and string match -q "$cow" "cowthink"
                fortune | cowthink -r -W 60 | fastfetch --logo -
            else
                fastfetch
                if command -q fortune
                    fortune
                end
            end
        else if command -q cowfortune
            cowfortune
        else if command -q fortune; and string match -q "$cow" "cowsay"
            fortune | cowsay -r -W 60
        else if command -q fortune; and string match -q "$cow" "cowthink"
            fortune | cowthink -r -W 60
        else if command -q fortune
            fortune
        end
    end

    if set -q fish_private_mode
        echo "\nfish is running in private mode, history will not be persisted."
    end
end
