.PHONY: run
run: build
	docker run nowsprinting/diff-pdf

.PHONY: build
build:
	docker build -t nowsprinting/diff-pdf .
