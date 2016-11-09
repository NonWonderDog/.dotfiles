#!/bin/sh
batt=`wmic PATH Win32_Battery Get EstimatedChargeRemaining | awk '/^[0-9]/ {print $1}'`
echo $batt%

