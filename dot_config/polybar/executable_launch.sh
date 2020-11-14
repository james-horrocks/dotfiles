#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

monitors=$(xrandr | grep -w connected | tr -d " ")

# Launch Polybar, using default config location ~/.config/polybar/config
for m in $monitors; do
    monitor=$(echo $m | sed -r "s/(connected)/ /g" | cut -d" " -f1)
    height=$(echo $m | grep -Eo "[0-9]{3,4}mmx[0-9]{3,4}mm" | grep -Eo "[0-9]{3,4}" | cut -d$'\n' -f2)
    yres=$(echo $m | grep -Eo "[0-9]{3,4}x[0-9]{3,4}" | cut -d"x" -f2)
    dpi=$(echo "$yres / ($height / 25.4)" | bc)
    rdpi=$(printf "%.0f\n" $dpi)
    MONITOR=$monitor RDPI=$rdpi polybar --reload myBar &
done

echo "Polybar launched..."