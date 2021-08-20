## ZSH CONFIG BY DOTFILE
# GLOBAL VARIABLE
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state


export GIT_REPO_ROOT=$HOME/Develop/github.com
export TEMP_ROOT=$HOME/Develop/temp
export BIN_ROOT=$HOME/Develop/bin

export PATH=$BIN_ROOT:$PATH

# Alias
alias rl="exec $SHELL -l"
alias vi="nvim"
alias vim="nvim"

# Custom Functions
function memo() {
  local fname=${1:-$(date | awk -F '[":", " "]' '{print $2$3"-"$4":"$5}')}
  vim $HOME/Desktop/temp/$fname'.md'
}

function cdgit() {
  cd $GIT_REPO_ROOT/`ls $GIT_REPO_ROOT | fzf --prompt "Name > "`
}

function gitc() {
  local url=`echo $1 | sed "s/.*github\.com.//" | sed "s/.git//"`
  git clone $1 $GIT_REPO_ROOT/$url
}

function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}


if [ "$(uname)" == 'Darwin' ]; then
    zle -N select-history
    bindkey '^r' select-history
fi
