#!/bin/sh
# Script to validate JSON file.
# =========================================================
# Run this script to validate JSON file locally before PR.
#   $ ./run-test.sh
# - Requirements: Docker and docker-compose
#
# Also as an alternative local testing you can use CircleCI-
# CLI command (if installed) as below:
#   $ circleci local execute

which docker > /dev/null
if [ $? -ne 0 ]; then
    echo '* Docker not installed.'
    echo 'You need Docker and docker-compose to run the test locally.'
    exit 1
fi

which docker-compose > /dev/null
if [ $? -ne 0 ]; then
    echo '* Docker Compose not installed.'
    echo 'You need docker-compose to run the test locally.'
    exit 1
fi

trap "
    docker-compose -f tests/docker-compose.test.yml down --rmi local --remove-orphans --volumes
    docker container prune -f
    docker image prune -f
" 0

result=0
docker-compose -f tests/docker-compose.test.yml up --build --exit-code-from sut --abort-on-container-exit
if [ $? -ne 0 ]; then
    result=1
    echo '********************************************************'
    echo ' Test fail. See the sut_1 lines above about the error.'
    echo '********************************************************'
    exit 1
fi
echo '**************'
echo ' Test success'
echo '**************'
exit 0
