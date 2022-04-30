# diff-pdf-action

[![Docker build](https://github.com/nowsprinting/diff-pdf-action/actions/workflows/build-image.yml/badge.svg)](https://github.com/nowsprinting/diff-pdf-action/actions/workflows/build-image.yml)
[![Test](https://github.com/nowsprinting/diff-pdf-action/actions/workflows/test.yml/badge.svg)](https://github.com/nowsprinting/diff-pdf-action/actions/workflows/test.yml)

Action for visually comparing two PDF files using [diff-pdf](https://github.com/vslavik/diff-pdf).

By default, This action is successful if there are no differences and failure if the two PDFs differ.
If given the `--output-diff` option, it produces a PDF file with visually highlighted differences.


## Inputs

### file1

Input PDF file1 path.
(required)

### file2

Input PDF file2 path.
(required)

### options

Specify diff-pdf command options if you need.
Follows are quoted from `diff-pdf --help`:

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

Note: `--view` option is not available.

### suppress-diff-error

If set `true`, Exit code to 0 even there is a difference.
(Expected to be used with `--output-diff` option)


## Outputs

None.

Note: Output following log when running this action. However, don't worry there is no problem.
```bash
Unable to init server: Could not connect: Connection refused
01:20:19: Error: Unable to initialize GTK+, is DISPLAY set properly?
```


## Examples

### Using action

#### Expect to match (e.g. visual regression tests)

```yaml
jobs:
  diff:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3
      - uses: nowsprinting/diff-pdf-action@v1
        with:
          file1: expected.pdf
          file2: actual.pdf
          options: --verbose
        # If PDFs do not match, this step will fail.
```

#### Generate diff PDF (e.g. before and after on pull-request)

```yaml
jobs:
  diff:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3
      - uses: nowsprinting/diff-pdf-action@v1
        with:
          file1: base.pdf
          file2: head.pdf
          options: --skip-identical --output-diff=diff.pdf --dpi=100
          suppress-diff-error: true
```

### Using container

```yaml
jobs:
  diff:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/nowsprinting/diff-pdf:latest

    steps:
      - uses: actions/checkout@v3
      - run: diff-pdf --verbose expected.pdf actual.pdf
```


## License

MIT License


## How to contribute

Open an issue or create a pull request.
