#!/usr/bin/env sh
set -u

: "${NODES:=6}"

docker-compose build verify-tests
docker-compose up -d --scale firefoxnode=$NODES selenium-hub firefoxnode 
echo "Waiting $((2+NODES)) seconds for the nodes to join the selenium hub"
sleep $((2+NODES))
docker-compose run \
               --name verify-tests \
               -e TEST_ENV="${TEST_ENV:-"staging"}" \
               -e RUNNING_IN_DOCKER=true \
               -e CUCUMBER_PUBLISH_QUIET=true \
               verify-tests -n $NODES -o "--strict -f pretty -f junit -o testreport/ --tags 'not @Eidas' $*"
exit_status=$?
docker cp "$(docker ps -a -q -f name='verify-tests')":/testreport .
docker-compose down 
exit $exit_status
