.PHONY: test
test: build
	docker run --rm -v $(PWD)/test:/test \
 	  diff-pdf:latest "--verbose --output-diff=test/diff.pdf" test/a.pdf test/b.pdf true

.PHONY: build
build:
	docker build -t diff-pdf:latest .
