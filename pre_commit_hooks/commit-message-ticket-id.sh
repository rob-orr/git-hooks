#!/usr/bin/env bash

message=$(cat "$1")
if [[ $message != *AN-* ]] &&
    [[ $message != *CLOUD-* ]] &&
    [[ $message != *DOC-* ]] &&
    [[ $message != *DR-* ]] &&
    [[ $message != *GLD-* ]] &&
    [[ $message != *INFRA-* ]] &&
    [[ $message != *IOS-* ]] &&
    [[ $message != *QDD-* ]] &&
    [[ $message != *QE-* ]] &&
    [[ $message != *SP-* ]] &&
    [[ $message != *TC-* ]] &&
    [[ $message != *TEST-* ]] &&
    [[ $message != *"Merge remote-tracking"* ]]; then
    echo "[Appian Code Policy] The commit message must contain a ticket ID."
    echo "Acceptable ticket IDs start with: AN-, CLOUD-, DOC-, DR-, GLD-, INFRA-, IOS-, QDD-, QE-, SP-, TC-, or TEST-."
    exit 1
fi
exit 0
