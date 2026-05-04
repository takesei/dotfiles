# Dotfiles

## Requirements
- macOS or Debian-based Linux
- curl

## What the installer does
- installs Homebrew on macOS when needed
- installs required packages with `brew` or `apt`
- creates `~/.personal_zshrc` from `personal_zshrc.example` when missing
- creates `~/.personal_vimrc` from `personal_vimrc.example` when missing
- links the managed dotfiles into your home directory

## Configuration you'll get
- neovim
- tmux
- git
- zsh
- starship

## How to Install
Run the script below.

```
curl -fsSL https://raw.githubusercontent.com/takesei/dotfiles/master/installer.sh -o installer.sh
bash installer.sh
```

## Optional
Install Nerd Fonts during setup:

```bash
INSTALL_NERD_FONTS=1 bash installer.sh
```
