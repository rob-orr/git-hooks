#!/usr/bin/env bash

exec < /dev/tty

num_files=$(git diff --cached --name-status | wc -l)
if [[ ${num_files} -gt 40 ]]; then
    echo "[Appian Code Policy] The number of files in a PR must be 40 or fewer."
    read -r -n 1 -p "Override? [y/N] " reply
    echo -e "\\n"
    if [[ ${reply} != "y" && ${reply} != "Y" ]]; then
        exit 1
    fi
fi
exit 0
