.PHONY: build
build:
	@docker build -t dotfiles-ubuntu ./

.PHONY: run
run:
	@docker run -i -t dotfiles-ubuntu bash
