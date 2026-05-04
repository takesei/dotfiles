#!/usr/bin/env bash
set -euo pipefail

REPOSITORY_URL="${REPOSITORY_URL:-https://github.com/takesei/dotfiles}"
DOTROOT="${DOTROOT:-$HOME/dotfiles}"
INSTALL_NERD_FONTS="${INSTALL_NERD_FONTS:-0}"

OS=""
PACKAGE_MANAGER=""
APT_UPDATED=0

log() {
    printf '%s\n' "$1"
}

warn() {
    printf 'Warning: %s\n' "$1" >&2
}

run_as_root() {
    if [ "$(id -u)" -eq 0 ]; then
        "$@"
    else
        sudo "$@"
    fi
}

detect_os() {
    case "$(uname -s)" in
        Darwin)
            OS="mac"
            PACKAGE_MANAGER="brew"
            ;;
        Linux)
            OS="linux"
            PACKAGE_MANAGER="apt"
            ;;
        *)
            printf 'Your platform (%s) is not supported.\n' "$(uname -a)" >&2
            exit 1
            ;;
    esac
}

validate_platform() {
    if [ "$PACKAGE_MANAGER" = "apt" ] && ! command -v apt-get >/dev/null 2>&1; then
        printf 'Only Debian-based Linux distributions are supported.\n' >&2
        exit 1
    fi
}

ensure_homebrew() {
    if command -v brew >/dev/null 2>&1; then
        return
    fi

    log "Installing Homebrew"
    NONINTERACTIVE=1 /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

activate_homebrew() {
    if command -v brew >/dev/null 2>&1; then
        return
    fi

    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
}

apt_update_once() {
    if [ "$APT_UPDATED" -eq 1 ]; then
        return
    fi

    run_as_root apt-get update
    APT_UPDATED=1
}

bootstrap_package_manager() {
    if [ "$PACKAGE_MANAGER" = "brew" ]; then
        ensure_homebrew
        activate_homebrew
    fi
}

package_installed() {
    local package_name="$1"

    if [ "$PACKAGE_MANAGER" = "brew" ]; then
        brew list "$package_name" >/dev/null 2>&1
    else
        dpkg -s "$package_name" >/dev/null 2>&1
    fi
}

install_package() {
    local package_name="$1"

    if package_installed "$package_name"; then
        return
    fi

    if [ "$PACKAGE_MANAGER" = "brew" ]; then
        brew install "$package_name"
    else
        apt_update_once
        run_as_root apt-get install -y "$package_name"
    fi
}

ensure_git_available() {
    if command -v git >/dev/null 2>&1; then
        return
    fi

    log "Installing git"
    install_package git
}

clone_repository() {
    if [ -d "$DOTROOT" ]; then
        return
    fi

    log "Cloning dotfiles into $DOTROOT"
    git clone "$REPOSITORY_URL" "$DOTROOT"
}

load_env() {
    # shellcheck disable=SC1091
    . "$DOTROOT/env.sh"
}

required_packages() {
    if [ "$PACKAGE_MANAGER" = "brew" ]; then
        printf '%s\n' \
            git \
            curl \
            zsh \
            tmux \
            neovim \
            fzf \
            ripgrep \
            starship \
            zsh-autosuggestions
    else
        printf '%s\n' \
            git \
            curl \
            zsh \
            tmux \
            neovim \
            fzf \
            ripgrep \
            zsh-autosuggestions
    fi
}

install_required_packages() {
    local package_name

    log "Installing required packages with $PACKAGE_MANAGER"

    while IFS= read -r package_name; do
        install_package "$package_name"
    done < <(required_packages)
}

ensure_starship_available() {
    if command -v starship >/dev/null 2>&1; then
        return
    fi

    log "Installing starship"

    if [ "$PACKAGE_MANAGER" = "brew" ]; then
        install_package starship
    else
        curl -fsSL https://starship.rs/install.sh | sh -s -- -y
    fi
}

install_nerd_fonts() {
    if [ "$INSTALL_NERD_FONTS" != "1" ]; then
        log "Skipping Nerd Font installation (set INSTALL_NERD_FONTS=1 to enable)"
        return
    fi

    if [ "$PACKAGE_MANAGER" = "brew" ]; then
        log "Installing Nerd Fonts"
        brew tap homebrew/cask-fonts
        brew install --cask font-hack-nerd-font
        brew install --cask font-mplus-nerd-font
    else
        warn "Automatic Nerd Font installation is not configured for Debian. Install fonts manually if needed."
    fi
}

ensure_directory() {
    mkdir -p "$1"
}

ensure_directories() {
    log "Creating personal directories"
    ensure_directory "$GIT_REPO_ROOT"
    ensure_directory "$TEMP_ROOT"
    ensure_directory "$XDG_CACHE_HOME"
    ensure_directory "$XDG_DATA_HOME"
    ensure_directory "$XDG_STATE_HOME"
    ensure_directory "$XDG_CONFIG_HOME"

    ln -snf "$DOTROOT/bin" "$BIN_ROOT"

    if [ -d "$HOME/Desktop" ]; then
        ln -snf "$TEMP_ROOT" "$HOME/Desktop/temp"
    fi
}

copy_template_if_missing() {
    local source_file="$1"
    local target_file="$2"

    if [ -f "$target_file" ]; then
        return
    fi

    cp "$source_file" "$target_file"
}

prepare_personal_files() {
    log "Preparing personal configuration files"
    copy_template_if_missing "$DOTROOT/personal_zshrc.example" "$HOME/.personal_zshrc"
    copy_template_if_missing "$DOTROOT/personal_vimrc.example" "$HOME/.personal_vimrc"
}

link_file() {
    local source_file="$1"
    local target_file="$2"

    ln -snf "$source_file" "$target_file"
}

configure_git() {
    log "Configuring Git"
    git config --global commit.template "$DOTROOT/commit_template"
}

configure_neovim() {
    log "Configuring Neovim"
    ensure_directory "$HOME/.config"
    link_file "$DOTROOT/config/nvim" "$HOME/.config/nvim"
}

configure_tmux() {
    log "Configuring tmux"
    link_file "$DOTROOT/tmux.conf" "$HOME/.tmux.conf"
}

configure_starship() {
    log "Configuring starship"
    ensure_starship_available
    ensure_directory "$HOME/.config"
    link_file "$DOTROOT/config/starship.toml" "$HOME/.config/starship.toml"
}

configure_zsh() {
    log "Configuring zsh"
    link_file "$DOTROOT/zshrc" "$HOME/.zshrc"
}

configure_dotfiles() {
    configure_neovim
    configure_tmux
    configure_git
    configure_starship
    configure_zsh
}

main() {
    detect_os
    validate_platform
    log "Detected platform: $OS"

    bootstrap_package_manager
    ensure_git_available
    clone_repository
    load_env

    bootstrap_package_manager
    install_required_packages
    ensure_directories
    prepare_personal_files
    install_nerd_fonts
    configure_dotfiles

    log "Installation completed. Type 'exec \$SHELL -l' to start."
}

main "$@"
