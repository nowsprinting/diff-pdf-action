# diff-pdf action

[![Docker image](https://github.com/nowsprinting/diff-pdf-action/actions/workflows/build-image.yml/badge.svg)](https://github.com/nowsprinting/diff-pdf-action/actions/workflows/build-image.yml)
[![Test](https://github.com/nowsprinting/diff-pdf-action/actions/workflows/test.yml/badge.svg)](https://github.com/nowsprinting/diff-pdf-action/actions/workflows/test.yml)

Action for visually comparing two PDF files using [diff-pdf](https://github.com/vslavik/diff-pdf).



## Inputs

### file1

Input PDF file1 path.
(required)

### file2

Input PDF file2 path.
(required)

### options

diff-pdf command options.
`[-h] [-v] [-s] [-m] [-g] [--output-diff <str>] [--channel-tolerance <num>] [--dpi <num>]`

```
-h, --help               	show this help message
-v, --verbose            	be verbose
-s, --skip-identical     	only output pages with differences
-m, --mark-differences   	additionally mark differences on left side
-g, --grayscale          	only differences will be in color, unchanged parts will show as gray
--output-diff=<str>      	output differences to given PDF file
--channel-tolerance=<num>	consider channel values to be equal if within specified tolerance
--dpi=<num>              	rasterization resolution (default: 300 dpi)
```

### suppress-diff-error

If set `true`, Exit code to 0 even there is a difference.
(Expected to be used with `--output-diff` option)



## Outputs

None.



## Examples

### Action

#### Expect to match (e.g. visual regression tests)

```yaml
jobs:
  diff:
    runs-on: ubuntu-latest
    steps:
      - uses: nowsprinting/diff-pdf-action@v1
        with:
          file1: expected.pdf
          file2: actual.pdf
          options: --verbose
        # If PDFs do not match, this step will fail.
```

#### View the difference (e.g. before and after pull-request)

```yaml
jobs:
  diff:
    runs-on: ubuntu-latest
    steps:
      - uses: nowsprinting/diff-pdf-action@v1
        with:
          file1: base.pdf
          file2: head.pdf
          options: --skip-identical --output-diff=diff.pdf --dpi=100
          suppress-diff-error: true
```

### Container

```yaml
jobs:
  diff:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/nowsprinting/diff-pdf:latest
    steps:
      - run: diff-pdf "--verbose" expected.pdf actual.pdf
      - run: diff-pdf "--skip-identical --output-diff=diff.pdf --dpi=100" base.pdf head.pdf true
```
