#!/bin/bash
batt=$(wmic PATH Win32_Battery Get EstimatedChargeRemaining | awk '/^[0-9]/ {print $1}')
if [[ -n "$batt" ]]; then
    status=$(wmic PATH Win32_Battery Get BatteryStatus | awk '/^[0-9]/ {print $1}')
    if [[ $status == 2 ]]; then
        string=$(printf "    %3d%%     " $batt)
        ((level=${#string}*($batt+5)/100))
        string=$(echo "$string" | sed -e 's/\(.\{'$level'\}\)/\1#[bg=colour22, fg=black]/')
        echo "#[bg=green, fg=black]$string#[default]"
    else
        i=$(wmic PATH Win32_Battery Get EstimatedRunTime | awk '/^[0-9]/ {print $1}')
        ((min=i%60, hrs=i/60))
        string=$(printf " %3d%% (%d:%02d) " $batt $hrs $min)
        ((level=${#string}*($batt+5)/100))
        if [[ $batt -gt 20 ]]; then
            string=$(echo "$string" | sed -e 's/\(.\{'$level'\}\)/\1#[bg=colour23, fg=black]/')
            echo "#[bg=cyan, fg=black]$string#[default]"
        else
            string=$(echo "$string" | sed -e 's/\(.\{'$level'\}\)/\1#[bg=colour52, fg=black]/')
            echo "#[bg=red, fg=black]$string#[default]"
        fi
    fi
fi

