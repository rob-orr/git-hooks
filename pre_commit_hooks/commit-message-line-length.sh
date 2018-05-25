#!/usr/bin/env bash

while read -r line; do
    # Skip comments
    if [ "${line:0:1}" == "#" ]; then
        continue
    fi
    if [ ${#line} -ge 72 ]; then
        echo "[Appian Code Policy] Commit message lines are limited to 72 characters."
        echo "The following commit message line has ${#line} characters:"
        echo "${line}"
        exit 1
    fi
done <"${1}"
exit 0
