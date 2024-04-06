#!/bin/bash

backup_name=$(date +"%Y-%m-%d_%H-%M-%S")"_main_backup.tar.gz"
tar cf "/home/fs/backups/$backup_name" /home/fs/Desktop/work /home/fs/Desktop/a79 /home/fs/.ssh /home/fs/.config/chromium /home/fs/theme /home/fs/Pictures /home/fs/Documents /home/fs/tt
tar cf "/home/fs/backups/Music.tar" /home/fs/Music
tar cf "/home/fs/backups/aur_app.tar" /home/fs/_app
