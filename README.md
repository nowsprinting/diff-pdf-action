# diff-pdf-action

[![Build and push Docker image](https://github.com/nowsprinting/diff-pdf-action/actions/workflows/build-image.yml/badge.svg)](https://github.com/nowsprinting/diff-pdf-action/actions/workflows/build-image.yml)

Action for visually comparing two PDF files using [diff-pdf](https://github.com/vslavik/diff-pdf).



## Usage

### Container

```
jobs:
  diff:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/nowsprinting/diff-pdf-action:latest
      options: --init
    steps:
      - run: diff-pdf --output-diff=diff.pdf a.pdf b.pdf
```


### Actions

TBD