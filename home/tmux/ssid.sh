#!/bin/sh
ret=`netsh WLAN show interfaces`
ssid=`echo "$ret" | awk '/^    Profile/ {for(i=3;i<=NF;++i)print $i}'`
if [ -n "$ssid" ]; then
    strength=`echo "$ret" | awk '/^    Signal/ {sub(/%/, ""); print $3}'`
    if [ $strength -gt 60 ]; then
        if [ $strength -gt 80 ]; then
            bar='▁▂▃▅▇'
        else
            bar='▁▂▃▅ '
        fi
    elif [ $strength -gt 20 ]; then
        if [ $strength -gt 40 ]; then
            bar='▁▂▃  '
        else
            bar='▁▂   '
        fi
    else
            bar='▁    '
    fi
    echo "#[fg=colour67]$bar #[bg=colour67, fg=black]  $ssid  #[default]"
fi
