#!/usr/bin/env bash
set -euo pipefail

APT_UPDATED=0

is_package_installed() {
    local package_manager="$1"
    local package_name="$2"

    if [ "$package_manager" = "brew" ]; then
        brew list "$package_name" >/dev/null 2>&1
    else
        dpkg -s "$package_name" >/dev/null 2>&1
    fi
}

install_package() {
    local package_manager="$1"
    local dry_run="$2"
    local package_name="$3"

    if is_package_installed "$package_manager" "$package_name"; then
        return
    fi

    if [ "$package_manager" = "brew" ]; then
        run_cmd "$dry_run" brew install "$package_name"
    else
        apt_update_once "$dry_run"
        run_as_root "$dry_run" apt-get install -y "$package_name"
    fi
}

apt_update_once() {
    local dry_run="$1"

    if [ "$APT_UPDATED" = "1" ]; then
        return
    fi

    run_as_root "$dry_run" apt-get update
    APT_UPDATED=1
}

read_package_file() {
    local file_path="$1"

    [ -f "$file_path" ] || return 0

    while IFS= read -r package_name; do
        case "$package_name" in
            ''|'#'*)
                continue
                ;;
            *)
                printf '%s\n' "$package_name"
                ;;
        esac
    done < "$file_path"
}

install_required_packages() {
    local package_manager="$1"
    local dotroot="$2"
    local dry_run="$3"
    local package_name

    log "Installing required packages with $package_manager"

    while IFS= read -r package_name; do
        [ -n "$package_name" ] || continue
        install_package "$package_manager" "$dry_run" "$package_name"
    done < <(
        read_package_file "$dotroot/packages/common.txt"
        read_package_file "$dotroot/packages/$package_manager.txt"
    )
}

can_install_starship_with_apt() {
    apt-cache show starship >/dev/null 2>&1
}

install_starship() {
    local package_manager="$1"
    local dry_run="$2"

    if has_command starship; then
        return
    fi

    case "$package_manager" in
        brew)
            install_package "$package_manager" "$dry_run" starship
            ;;
        apt)
            apt_update_once "$dry_run"
            if can_install_starship_with_apt; then
                install_package "$package_manager" "$dry_run" starship
            else
                warn "starship is not available via apt on this system. Skipping installation."
            fi
            ;;
        *)
            error "Unsupported package manager for starship: $package_manager"
            exit 1
            ;;
    esac
}

install_git_if_missing() {
    local package_manager="$1"
    local dry_run="$2"

    if has_command git; then
        return
    fi

    log "Installing git"

    install_package "$package_manager" "$dry_run" git
}
