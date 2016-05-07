#
# User configuration sourced by interactive shells
#

# Source zim
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi


# Source all files in .alias/
for file in $HOME/.alias/*; do
  source "$file"
done

# Export bin/ path
export PATH=$HOME/bin:${PATH}

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# Make use of the VDPAU Driver
#export VDPAU_DRIVER=r600

PATH="/home/lemones/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/lemones/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/lemones/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/lemones/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/lemones/perl5"; export PERL_MM_OPT;
