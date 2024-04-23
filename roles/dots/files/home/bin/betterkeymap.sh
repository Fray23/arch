#!/bin/bash

# Проверяем, есть ли уже установленная опция
current_options=$(setxkbmap -query | grep "options:")

# Если опции уже установлены, просто меняем раскладку
if [[ -n "$current_options" ]]; then
    setxkbmap -layout us -option
# Иначе, устанавливаем опцию ctrl:swapcaps
else
    setxkbmap -layout us -option ctrl:swapcaps
fi

