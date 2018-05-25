#!/usr/bin/env bash

GA_BASE='https://www.google-analytics.com/collect'
PROTOCOL_VERSION=1
TRACKING_ID='UA-118652049-1'
APP_NAME='git-hooks'
APP_VERSION='1.0'
HIT_TYPE='event'
EVENT_CATEGORY_PREFIX='git-hooks-'
CONNECT_TIMEOUT=2

SALT='8w4ebZhFxw1ZTQAJ3XwouepQshYqgR1W'
user_hash=$(echo -n "${USER}" | openssl dgst -sha256 -hmac "${SALT}" -hex)
large_rand=$((RANDOM * RANDOM * RANDOM))

category=''
if [[ ! -z "$1" ]]; then
    category="$1"
fi
event_category=${EVENT_CATEGORY_PREFIX}${category}

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
event_action=${repo_name}

event_label='null'
# TODO: add hooks used as event label
# if [[ ! -z "$2" ]]; then
#     event_label="$2"
# fi

event_value=0
if [[ ! -z "$2" ]]; then
    event_value="$2"
else
    ppid_count=1
    parentPID=${PPID}
    parentCmd=$(ps -p "${parentPID}" -o comm=)
    until [[ "${parentCmd}" == 'git' || "${parentPID}" == 1 || ppid_count -eq 20 ]]; do
        parentPID=$(ps -p "${parentPID}" -o ppid=)
        parentCmd=$(ps -p "${parentPID}" -o comm=)
        ((ppid_count += 1))
    done
    if [[ "${parentPID}" == 1 || ppid_count -eq 20 ]]; then
        # 'git' wasn't found...reset to $PPID
        parentPID=${PPID}
    fi
    start_time=$(ps -p "${parentPID}" -o lstart= | xargs -0 date +%s -d)
    end_time=$(date +%s)
    event_value=$(("${end_time}" - "${start_time}"))
fi

# redirect STDOUT to /dev/null
exec 1>&/dev/null

curl --get --silent --show-error --connect-timeout ${CONNECT_TIMEOUT} \
    --data-urlencode "v=${PROTOCOL_VERSION}" \
    --data-urlencode "tid=${TRACKING_ID}" \
    --data-urlencode "cid=${user_hash}" \
    --data-urlencode "uid=${user_hash}" \
    --data-urlencode "an=${APP_NAME}" \
    --data-urlencode "av=${APP_VERSION}" \
    --data-urlencode "t=${HIT_TYPE}" \
    --data-urlencode "ec=${event_category}" \
    --data-urlencode "ea=${event_action}" \
    --data-urlencode "el=${event_label}" \
    --data-urlencode "ev=${event_value}" \
    --data-urlencode "z=${large_rand}" \
    "${GA_BASE}"

# Always return zero so that Git hooks action NEVER fails due to telemetry failing
exit 0
