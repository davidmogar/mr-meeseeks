#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

active_monitors=$(xrandr --listactivemonitors | grep -v Monitors)

IFS=$'\n'
readarray -t <<< "$active_monitors"

for monitor in "${MAPFILE[@]}"
do
    name=$(cut -d" " -f6 <<< "$monitor")
    resolution=$(awk '{print $3}' <<< "$monitor")
    width=$(cut -d "/" -f1 <<< "$resolution")
    height=$(cut -d "x" -f2 <<< "$resolution" | cut -d "/" -f1)

    if [[ $width -gt $height ]]
    then
        MONITOR=$name polybar -c ~/.config/polybar/config.ini \
                              --quiet \
                              --reload \
                              horizontal_monitor_top &
    else
        MONITOR=$name polybar -c ~/.config/polybar/config.ini \
                              --quiet \
                              --reload \
                              vertical_monitor_top &
    fi
done
