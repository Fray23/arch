#!/bin/sh
# xwinwrap -ni -b -fs -nf -ov -debug -- gifview -w WID -a $1
xwinwrap -g 3840x2160 -ni -s -nf -b -un -ov -fdt -argb -- mpv --mute=yes --no-audio --no-osc --no-osd-bar --quiet --screen=0 -wid WID --loop $1
