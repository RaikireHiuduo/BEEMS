#!/bin/sh

# Start the network

# start
cd ./fabric/networkSetup
docker-compose -f ./docker-compose-e2e.yaml -f ./docker-compose-couch.yaml -f ./docker-compose-cas.yaml stop
docker-compose -f ./docker-compose-e2e.yaml -f ./docker-compose-couch.yaml -f ./docker-compose-cas.yaml start

# Wait for network to wake up, brush teeth, wear underwear, and cleanup. Can't have the network walking out naked.
sleep 100