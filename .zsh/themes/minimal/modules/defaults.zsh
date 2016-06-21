autoload -U colors && colors

setopt prompt_subst

PROMPT_CHAR="➜"

ON_COLOR="%{$fg[green]%}"
OFF_COLOR="%{$reset_color%}"
ERR_COLOR="%{$fg[red]%}"
