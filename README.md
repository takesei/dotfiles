# Dotfiles

## Requirements
- macOS or Debian-based Linux
- curl

## What the scripts do
- `scripts/commands/bootstrap` installs Homebrew on macOS when needed
- `scripts/commands/bootstrap` installs required packages with `brew` or `apt`
- `scripts/commands/dotapply` creates `~/.personal_zshrc` and `~/.personal_vimrc` when missing
- `scripts/commands/dotapply` links the managed dotfiles into your home directory
- `scripts/commands/dotapply --check` validates the current setup without changing files
- `env.sh` adds `"$DOTROOT/scripts/commands"` to your PATH
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
./scripts/commands/bootstrap --dry-run
```

## Apply Updates
Use `scripts/commands/dotapply` after editing files in this repository.

```bash
./scripts/commands/dotapply
./scripts/commands/dotapply --dry-run
./scripts/commands/dotapply --check
./scripts/commands/dotapply --force
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
