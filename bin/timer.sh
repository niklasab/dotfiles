#!/bin/bash

# i3 config
#bindsym $mod+F1 exec --no-startup-id "~/bin/timer.sh 1500"
#bindsym $mod+F2 exec --no-startup-id "~/bin/timer.sh 300"

TIMER_FILE="$HOME/tmp/timer.txt"
if [ $# -eq 0 ]; then
    if [ -f $TIMER_FILE ]; then
        cat $TIMER_FILE
    fi
    exit 0
fi

secs="$1"
tot="$((secs / 60))"
while [ "$secs" -gt 0 ]; do
   if [ "$secs" -gt 60 ]; then
       echo "$((secs / 60)):$((secs % 60))" > $TIMER_FILE
   else
       echo "00:$secs" > $TIMER_FILE
   fi
   sleep 1
   : $((secs--))
done
echo "$(date +%R) ($tot min)" > $TIMER_FILE
#zenity --info --text="" --display=:0.0 --width 1000 --height 1000
