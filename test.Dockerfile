FROM dotfiles-ubuntu:latest

RUN useradd -ms /bin/bash newuser
RUN adduser newuser sudo
USER newuser

WORKDIR /home/newuser
run curl https://raw.githubusercontent.com/takesei/dotfiles/master/installer.sh > installer.sh
RUN bash installer.sh

CMD ['bash']
