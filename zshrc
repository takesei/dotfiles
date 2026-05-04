DOTROOT="${DOTROOT:-$HOME/dotfiles}"

if [ -f "$DOTROOT/env.sh" ]; then
    source "$DOTROOT/env.sh"
fi

if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

if [[ $- == *i* ]] && command -v tmux >/dev/null 2>&1 && [ -z "${TMUX:-}" ]; then
    if tmux has-session -t default 2>/dev/null; then
        exec tmux attach-session -t default
    else
        exec tmux new-session -s default -n main
    fi
fi

export FPATH="$HOME/.zsh/completions:$FPATH"

if [ -d /opt/homebrew/share/zsh-completions ]; then
    export FPATH="/opt/homebrew/share/zsh-completions:$FPATH"
elif [ -d /usr/share/zsh/vendor-completions ]; then
    export FPATH="/usr/share/zsh/vendor-completions:$FPATH"
elif [ -d /usr/share/zsh-completions ]; then
    export FPATH="/usr/share/zsh-completions:$FPATH"
fi

zstyle ':completion:*:*:make:*' tag-order 'targets'
autoload -Uz compinit
compinit

if [ -s /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -s /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi


if [ -f "$HOME/.personal_zshrc" ]; then
    source "$HOME/.personal_zshrc"
fi

if [ -x "$(command -v starship)" ]; then
    case "$(basename "$SHELL")" in
        "bash" ) eval "$(starship init bash)" ;;
        "zsh" ) eval "$(starship init zsh)" ;;
        "fish" ) eval starship init fish | source ;;
        * ) echo "shell [$SHELL] is not supported" ;;
    esac
else
    echo "StarShip is not installed"
    echo "See Also: https://starship.rs"
fi

alias rl="exec $SHELL -l"
alias vi="nvim"

if ls --color=auto >/dev/null 2>&1; then
    alias ls="ls --color=auto"
else
    alias ls="ls -G"
fi

function memo() {
  local defaultname=$(LC_TIME=C date +"%Y-%b%d-%H%M")
  local fname=${1:-$defaultname}
  nvim "$HOME/Desktop/temp/$fname.md"
}

function cdgit() {
  cd "$GIT_REPO_ROOT/$(ls "$GIT_REPO_ROOT" | fzf --prompt "Name > ")"
}

function gitc() {
  local url
  url=$(echo "$1" | sed "s/.*github\.com.//" | sed "s/.git//")
  git clone "$1" "$GIT_REPO_ROOT/$url"
}

function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}


if [ "$(uname)" = "Darwin" ]; then
    zle -N select-history
    bindkey '^r' select-history
fi
