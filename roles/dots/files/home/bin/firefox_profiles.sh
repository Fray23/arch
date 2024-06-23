#!/bin/bash

# Путь к файлу profiles.ini
PROFILES_INI="$HOME/.mozilla/firefox/profiles.ini"

# Получение списка профилей
while read -r line; do export "$line"; done < /home/fs/scale_vars
dpi="150"
profile=$(grep '\[Profile' -A 2 "$PROFILES_INI" | grep "Name=" | sed 's/Name=//' | rofi -dmenu)

if [ ! "$profile" = "" ]; then
    firefox -P "$profile";
fi

