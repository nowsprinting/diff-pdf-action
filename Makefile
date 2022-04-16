.PHONY: test
test: build
	docker run --rm -v $(PWD)/test:/test \
 	  nowsprinting/diff-pdf --output-diff=test/diff.pdf test/a.pdf test/b.pdf

.PHONY: build
build:
	docker build -t nowsprinting/diff-pdf .
