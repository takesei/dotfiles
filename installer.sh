#!/usr/bin/env bash
set -ue

export repository="https://github.com/takesei/dotfiles"
export dotroot=$HOME/dotfiles
export state=0
export dir_cache
export OS

if [ "$(uname)" == 'Darwin' ]; then
  OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  OS='Linux'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

echo "Set the system with [$OS]"

# Clone repository
if [ ! -d $HOME/dotfiles ]; then
    git clone $repository $dotroot
fi
source $dotroot/zshrc

dir_cache=$XDG_CACHE_HOME/dotfiles

# Configure Functions
conf_git() {
    command echo "Configure Git"
    command git config --global commit.template $dotroot/commit_template
}

conf_neovim() {
    local installer="https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh"

    command echo "Configure Neovim"

    if [ ! -f $dir_cache/install_dein.sh ]; then
        command curl $installer > $dir_cache/install_dein.sh
        command sh $dir_cache/install_dein.sh $XDG_CACHE_HOME/dein
    fi

    command yarn global add neovim
    command pip install --user neovim

    command ln -snf $dotroot/config/nvim $HOME/.config/nvim
}

conf_tmux() {
    command echo "Configure TMUX"
    command ln -snf $dotroot/tmux.conf $HOME/.tmux.conf
}

conf_nerdfont() {
    command echo "Configure NerdFont"
    if [ $OS = 'Mac' ]; then
        if [ `command brew list | grep nerd | wc -l` -eq 0 ]; then
            echo "NERD FONT NOT FOUND"
            command brew tap homebrew/cask-fonts
            command brew install --cask font-hack-nerd-font
        fi
    elif [ $OS = 'Linux' ]; then
        local installer="https://github.com/ryanoasis/nerd-fonts"
        if [ ! -d $XDG_CACHE_HOME/fonts/nerd-fonts ]; then
            echo "NERD FONT NOT FOUND"
            command git clone $installer $XDG_CACHE_HOME/fonts/nerd-fonts
            command sudo $XDG_CACHE_HOME/fonts/nerd-fonts/install.sh
        fi
    fi
}

conf_personal_dir() {
    command echo "Configure Personal directory Structure"
    command mkdir -p $GIT_REPO_ROOT
    command mkdir -p $TEMP_ROOT
    command mkdir -p $XDG_CACHE_HOME
    command mkdir -p $XDG_DATA_HOME
    command mkdir -p $XDG_STATE_HOME
    command mkdir -p $XDG_CONFIG_HOME
    command ln -snf $dotroot/bin $BIN_ROOT

    if [ -d $HOME/Desktop ]; then
        command ln -snf $TEMP_ROOT $HOME/Desktop/temp
    fi
}

conf_starship() {
    command echo "Configure StarShip"

    if [ ! -x "$(command -v starship)" ]; then
        if [ $OS = 'Mac' ]; then
            command brew install starship
        elif [ $OS = 'Linux' ]; then
            command sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y
        fi
    fi

    command ln -snf $dotroot/config/starship.toml $HOME/.config/starship.toml
}

conf_zsh() {
    command echo "Configure Zsh"
    command ln -snf $dotroot/zshrc $HOME/.zshrc
}

# Create Cache Directory
if [ ! -d $dir_cache ]; then
    command mkdir -p $dir_cache
fi

# Check Logfile
if [ ! -f $dir_cache/log.txt ]; then
    command touch $dir_cache/log.txt
else
    state=1
    command echo "Found log.txt, state is $state"
fi

# Configure
conf_personal_dir
conf_nerdfont
conf_neovim
conf_tmux
conf_git
conf_starship
conf_zsh

command echo "Instalattion Completed! Type 'exec $SHELL -l' to start."
command echo "Have fun!!"
