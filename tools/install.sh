#!/bin/bash

    clear
    tput setaf 6
    echo "
    ░█▀▄░█▀█░█▀▄░█▀█░█▀█░█░█░█▀█░░░░█▀█░█▀▄░█▀▀
    ░█▀▄░█▀█░█░█░█▀█░█░█░█▀▄░█▀█░░░░█░█░█▀▄░█░█
    ░▀▀░░▀░▀░▀▀░░▀░▀░▀░▀░▀░▀░▀░▀░▀░░▀▀▀░▀░▀░▀▀▀
    $(tput sgr0)
              This will create symbolic links from
              $HOME/.dotfiles/* to $HOME/
              Press 'c' to continue.

"

files=".alias/
bin/
.config/awesome/
.config/feh/
.config/htop/
.config/mpd/
.config/mpv/
.config/ranger/
.config/termite/
.dwm/dwm-start
.dwm/dwm-status
.dwm/patches.txt
.nano/
.ncmpcpp/
.ssh/
.tmux/
.vim/
.Xresources.d/
.zsh/
.bashrc
.compton.conf
.LS_COLORS
.ls++.conf
.nanorc
.tmux.conf
.vimrc
.xinitrc
.Xresources
.zshrc
shouldnot"

function start_l {
    for f in $files; do
        if [ -e "$HOME/$f" ]; then
           echo "[*] Creating backup of: $HOME/$f"
           #mv $f $HOME/backup/ > /dev/null
          #ln -s $HOME/.dotfiles/$f $HOME/$f
          continue
        else
           echo "[*] $HOME/$f is missing"
          #ln -s $HOME/.dotfiles/$f $HOME/$f
          continue
      fi
    done
}

read -rsn1 key
if [ "$key" = "c" ]; then
    start_l
else
    exit 0
fi


exit 0
