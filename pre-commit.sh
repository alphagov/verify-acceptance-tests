#!/usr/bin/env bash

set -e

PARALLEL=true
BROWSER=chrome

while [ "$1" != "" ]; do
    case $1 in
        -f | --firefox)         BROWSER=firefox
                                ;;
        -s | --no-parallel)     PARALLEL=false
                                ;;
        -q | --hide-browser)    SHOW_BROWSER=false
                                ;;
        * )                     break
                                ;;
    esac
    shift
done

if [[ $PARALLEL == "false" ]]
then
    SHOW_BROWSER=${SHOW_BROWSER:-true}
    INSTANCES=1
fi

if [[ -n $1 ]]
then
  TESTS_TO_RUN="$*"
fi

bundle --quiet
mkdir -p testreport
SHOW_BROWSER=${SHOW_BROWSER:-false} TEST_ENV=${TEST_ENV:-local} BROWSER=$BROWSER CUCUMBER_PUBLISH_QUIET=true \
bundle exec parallel_cucumber "${TESTS_TO_RUN:-features/}" -n ${INSTANCES:-3} -o "--strict --tags 'not @staging-only'"
