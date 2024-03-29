.PHONY: build
build:
	@docker build -t dotfiles-ubuntu -f ./dev.Dockerfile ./

.PHONY: build-test
build-test: build
	@docker build -t dotfiles -f ./test.Dockerfile ./

.PHONY: run
run:
	@docker run --rm -i -t -v `pwd`:/root/dotfiles dotfiles-ubuntu

.PHONY: run-test
run-test:
	@docker run --rm -i -t dotfiles
