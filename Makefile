.PHONY: build
build:
	@docker build -t dotfiles-ubuntu ./

.PHONY: run
run:
	@docker run -i -t -v `pwd`:/root/dotfiles dotfiles-ubuntu
