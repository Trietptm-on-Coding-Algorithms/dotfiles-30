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

    Press n to cycle next wallpaper.
    Press s to set or q to undo and quit.

    "

    if [[ $backup_done != False ]]; then
        check_file; fi
    change_w
}

function check_file {
    filen_check=`ls -1 $HOME/.wallpaper{.jpg,.png,.JPG,.PNG,.jpeg,.JPEG} 2>/dev/null | wc -l`
    filen=`ls -1 $HOME/.wallpaper{.jpg,.png,.JPG,.PNG,.jpeg,.JPEG} 2>/dev/null`
    if [ $filen_check != 0 ]; then
        echo "Saving old wallpaper as $filen-backup..."
        mv $filen $filen-backup
        backup_fil=$filen
        backup_done=True
    else
        backup_done=False
    fi
}

function change_w {
    WP="$HOME/Pictures/wallpapers/*"
    for file in $WP; do
        read -rsn1 key
        if [ "$key" = 's' ]; then
            echo "Setting $file as bg..."
            cp $file $HOME/.wallpaper.png
            feh --bg-scale $HOME/.wallpaper.png
            exit
        elif [ "$key" = 'q' ]; then
            if [ -e "$backup_fil-backup" ]; then
                echo "Reverting to last known wallpaper..."
                mv $backup_fil-backup $backup_fil
                feh --bg-scale $backup_fil
            else
                echo "No backup file found...Sorry :("
            fi
            exit
        elif [ "$key" = 'n' ]; then
            feh --bg-scale $file
            continue
        else
            echo -e "s - Set | q - quit | n - next"
        fi
    done
}

show_menu
