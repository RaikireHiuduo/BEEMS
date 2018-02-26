#!/bin/sh

# Stop the network

# stop
cd ./fabric/networkSetup
docker-compose -f ./docker-compose-e2e.yaml -f ./docker-compose-couch.yaml -f ./docker-compose-cas.yaml stop