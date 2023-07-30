function fish_greeting
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
            neofetch --disable Packages --ascii "$art"
            set quote ""
        else
            neofetch --disable Packages
        end
    else
        if test -n "$art"
            echo $art
        end
    end
    if test -n "$quote"
        $quote
    end
end
