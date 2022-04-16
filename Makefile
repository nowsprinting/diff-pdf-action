.PHONY: test
test: build
	docker run --rm -v $(PWD)/test:/test \
 	  diff-pdf --verbose --output-diff=test/diff.pdf test/a.pdf test/b.pdf

.PHONY: build
build:
	docker build -t diff-pdf .
