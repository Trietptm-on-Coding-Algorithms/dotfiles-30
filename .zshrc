# .zshrc with zim


if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi


# Source all files in .alias/
for file in $HOME/.alias/*; do
  source "$file"
done


# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# Make use of the VDPAU Driver
#export VDPAU_DRIVER=r600
