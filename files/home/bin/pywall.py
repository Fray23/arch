#!/bin/python3

import os
import time
import sys

path = '/home/fs/Pictures/pic/new_hidpi_wallpaper'
default_command = f'feh --randomize --bg-fill {path}'

minute = 10

if len(sys.argv) > 1:

    if sys.argv[1] == '-w':
        while True:
            os.system(default_command)
            time.sleep(minute * 60)

    if sys.argv[1] == 'black':
        p = '/home/fs/Pictures/blank.png'
        os.system('feh --bg-fill ' + p)

else:
    os.system(default_command)
