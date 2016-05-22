[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# For Swedish keyboard layout
setxkbmap se

# Fix bugg screen not updating in awesome
# hsetroot -solid "#000000"

# Clean
rm ~/.bash_history &
rm ~/.zhistory &
sh history -c &

# Fixes white-window-bugg in Qt applications
# export QT_GRAPHICSSYSTEM=native
# native, raster, opengl

# Gnome polkit agent
/usr/libexec/polkit-gnome-authentication-agent-1 &

# dropbox start &
# xcompmgr &
compton &
xscreensaver &
# mopidy &
# urxvtd &
# nm-applet &

exec awesome
# exec i3
# exec 2bwm
