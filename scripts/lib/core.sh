#!/usr/bin/env bash
set -euo pipefail

log() {
    printf '%s\n' "$1"
}

warn() {
    printf 'Warning: %s\n' "$1" >&2
}

error() {
    printf 'Error: %s\n' "$1" >&2
}

run_cmd() {
    local dry_run="$1"
    shift

    if [ "$dry_run" = "1" ]; then
        printf '[dry-run] %s\n' "$*"
        return 0
    fi

    "$@"
}

run_as_root() {
    local dry_run="$1"
    shift

    if [ "$dry_run" = "1" ]; then
        printf '[dry-run] %s\n' "$*"
        return 0
    fi

    if [ "$(id -u)" -eq 0 ]; then
        "$@"
    else
        sudo "$@"
    fi
}

detect_os() {
    case "$(uname -s)" in
        Darwin)
            printf 'mac\n'
            ;;
        Linux)
            printf 'linux\n'
            ;;
        *)
            error "Your platform ($(uname -a)) is not supported."
            exit 1
            ;;
    esac
}

package_manager_for_os() {
    local os_name="$1"

    case "$os_name" in
        mac)
            printf 'brew\n'
            ;;
        linux)
            printf 'apt\n'
            ;;
        *)
            error "Unsupported OS: $os_name"
            exit 1
            ;;
    esac
}

validate_platform() {
    local package_manager="$1"

    if [ "$package_manager" = "apt" ] && ! command -v apt-get >/dev/null 2>&1; then
        error "Only Debian-based Linux distributions are supported."
        exit 1
    fi
}

has_command() {
    command -v "$1" >/dev/null 2>&1
}

has_cloned_repository() {
    local dotroot="$1"

    [ -d "$dotroot/.git" ]
}

clone_repository() {
    local repository_url="$1"
    local dotroot="$2"
    local dry_run="$3"

    log "Cloning dotfiles into $dotroot"
    run_cmd "$dry_run" git clone "$repository_url" "$dotroot"
}

ensure_homebrew() {
    local dry_run="$1"

    if has_command brew; then
        return
    fi

    log "Installing Homebrew"
    if [ "$dry_run" = "1" ]; then
        printf '[dry-run] install Homebrew\n'
        return
    fi

    NONINTERACTIVE=1 /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

activate_homebrew() {
    if has_command brew; then
        return
    fi

    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
}

bootstrap_package_manager() {
    local package_manager="$1"
    local dry_run="$2"

    if [ "$package_manager" = "brew" ]; then
        ensure_homebrew "$dry_run"
        activate_homebrew
    fi
}

load_env() {
    local dotroot="$1"

    # shellcheck disable=SC1091
    source "$dotroot/scripts/env.sh"
}
