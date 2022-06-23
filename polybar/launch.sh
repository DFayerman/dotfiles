#!/bin/sh

# Terminate already running bar instances
# killall -q polybar
# If all your bars have ipc enabled, you can also use 
polybar-msg cmd quit

# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

POLYDIR=$HOME/dotfiles/polybar/custom/config.ini
POLYNAME=main

polybar -r -c $POLYDIR $POLYNAME 2>&1 | tee -a /tmp/polybar.log & disown 

echo "Polybar launched..."
