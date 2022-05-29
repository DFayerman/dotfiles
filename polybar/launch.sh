#!/bin/sh

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# polybar -c $HOME/dotfiles/polybar/nord/config.ini main 2>&1 | tee -a /tmp/polybar.log & disown
polybar -c $HOME/dotfiles/polybar/shapes/config.ini main 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched..."
