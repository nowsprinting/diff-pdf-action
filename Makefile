.PHONY: test
test: build
	docker run --rm -v $(PWD)/test:/test \
 	  diff-pdf:latest "--verbose --output-diff=test/review_japanese_diff_actual.pdf" test/review_japanese_1.pdf test/review_japanese_2.pdf true

.PHONY: build
build:
	docker build -t diff-pdf:latest .
