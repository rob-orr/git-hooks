#!/usr/bin/env bash

git fetch -q git@github.com:appian/ae refs/notes/commits
git notes merge -q -s theirs FETCH_HEAD
