#!/bin/bash

shutdown_time="today 20:00"
sec_left=$(echo $(( $(date +%s -d "$shutdown_time") - $( date +%s ) )))
min_left=$((sec_left / 60))

if [ $min_left -gt 0 ]; then
    zenity --info --text="Shutting down in $min_left min" --display=:0.0 --width 500 --height 500 &
else
    zenity --info --text="Shutting down in 30 sec" --display=:0.0 --width 500 --height 500 &
    # Must be in sudoers to not prompt password
    sudo /sbin/shutdown -P now
fi

wait
