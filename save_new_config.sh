#!/bin/bash
rsync -av /home/fs/.config/nvim/ roles/dots/files/config/nvim --exclude packer
rsync -av /home/fs/.config/kitty/ roles/dots/files/config/kitty
cp /home/fs/.emacs.d/config.org roles/dots/files/home/.emacs.d/

cp /home/fs/.bashrc roles/dots/files/home/
cp /home/fs/.gitconfig roles/dots/files/home/
cp /home/fs/.tmux.conf roles/dots/files/home/
cp /home/fs/.xinitrc roles/dots/files/home/
cp /home/fs/scale_vars roles/dots/files/home/

rsync -av /home/fs/.moc roles/dots/files/home/
rsync -av /home/fs/bin roles/dots/files/home/
