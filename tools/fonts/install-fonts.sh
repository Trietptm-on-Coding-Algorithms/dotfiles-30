# MonteCarlo fonts (programming font)

mkidr ~/gits/
cd ~/gits/
git clone https://aur.archlinux.org/montecarlo-font.git
cd montecarlo-font
makepkg -si

# Manual:
# wget http://bok.net/MonteCarlo/downloads/MonteCarlo-PCF.tgz
# extract MonteCarlo-PCF.tgz
# cd MonteCarlo-PCF
# cp * ~/.local/share/fonts/misc/
# fc-cache -f > /dev/null
# mkfontscale ~/.local/share/fonts/misc
# mkfontdir ~/.local/share/fonts/misc
# echo "Done..."
