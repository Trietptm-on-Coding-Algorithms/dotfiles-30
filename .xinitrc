[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Set keyboard layout to Swedish (åäö)
setxkbmap se

# Fix bug where screen not updating in awesome-wm (NOT WORKING)
# hsetroot -solid "#000000"

# Clean terminal history
rm ~/.bash_history &
rm ~/.zhistory &
sh history -c & # Just to be sure

# Disable beep
xset -b &

# Fixes white-window-bug in Qt applications (native, raster, opengl)
# export QT_GRAPHICSSYSTEM=native

# Autostarts
compton &
xscreensaver &
# mopidy &      # Running mpd as system-service instead.
# urxvtd &      # Starts within awesome-wm. No need for it here.
# nm-applet &   # NetworkManager <--- Avoid at all cost

# Choose you'r WM
exec awesome
# exec /home/lemones/.dwm/dwm
# exec dwm-user
# exec /usr/bin/startkde
# exec xmonad
# exec i3
# exec 2bwm
# exec xmonad
