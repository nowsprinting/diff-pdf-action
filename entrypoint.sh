#!/bin/sh -l

# shellcheck disable=SC2086
diff-pdf $1 $2 $3

rc=$?
if [ $rc = 1 ] && [ "$4" = "true" ]; then
  # suppress diff error
  exit 0
else
  exit $rc
fi
