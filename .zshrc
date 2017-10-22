# Source all zsh plugins
for file in $HOME/.zsh/plugins/*; do
    source "$file"
done

source "$HOME/.zsh/themes/akhaten.zsh"
source "$HOME/.alias/alias"
source "$HOME/.alias/scripts"
source "$HOME/.alias/fedora" # {gentoo, fedora, arch}

export PATH=$HOME/bin:$HOME/.local/bin:${PATH}
# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# SSH fast connect
export bigbnka_ip="192.168.1.132"
export bigbnka_port="8090"
export bigbnka_user="lemones"

export minbnka_ip="192.168.1.136"
export minbnka_port="22"
export minbnka_user="citronster"

export CHROOT=$HOME/fakeroot

# Prevent ranger from loading defalt config
export RANGER_LOAD_DEFAULT_RC=False

# Make use of the VDPAU Driver (May break things)
# export VDPAU_DRIVER=r600

# Autocompletion
autoload -U compinit
compinit
setopt correctall
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Advanced prompt
autoload -U promptinit
promptinit

# Functional dynamic title change for rxvt
case $TERM in
  (rxvt*)
    function precmd {
      print -Pn "\e]0;[zsh] %(1j,%j job%(2j|s|); ,)%~\a"
    }
    function preexec {
      printf "\033]0;[zsh] %s\a" "$1"
    }
  ;;
esac

bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
