FROM python:3.9-slim

RUN apt update && \
    apt install -y git curl zsh make gcc sudo
RUN chsh -s /usr/bin/zsh

RUN curl -sL install-node.now.sh/lts | bash -s -- --yes
RUN npm install -g yarn


ENV HOME /root
RUN git clone https://github.com/ryanoasis/nerd-fonts $HOME/.cache/fonts/nerd-fonts
RUN sudo $HOME/.cache/fonts/nerd-fonts/install.sh


ENV SHELL /usr/bin/zsh
RUN apt install -y neovim fzf ripgrep

WORKDIR $HOME
ENV PROMPT '%n@%m %1~ %# '

CMD /usr/bin/zsh
