#!/bin/sh

# Build up the network and app

# Uninstall everything first.
./uninstall.sh

# Rebuild the network
cd ./fabric/networkSetup
./build.sh -m generate
./build.sh -m up -c chbeems -t 100 -s couchdb -a
