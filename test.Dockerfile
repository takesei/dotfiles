from dotfiles-ubuntu:latest

RUN useradd -ms /bin/bash newuser
run adduser newuser sudo
user newuser

workdir /home/newuser
run curl https://raw.githubusercontent.com/takesei/dotfiles/master/installer.sh > installer.sh
run bash installer.sh

cmd ['bash']
