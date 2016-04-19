# .zshrc with zim


if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi


# Easy extract
extract () {
  if [ -f $1 ] ; then
    case $1 in
        *.tar.bz2)   tar xvjf $1    ;;
        *.tar.gz)    tar xvzf $1    ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       rar x $1       ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xvf $1     ;;
        *.tbz2)      tar xvjf $1    ;;
        *.tgz)       tar xvzf $1    ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)           echo "don't know how to extract '$1'..." ;;
    esac
else
    echo "'$1' is not a valid file!"
fi
}


# Alias

# Copy folder with all contents

alias R='ranger'
alias cpf='cp -avr'

alias e='exit'
alias l='ls -CF --group-directories-first'
alias c='clear'
alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'

# Fedora based aliases
alias dnfl="dnf list"                       # List packages
alias dnfli="dnf list installed"            # List installed packages
alias dnfgl="dnf grouplist"                 # List package groups
alias dnfmc="dnf makecache"                 # Generate metadata cache
alias dnfp="dnf info"                       # Show package information
alias dnfs="dnf search"                     # Search package

alias dnfu="sudo dnf upgrade"               # Upgrade package
alias dnfi="sudo dnf install"               # Install package
alias dnfgi="sudo dnf groupinstall"         # Install package group
alias dnfr="sudo dnf remove"                # Remove package
alias dnfgr="sudo dnf groupremove"          # Remove package group
alias dnfc="sudo dnf clean all"             # Clean cache

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# Make use of the VDPAU Driver
#export VDPAU_DRIVER=r600
