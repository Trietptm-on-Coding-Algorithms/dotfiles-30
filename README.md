# Install
git clone --recursive https://github.com/lemones/dotfiles/dotfiles.git $HOME  
DO NOT USE IF YOU ARE NOT ME!  
THIS WILL BREAK YOUR CURRENT UI AND SHELL SETUP.

# Applications
*  awesome
*  rxvt-unicode
*  ncmpcpp
*  mopidy
*  python-pip
*  Mopidy-Spotify (pip)
*  lolcat (gem)
*  [Fedy](https://github.com/folkswithhats/fedy) (Fedora)
* ranger (terminal files browser)
* python-pep8
* zsh ([zim](https://github.com/Eriner/zim))
* VIM (vim-jedi, vim-powerline)

# Security
* firewald
* dnscrypt-proxy
* tools/dnscrypt-autoinstall

Dont forget to change /etc/resolv.conf to use localhost(127.0.0.1).  
To prevent dhcpcd to overwrite resolv.conf, add:    
static domain_name_servers=127.0.0.1

# Settings

Vim
------

##### Plugins
The plugins can already be found in .zim/bundle/

Atom
------
###### Settings
*    UI:     One Dark
*    Syntax: An Old Hope

###### Packages
*    minimap
*    minimap-cursorline
*    autocomplete-clang
*    autocomplete-python
*    color-picker
*    language-lua
*    pigments
*    Atom Beautify
*    File-icons
*    Git plus
*    linter
*    linter-pep8
*    python-indent

# Fedora   
To install bmc4322 drivers   
wget http://git.io/vuLC7 -v -O fedora23_broadcom_wl_install.sh && sh ./fedora23_broadcom_wl_install.sh;   
A temporary fix for kernel 4-6-0, change license to GPL in src/wl/sys/wl_linux.c (this is not legal!)
