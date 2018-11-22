#!/usr/bin/env sh
set -u

docker-compose -f docker-compose-parallel.yml build verify-tests
docker-compose -f docker-compose-parallel.yml up -d --scale firefoxnode=3 selenium-hub firefoxnode 
echo "Waiting 5s for the nodes to join the selenium hub"
sleep 5
docker-compose -f docker-compose-parallel.yml \
               run \
               --name verify-tests \
               -e TEST_ENV=${TEST_ENV:-"joint"} \
               verify-tests -n 3 -o "--strict -f pretty -f junit -o testreport/ $*"
exit_status=$?
docker cp $(docker ps -a -q -f name="verify-tests"):/testreport .
docker-compose -f docker-compose-parallel.yml down 
exit $exit_status
