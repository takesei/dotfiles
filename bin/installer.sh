#!/usr/bin/env bash
set -ue

source zshrc

local dir_cache=$XDG_CACHE_HOME/dotfiles
local state=0

conf_git() {
    command echo "Configure Git"
    command git config --global commit.template commit_template
}

conf_neovim() {
    command echo "Configure Neovim"
    # Install Dein
    local installer="https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh"
    command curl $installer > $dir_cache/install.sh
    command sh ./install.sh

    ln -snf ./config/nvim $HOME/.config/nvim
}

conf_tmux() {
    command echo "Configure TMUX"
    ln -snf ./tmux.conf $HOME/.tmux.conf
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
conf_neovim
conf_git

command echo "Instalattion Completed! Have fun!!"
