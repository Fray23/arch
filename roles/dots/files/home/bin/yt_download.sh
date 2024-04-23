#!/bin/bash

# Путь к файлу со ссылками
input_file="~/Music/new/links"

# Путь к файлу для логов
log_file="~/Music/new/log.txt"

# Проверка наличия youtube-dl
if ! command -v yt-dlp &> /dev/null; then
    echo "Ошибка: youtube-dl не установлен. Установите его перед использованием этого скрипта."
    exit 1
fi

# Проверка наличия файла со ссылками
if [ ! -f "$input_file" ]; then
    echo "Ошибка: Файл со ссылками не найден."
    exit 1
fi

# Создание или очистка файла логов
echo "Логи:" > "$log_file"

# Чтение ссылок из файла и применение youtube-dl
while IFS= read -r url; do
    echo "Обработка: $url"
    
    # Запись в лог перед обработкой
    echo "Обработка: $url" >> "$log_file"

    # Выполнение youtube-dl с определенными параметрами
    yt-dlp -x --audio-format mp3 "$url"

    # Проверка успешности выполнения и запись в лог
    if [ $? -eq 0 ]; then
        echo "Успешно: $url"
        echo "Успешно: $url" >> "$log_file"
    else
        echo "Ошибка: $url"
        echo "Ошибка: $url" >> "$log_file"
    fi

    # Разделитель между записями
    echo "-----------------------"

done < "$input_file"

echo "Готово. Логи записаны в $log_file"
