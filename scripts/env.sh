#!/usr/bin/env sh

export TERM="${TERM:-xterm-256color}"

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

export STARSHIP_CONFIG="${STARSHIP_CONFIG:-$XDG_CONFIG_HOME/starship.toml}"
export STARSHIP_CACHE="${STARSHIP_CACHE:-$XDG_CACHE_HOME/starship}"

export GIT_REPO_ROOT="${GIT_REPO_ROOT:-$HOME/Develop/github.com}"
export TEMP_ROOT="${TEMP_ROOT:-$HOME/Develop/temp}"
export DOTROOT="${DOTROOT:-$HOME/dotfiles}"

case ":$PATH:" in
    *":$DOTROOT/scripts/commands:"*) ;;
    *) export PATH="$DOTROOT/scripts/commands:$PATH" ;;
esac
