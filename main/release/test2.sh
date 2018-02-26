#!/bin/sh

# start from sleeping dead state

# start the fabric network
./fabric-start.sh

# start with bit
cd ./user-script/1-bit
./app-start.sh
