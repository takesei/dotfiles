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
    command curl $installer > $dir_cache/install.sh
    command sh $dir_cache/install.sh $XDG_CACHE_HOME/dein
    command ln -snf $dotroot/config/nvim $HOME/.config/nvim
}

conf_tmux() {
    command echo "Configure TMUX"
    command ln -snf $dotroot/tmux.conf $HOME/.tmux.conf
}

conf_personal_dir() {
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

conf_zsh() {
    command ln -snf $dotroot/zshrc $HOME/.zshrc
}

conf_starship() {
    if [ $OS = 'MAC' ]; then
        command brew install starship
    elif [ $OS = 'Linux' ]; then
        command sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y
    fi

    command ln -snf $dotroot/config/starship.toml $HOME/.config/starship.toml
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
conf_neovim
conf_tmux
conf_git
conf_starship
conf_zsh

command echo "Instalattion Completed! Type 'exec $SHELL -l' to start."
command echo "Have fun!!"
