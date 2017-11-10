# Source all zsh plugins
for file in $HOME/.zsh/plugins/*; do
    source "$file"
done

source "$HOME/.zsh/themes/akhaten.zsh"
source "$HOME/.alias/alias"
source "$HOME/.alias/functions"
source "$HOME/.alias/fun"
source "$HOME/.alias/arch" # {gentoo, fedora, arch}

# PATH's
export PATH=$HOME/.gem/ruby/2.4.0/bin:$HOME/bin:$HOME/.local/bin:${PATH}

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Filetype color output
eval $(dircolors -b $HOME/.LS_COLORS)

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

# auto-fu
#
#zle-line-init () {auto-fu-init;}; zle -N zle-line-init
#zstyle ':completion:*' completer _oldlist _complete
#zle -N zle-keymap-select auto-fu-zle-keymap-select
#zstyle ':auto-fu:var' postdisplay $''
#zstyle ':auto-fu:var' track-keymap-skip opp

# Autocompletion
autoload -U compinit && compinit
setopt correctall
setopt glob_complete # complete *.blabla
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors # Show colors on menu completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Better completion for kilalll
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'
# when new programs is installed, auto update autocomplete without reloading shell
zstyle ':completion:*' rehash true

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

# Same for xterm*(termite)      (Could probl fork ^ and v togheter)
case $TERM in
  (xterm*)
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

# Perl PATH's
PATH="/home/lemones/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/lemones/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/lemones/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/lemones/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/lemones/perl5"; export PERL_MM_OPT;
