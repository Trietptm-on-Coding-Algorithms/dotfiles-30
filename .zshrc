#
# User configuration sourced by interactive shells
#

# Source zim
#if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
#  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
#fi

source "$HOME/.zsh/themes/akhaten.zsh"

for file in $HOME/.zsh/plugins/*; do
 source "$file"
done

for file in $HOME/.alias/*; do
  source "$file"
done

# Export bin/ path
export PATH=$HOME/bin:${PATH}

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Make use of the VDPAU Driver
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
