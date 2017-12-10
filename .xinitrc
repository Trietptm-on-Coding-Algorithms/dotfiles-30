[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Set dir to $HOME, else all urxvc will start from $PWD
cd $HOME

# Set keyboard layout to Swedish (åäö)
setxkbmap se

# Bindings to restart X
setxkbmap -option terminate:ctrl_alt_bksp

# Export user $PATH to systemd
systemctl --user set-environment PATH=$PATH

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
# mpd &  # Switched to init start... (systemd...yuck!)
urxvtd -q -o -f &
# nm-applet &   # NetworkManager <--- Avoid at all cost

# Fonts
xset +fp ~/.local/share/fonts &
xset fp rehash &

# Choose you'r WM
# exec awesome
exec /home/lemones/.dwm/dwm-start
# exec dwm-user
# exec /usr/bin/startkde
# exec xmonad
# exec i3
# exec 2bwm
