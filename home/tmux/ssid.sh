#!/bin/bash
ssid=`netsh WLAN show interfaces | awk '/^    Profile/ {$1=$2=""; print $0}'`
strength=`netsh WLAN show interfaces | awk '/^    Signal/ {sub(/%/, ""); print $3}'`
if [ -z "$ssid" ]; then
    bar=''
elif [ $strength -le 20 ]; then
    bar='▁'
elif [ $strength -le 40 ]; then
    bar='▁▂'
elif [ $strength -le 60 ]; then
    bar='▁▂▃'
elif [ $strength -le 80 ]; then
    bar='▁▂▃▅'
else
    bar='▁▂▃▅▇'
fi
echo $ssid
