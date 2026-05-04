#!/usr/bin/env bash
set -euo pipefail

ensure_directory() {
    local dry_run="$1"
    local target_dir="$2"

    if [ -d "$target_dir" ]; then
        return
    fi

    run_cmd "$dry_run" mkdir -p "$target_dir"
}

canonical_path() {
    local path_name="$1"
    local parent_dir
    local base_name

    parent_dir="$(dirname "$path_name")"
    base_name="$(basename "$path_name")"

    (
        cd "$parent_dir"
        printf '%s/%s\n' "$(pwd -P)" "$base_name"
    )
}

canonical_link_target() {
    local link_path="$1"
    local raw_target

    raw_target="$(readlink "$link_path")"

    if [[ "$raw_target" = /* ]]; then
        canonical_path "$raw_target"
    else
        canonical_path "$(dirname "$link_path")/$raw_target"
    fi
}

backup_target() {
    local dry_run="$1"
    local target_path="$2"
    local backup_path="${target_path}.bak.$(date +%Y%m%dT%H%M%S)"

    log "Backing up $target_path to $backup_path"
    run_cmd "$dry_run" mv "$target_path" "$backup_path"
}

safe_link() {
    local source_file="$1"
    local target_file="$2"
    local dry_run="$3"
    local force="$4"

    ensure_directory "$dry_run" "$(dirname "$target_file")"

    if [ ! -e "$source_file" ] && [ "$dry_run" != "1" ]; then
        error "Source file does not exist: $source_file"
        return 1
    fi

    if [ -L "$target_file" ]; then
        if [ -e "$source_file" ] && [ "$(canonical_link_target "$target_file")" = "$(canonical_path "$source_file")" ]; then
            log "Link already up to date: $target_file"
            return 0
        fi

        if [ ! -e "$source_file" ] && [ "$dry_run" = "1" ]; then
            warn "Source file does not exist yet and is assumed to be created earlier in dry-run: $source_file"
        fi

        log "Updating symbolic link: $target_file -> $source_file"
        run_cmd "$dry_run" ln -snf "$source_file" "$target_file"
        return 0
    fi

    if [ -e "$target_file" ]; then
        if [ "$force" != "1" ]; then
            warn "Refusing to overwrite existing file without --force: $target_file"
            return 1
        fi

        backup_target "$dry_run" "$target_file"
    fi

    if [ ! -e "$source_file" ] && [ "$dry_run" = "1" ]; then
        warn "Source file does not exist yet and is assumed to be created earlier in dry-run: $source_file"
    fi

    log "Creating symbolic link: $target_file -> $source_file"
    run_cmd "$dry_run" ln -snf "$source_file" "$target_file"
}
