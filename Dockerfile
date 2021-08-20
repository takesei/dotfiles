from ubuntu:20.04

workdir $HOME

run apt update && \
    apt install -y git neovim curl
