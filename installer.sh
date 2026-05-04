#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
BOOTSTRAP_COMMAND="$REPO_ROOT/scripts/commands/bootstrap"

REPOSITORY_URL="${REPOSITORY_URL:-https://github.com/takesei/dotfiles}"
DOTROOT="${DOTROOT:-$HOME/dotfiles}"

log() {
    printf '%s\n' "$1"
}

install_git_for_standalone_installer() {
    if command -v git >/dev/null 2>&1; then
        return
    fi

    case "$(uname -s)" in
        Darwin)
            if ! command -v brew >/dev/null 2>&1; then
                log "Installing Homebrew"
                NONINTERACTIVE=1 /bin/bash -c \
                    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                if [ -x /opt/homebrew/bin/brew ]; then
                    eval "$(/opt/homebrew/bin/brew shellenv)"
                elif [ -x /usr/local/bin/brew ]; then
                    eval "$(/usr/local/bin/brew shellenv)"
                fi
            fi
            brew install git
            ;;
        Linux)
            if command -v apt-get >/dev/null 2>&1; then
                sudo apt-get update
                sudo apt-get install -y git
            else
                printf 'Only Debian-based Linux distributions are supported.\n' >&2
                exit 1
            fi
            ;;
        *)
            printf 'Your platform (%s) is not supported.\n' "$(uname -a)" >&2
            exit 1
            ;;
    esac
}

if [ -f "$BOOTSTRAP_COMMAND" ]; then
    exec "$BOOTSTRAP_COMMAND" "$@"
fi

install_git_for_standalone_installer

if [ ! -d "$DOTROOT/.git" ]; then
    log "Cloning dotfiles into $DOTROOT"
    git clone "$REPOSITORY_URL" "$DOTROOT"
fi

exec "$DOTROOT/scripts/commands/bootstrap" "$@"
