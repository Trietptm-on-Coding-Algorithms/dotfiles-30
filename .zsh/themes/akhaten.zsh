if [[ -n "$SSH_CLIENT" ]]; then
	prompt_host="$(hostname) "
else
	prompt_host=""
fi

# %n = User
# %m = host
# %{$fg[magenta]%}%
# %d shows the entire path.
# %~ shows the path with any variables replaced.
# ${PWD/#$HOME/~} Colapse pwd

autoload -U colors && colors

setopt prompt_subst

#PROMPT_CHAR="➜"
# Liberation Mono font
PROMPT_CHAR="🢖"
GIT_CHAR=""
# GIT_CHAR="❤"      ☭  👽

# unstaged: you have changes that you have not staged (added) to your git repo
UNSTAGE_CHAR="!" # %u
# uncommited: you have changes not yet commited
UNCOMMIT_CHAR="+" # %c

ON_COLOR="%{$fg[cyan]%}"
OFF_COLOR="%{$reset_color%}"
ERR_COLOR="%{$fg[red]%}"


autoload -Uz vcs_info

zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '

zstyle ':vcs_info:*' formats       \
    '%c%F{5}[%F{2}%b%F{5}]%u%f'

zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' stagedstr     '%B%F{red}+%f%b'
zstyle ':vcs_info:*' unstagedstr   '%B%F{yellow}!%f%b'

zstyle ':vcs_info:*' enable git cvs svn
zstyle ':vcs_info:*' check-for-changes true

zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-remotebranch

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}


function git_prompt() {
    git branch >/dev/null 2>/dev/null && echo "$(git branch)" && return
    echo '○'
}

function user_prompt()
{
    git branch >/dev/null 2>/dev/null && echo "$ON_COLOR$GIT_CHAR$OFF_COLOR" && return
    echo "$ON_COLOR$PROMPT_CHAR$OFF_COLOR"
}

function path_prompt()
{
    echo "$ON_COLOR ${PWD/#$HOME/~}$OFF_COLOR"
}

PROMPT='$prompt_host$(user_prompt) '
RPROMPT='$(path_prompt) $(vcs_info_wrapper) '
