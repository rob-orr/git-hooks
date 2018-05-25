#!/usr/bin/env bash

if [[ -x "${HOME}/Library/Android/sdk/tools/bin/lint" ]]; then
    "${HOME}/Library/Android/sdk/tools/bin/lint $*"
fi
