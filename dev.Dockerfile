from python:3.9-slim


run apt update && \
    apt install -y git curl zsh make gcc sudo
run chsh -s /usr/bin/zsh

run curl -sL install-node.now.sh/lts | bash -s -- --yes
run npm install -g yarn

run apt install -y neovim fzf

env HOME /root
workdir /root

run git clone https://github.com/ryanoasis/nerd-fonts $HOME/.cache/fonts/nerd-fonts
run sudo $HOME/.cache/fonts/nerd-fonts/install.sh

ENV SHELL /usr/bin/zsh
ENV PROMPT '%n@%m %1~ %# '

cmd /usr/bin/zsh
