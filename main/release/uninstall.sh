#!/bin/sh

# Destroy the network

# Remove card
composer card delete -n PeerAdmin@beems-org1-only
composer card delete -n PeerAdmin@beems-org1
composer card delete -n PeerAdmin@beems-org2-only
composer card delete -n PeerAdmin@beems-org2
composer card delete -n bit@beems
composer card delete -n mimos@beems

# Remove app
rm -f *.bna

# clean up
cd ./fabric/networkSetup/
rm -f *.card
cd ./1
rm -f *.card
rm -rf bit composer-logs
cd ../2
rm -f *.card
rm -rf mimos composer-logs

# Up
cd ../
./build.sh -m down -c chbeems -t 100 -s couchdb
docker network prune
