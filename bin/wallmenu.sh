#!/bin/sh

function show_menu {
    clear
    tput setaf 6
    echo "
    ░█▀▄░█▀█░█▀▄░█▀█░█▀█░█░█░█▀█░░░░█▀█░█▀▄░█▀▀
    ░█▀▄░█▀█░█░█░█▀█░█░█░█▀▄░█▀█░░░░█░█░█▀▄░█░█
    ░▀▀░░▀░▀░▀▀░░▀░▀░▀░▀░▀░▀░▀░▀░▀░░▀▀▀░▀░▀░▀▀▀
    $(tput sgr0)
              Wallpaper browser.

    Press left or right to change wallpaper.
    Press s to set or q to undo and quit.

    "

    if [[ $backup_done != False ]]; then
        check_file; fi
    read_keys
}

function check_file {
    readf=`ls -1 $HOME/.wallpaper{.jpg,.png,.JPG,.PNG,.jpeg,.JPEG} 2>/dev/null | wc -l`
    if [ $readf != 0 ]; then
        if_file_exists
    else
        if_file_missing
    fi
}

function if_file_exists {
    echo "File exists... Taking backup."
    mv $HOME/.wallpaper.jpg $HOME/.wallpaper.jpg-backup
    backup_done=True
}

function if_file_missing {
    echo "File missing... press to continue"
    backup_done=False
}

function change_w {
    WP="$HOME/Pictures/wallpapers/*"
    for file in $WP; do
    	#feh --bg-fill $file
    	echo -e "$file"
    done
    show_menu
}

function read_keys {
    escape_char=$(printf "\u1b")
    read -rsn1 mode

    if [[ $mode == $escape_char ]]; then
        read -rsn2 mode
    fi

    case $mode in
        'q') echo "Exit..." ; exit ;;
        '[D') change_w ;;
        '[C') change_w ;;
        *) >&2 echo 'ERR bad input'; show_menu ;;
    esac
}
show_menu
