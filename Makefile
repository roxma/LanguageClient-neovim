all: fmt build

build-docker-image: Dockerfile
	docker build --tag autozimu/languageclientneovim .

publish-docker-image:
	docker push autozimu/languageclientneovim

fmt:
	cargo fmt

build:
	cargo build
	# cargo build --features clippy

release:
	cargo build --release
	mkdir -p bin
	cp --force target/release/languageclient bin/

test:
	cargo test

integration-test-lint:
	mypy tests rplugin/python3/denite/source rplugin/python3/deoplete/sources
	flake8 .

integration-test: build integration-test-lint
	tests/test.sh
