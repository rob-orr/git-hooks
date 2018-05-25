#!/usr/bin/env bash

set -o errexit

repo_root_dir=$(git rev-parse --show-toplevel)
if [[ -e "${repo_root_dir}"/Gemfile ]]; then
    cd "${repo_root_dir}" || exit 127
    bundle exec rubocop "$@"
else
    rubocop "$@"
fi
