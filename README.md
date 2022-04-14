# diff-pdf-action

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