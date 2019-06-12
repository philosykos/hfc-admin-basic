#!/bin/bash
set -ev

docker-compose -f docker-compose-poc.yaml kill && docker-compose -f docker-compose-poc.yaml down --remove-orphans

# remove the local state
rm -f ~/.hfc-key-store/*

# remove chaincode docker images
docker rm $(docker ps -aq)
docker rmi $(docker images dev-* -q)
