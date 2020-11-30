#!/usr/bin/env bash

set -e

if [[ "${1:-}" == "--no-parallel" ]]
then
    SHOW_BROWSER=${SHOW_BROWSER:-true}
    INSTANCES=1
    shift
fi

if [[ ! -z $1 ]]
then
  bundle --quiet
  mkdir -p testreport
  SHOW_BROWSER=${SHOW_BROWSER:-false} TEST_ENV=${TEST_ENV:-local} bundle exec cucumber $* --strict --tags 'not @ignore'
  exit $?
fi

bundle --quiet
mkdir -p testreport
SHOW_BROWSER=${SHOW_BROWSER:-false} TEST_ENV=${TEST_ENV:-local} bundle exec parallel_cucumber features/ -n ${INSTANCES:-3} -o "--strict --tags 'not @ignore'"
