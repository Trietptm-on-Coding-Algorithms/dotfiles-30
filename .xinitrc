[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Set keyboard layout to Swedish (åäö)
setxkbmap se

# Fix bugg screen not updating in awesome-wm
# hsetroot -solid "#000000"

# Clean history
rm ~/.bash_history &
rm ~/.zhistory &
sh history -c &

# Disable beep
xset -b &

# Fixes white-window-bug in Qt applications (Avaible options: native, raster, opengl)
# export QT_GRAPHICSSYSTEM=native

# Gnome polkit agent (Can't remmember what it's good for. But it was)
# /usr/libexec/polkit-gnome-authentication-agent-1 &

# Autostarts
compton &
xscreensaver &
# mopidy &
# urxvtd &
# nm-applet &

# Choose you'r WM
exec awesome
# exec /usr/bin/startkde
# exec xmonad
# exec i3
# exec 2bwm
# exec xmonad
