#!/bin/bash

# Путь к файлу profiles.ini
PROFILES_INI="$HOME/.mozilla/firefox/profiles.ini"

# Получение списка профилей
profile=$(grep '\[Profile' -A 2 "$PROFILES_INI" | grep "Name=" | sed 's/Name=//' | rofi -dmenu)

if [ -z "$profile" ]; then
    firefox -P "$profile";
fi

