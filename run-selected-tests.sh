#!/usr/bin/env bash

cd `dirname $0`

set -eu

TESTS=""

while (( $# )); do
    if [[ "${1:-}" == "--show-browser" ]]
    then
        SHOW_BROWSER="true"
    else
        TESTS="$TESTS $1"
    fi
    shift
done

bundle --quiet
mkdir -p testreport
SHOW_BROWSER=${SHOW_BROWSER:-"false"} TEST_ENV=local bundle exec cucumber --strict $TESTS