#!/bin/sh
xrandr --auto
xrandr -r 60.00
xrdb ~/.Xresources
slstatus &
picom &
emacs --daemon &
flameshot &
dunst &
exec ~/bin/startdwm
# exec dwm
