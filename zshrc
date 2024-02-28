## ZSH CONFIG BY DOTFILE
# GLOBAL VARIABLE
export TERM=xterm-256color

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship.toml
export STARSHIP_CACHE=$XDG_CACHE_HOME/starship

export GIT_REPO_ROOT=$HOME/Develop/github.com
export TEMP_ROOT=$HOME/Develop/temp
export BIN_ROOT=$HOME/Develop/bin

export PATH=$BIN_ROOT:$PATH

# Package Settings
source $HOME/.personal_zshrc

if [ -x "$(command -v starship)" ]; then
    case `echo $SHELL | awk -F '/' '{print $NF}'` in
        "bash" ) eval "$(starship init bash)" ;;
        "zsh" ) eval "$(starship init zsh)" ;;
        "fish" ) eval starship init fish | source ;;
        * ) echo "shell [$SHELL] is not supported" ;;
    esac
else
    echo "StarShip is not installed"
    echo "See Also: https://starship.rs"
fi

# Alias
alias rl="exec $SHELL -l"
alias vi="nvim"
alias ls="ls --color=auto"

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


if [ "$(uname)" = "Darwin" ]; then
    zle -N select-history
    bindkey '^r' select-history
fi

