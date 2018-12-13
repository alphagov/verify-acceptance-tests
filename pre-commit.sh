#!/usr/bin/env bash

set -eu

if [[ "${1:-}" == "--no-parallel" ]]
then
    SHOW_BROWSER=${SHOW_BROWSER:-true}
    INSTANCES=1
fi

bundle --quiet
mkdir -p testreport
SHOW_BROWSER=${SHOW_BROWSER:-false} TEST_ENV=local bundle exec parallel_cucumber features/ -n ${INSTANCES:-3} -o "--strict"
