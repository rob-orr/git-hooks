#!/usr/bin/env bash

# TODO: add event execution time reporting
GA_BASE='https://www.google-analytics.com/collect'
PROTOCOL_VERSION=1
TRACKING_ID='UA-118652049-1'
APP_NAME='git-hooks'
APP_VERSION='1.0'
HIT_TYPE='event'
EVENT_CATEGORY='git-hooks-use'

SALT='8w4ebZhFxw1ZTQAJ3XwouepQshYqgR1W'
user_hash=$(echo -n "${USER}" | openssl dgst -sha256 -hmac "${SALT}" -hex)
large_rand=$((RANDOM * RANDOM * RANDOM))

event_action=''
if [[ ! -z "$1" ]]; then
    event_action="$1"
fi

repo_base_dir=$(git rev-parse --show-toplevel)
if [[ -d "${repo_base_dir}"/.git ]]; then
    # not a worktree
    repo_name=$(basename "${repo_base_dir}")
else
    # in a worktree: get main worktree name
    git_dir=$(git rev-parse --git-common-dir)
    main_repo=$(dirname "${git_dir}")
    repo_name=$(basename "${main_repo}")
fi

# redirect STDOUT to /dev/null
exec 1>&/dev/null

curl --get --silent --show-error --connect-timeout 1 \
    --data-urlencode "v=${PROTOCOL_VERSION}" \
    --data-urlencode "tid=${TRACKING_ID}" \
    --data-urlencode "cid=${user_hash}" \
    --data-urlencode "uid=${user_hash}" \
    --data-urlencode "an=${APP_NAME}" \
    --data-urlencode "av=${APP_VERSION}" \
    --data-urlencode "t=${HIT_TYPE}" \
    --data-urlencode "ec=${EVENT_CATEGORY}" \
    --data-urlencode "ea=${event_action}" \
    --data-urlencode "el=${repo_name}" \
    --data-urlencode "z=${large_rand}" \
    "${GA_BASE}"

exit 0
