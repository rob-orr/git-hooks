#!/usr/bin/env bash

set -o hashall
set -o nounset
set -o errexit
set -o xtrace
set -o pipefail

"$@"
