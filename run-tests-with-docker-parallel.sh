#!/usr/bin/env sh
set -u

: "${NODES:=3}"

docker-compose -f docker-compose-parallel.yml build verify-tests
docker-compose -f docker-compose-parallel.yml up -d --scale firefoxnode=$NODES selenium-hub firefoxnode 
echo "Waiting $((2+$NODES)) seconds for the nodes to join the selenium hub"
sleep $((2+$NODES))
docker-compose -f docker-compose-parallel.yml \
               run \
               --name verify-tests \
               -e TEST_ENV=${TEST_ENV:-"joint"} \
               verify-tests -n $NODES -o "--strict -f pretty -f junit -o testreport/ $*"
exit_status=$?
docker cp $(docker ps -a -q -f name="verify-tests"):/testreport .
docker-compose -f docker-compose-parallel.yml down 
exit $exit_status
