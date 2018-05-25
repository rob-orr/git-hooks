#!/usr/bin/env bash

set -o hashall
set -o nounset
set -o errexit
set -o pipefail
set -o xtrace

"$@"
exit $?
