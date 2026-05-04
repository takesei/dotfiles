# Dotfiles

## Requirements
- macOS or Debian-based Linux
- curl

## What the scripts do
- `scripts/commands/bootstrap` installs Homebrew on macOS when needed
- `scripts/commands/bootstrap` installs required packages with `brew` or `apt`
- `scripts/commands/apply` creates `~/.personal_zshrc` and `~/.personal_vimrc` when missing
- `scripts/commands/apply` links the managed dotfiles into your home directory
- `scripts/commands/apply --check` validates the current setup without changing files
- `scripts/env.sh` adds `"$DOTROOT/scripts/commands"` to your PATH
- `installer.sh` stays at the repository root for raw bootstrap installs

## Configuration you'll get
- neovim
- tmux
- git
- zsh
- starship

## New Machine Setup
Run the script below.

```bash
curl -fsSL https://raw.githubusercontent.com/takesei/dotfiles/master/installer.sh -o installer.sh
bash installer.sh
```

If you already have this repository locally, run:

```bash
./scripts/commands/bootstrap
```

## Apply Updates
Use `scripts/commands/apply` after editing files in this repository.

```bash
./scripts/commands/apply
./scripts/commands/apply --dry-run
./scripts/commands/apply --check
./scripts/commands/apply --force
```

## Personal Configuration
Personal config files are seeded into the repository when missing.

- `personal_zshrc`
- `personal_vimrc`

They are created from `personal_zshrc.example` and `personal_vimrc.example`.

## Optional
Install Nerd Fonts during setup:

```bash
INSTALL_NERD_FONTS=1 ./scripts/commands/bootstrap
```
