#!/usr/bin/env bash
set -euo pipefail

seed_file_if_missing() {
    local target_file="$1"
    local home_file="$2"
    local template_file="$3"
    local dry_run="$4"

    if [ -f "$target_file" ]; then
        return
    fi

    ensure_directory "$dry_run" "$(dirname "$target_file")"

    if [ -f "$home_file" ] && [ ! -L "$home_file" ]; then
        log "Seeding $target_file from $home_file"
        run_cmd "$dry_run" cp "$home_file" "$target_file"
        return
    fi

    log "Seeding $target_file from $template_file"
    run_cmd "$dry_run" cp "$template_file" "$target_file"
}

prepare_personal_files() {
    local dotroot="$1"
    local dry_run="$2"
    local force="$3"

    seed_file_if_missing "$dotroot/personal_zshrc" "$HOME/.personal_zshrc" "$dotroot/personal_zshrc.example" "$dry_run"
    seed_file_if_missing "$dotroot/personal_vimrc" "$HOME/.personal_vimrc" "$dotroot/personal_vimrc.example" "$dry_run"

    safe_link "$dotroot/personal_zshrc" "$HOME/.personal_zshrc" "$dry_run" "$force"
    safe_link "$dotroot/personal_vimrc" "$HOME/.personal_vimrc" "$dry_run" "$force"
}

ensure_dotfile_directories() {
    local dotroot="$1"
    local dry_run="$2"
    local force="$3"

    log "Creating personal directories"
    ensure_directory "$dry_run" "$GIT_REPO_ROOT"
    ensure_directory "$dry_run" "$TEMP_ROOT"
    ensure_directory "$dry_run" "$XDG_CACHE_HOME"
    ensure_directory "$dry_run" "$XDG_DATA_HOME"
    ensure_directory "$dry_run" "$XDG_STATE_HOME"
    ensure_directory "$dry_run" "$XDG_CONFIG_HOME"

    if [ -d "$HOME/Desktop" ]; then
        safe_link "$TEMP_ROOT" "$HOME/Desktop/temp" "$dry_run" "$force"
    fi
}

configure_git() {
    local dotroot="$1"
    local dry_run="$2"

    log "Configuring Git"
    run_cmd "$dry_run" git config --global commit.template "$dotroot/commit_template"
}

configure_neovim() {
    local dotroot="$1"
    local dry_run="$2"
    local force="$3"

    log "Configuring Neovim"
    safe_link "$dotroot/config/nvim" "$HOME/.config/nvim" "$dry_run" "$force"
}

configure_tmux() {
    local dotroot="$1"
    local dry_run="$2"
    local force="$3"

    log "Configuring tmux"
    safe_link "$dotroot/tmux.conf" "$HOME/.tmux.conf" "$dry_run" "$force"
}

configure_starship() {
    local package_manager="$1"
    local dotroot="$2"
    local dry_run="$3"
    local force="$4"

    log "Configuring starship"
    install_starship "$package_manager" "$dry_run"
    safe_link "$dotroot/config/starship.toml" "$HOME/.config/starship.toml" "$dry_run" "$force"
}

configure_zsh() {
    local dotroot="$1"
    local dry_run="$2"
    local force="$3"

    log "Configuring zsh"
    safe_link "$dotroot/zshrc" "$HOME/.zshrc" "$dry_run" "$force"
}

configure_dotfiles() {
    local package_manager="$1"
    local dotroot="$2"
    local dry_run="$3"
    local force="$4"

    configure_neovim "$dotroot" "$dry_run" "$force"
    configure_tmux "$dotroot" "$dry_run" "$force"
    configure_git "$dotroot" "$dry_run"
    configure_starship "$package_manager" "$dotroot" "$dry_run" "$force"
    configure_zsh "$dotroot" "$dry_run" "$force"
}

check_path_exists() {
    local path_name="$1"
    local failed_ref="$2"

    if [ -e "$path_name" ]; then
        log "Check ok: $path_name"
    else
        error "Check failed: missing $path_name"
        printf -v "$failed_ref" '1'
    fi
}

check_seedable_file() {
    local file_path="$1"
    local template_file="$2"
    local failed_ref="$3"

    if [ -f "$file_path" ]; then
        log "Check ok: $file_path"
    elif [ -f "$template_file" ]; then
        warn "Check warning: $file_path will be created from $template_file on apply"
    else
        error "Check failed: missing seed template $template_file"
        printf -v "$failed_ref" '1'
    fi
}

check_link_target() {
    local source_file="$1"
    local target_file="$2"

    if [ -L "$target_file" ]; then
        if [ "$(canonical_link_target "$target_file")" = "$(canonical_path "$source_file")" ]; then
            log "Check ok: $target_file"
        else
            warn "Check warning: $target_file points to $(readlink "$target_file")"
        fi
        return
    fi

    if [ -e "$target_file" ]; then
        warn "Check warning: $target_file exists and is not a symbolic link"
    else
        warn "Check warning: $target_file does not exist yet"
    fi
}

run_checks() {
    local dotroot="$1"
    local failed=0

    load_env "$dotroot"

    check_path_exists "$dotroot/env.sh" failed
    check_path_exists "$dotroot/commit_template" failed
    check_path_exists "$dotroot/zshrc" failed
    check_path_exists "$dotroot/tmux.conf" failed
    check_path_exists "$dotroot/config/nvim" failed
    check_path_exists "$dotroot/config/starship.toml" failed
    check_path_exists "$dotroot/personal_zshrc.example" failed
    check_path_exists "$dotroot/personal_vimrc.example" failed
    check_seedable_file "$dotroot/personal_zshrc" "$dotroot/personal_zshrc.example" failed
    check_seedable_file "$dotroot/personal_vimrc" "$dotroot/personal_vimrc.example" failed

    check_link_target "$dotroot/personal_zshrc" "$HOME/.personal_zshrc"
    check_link_target "$dotroot/personal_vimrc" "$HOME/.personal_vimrc"
    check_link_target "$dotroot/zshrc" "$HOME/.zshrc"
    check_link_target "$dotroot/tmux.conf" "$HOME/.tmux.conf"
    check_link_target "$dotroot/config/nvim" "$HOME/.config/nvim"
    check_link_target "$dotroot/config/starship.toml" "$HOME/.config/starship.toml"

    if [ "$failed" -ne 0 ]; then
        exit 1
    fi
}
