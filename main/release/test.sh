#!/bin/sh

# Build from scratch

# const
CURDIR=`pwd`
archive=`pwd`"/beems@0.0.1.bna"

# Install
./fabric-install.sh

# Generate the .bna file.
cd ../beems
composer archive create -t dir -n . -a ${archive}

# go to user-script to build up the network.
cd ${CURDIR}/user-script

# install certs and stuff. This is important
echo "Doing 1"
echo
cd ./1-bit
./app-cp.sh
echo "Doing 2"
echo
cd ../2-mimos
./app-cp.sh

# install the app to the network. Do not do this until having everyone public key information.
echo "Doing 1 app"
echo
cd ../1-bit
./app-install.sh
echo "Doing 2 app"
echo
cd ../2-mimos
./app-install.sh

# start with bit
cd ../1-bit
./app-start.sh
