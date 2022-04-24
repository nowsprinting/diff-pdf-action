.PHONY: test
test: build
	docker run --rm -v $(PWD)/test:/test \
 	  diff-pdf:latest "--verbose --output-diff=test/diff.pdf" test/review_japanese_1.pdf test/review_japanese_2.pdf true

.PHONY: build
build:
	docker build -t diff-pdf:latest .
