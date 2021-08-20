from ubuntu:20.04


run apt update && \
    apt install -y git curl zsh make gcc
run chsh -s /usr/bin/zsh

run curl -sL install-node.now.sh/lts | bash -s -- --yes
run npm install -g yarn

run apt install -y neovim fzf

workdir /root
