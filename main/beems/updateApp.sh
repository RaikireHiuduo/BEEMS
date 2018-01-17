#!/bin/sh

# Create and update the application in the fabric network.
# make sure the fabric network is up before use.

# const
archive="beems@0.0.1.bna"
adminNetwork="admin@beems"

# Generate the .bna file and update the application in the network.
composer archive create -t dir -n . -a ${archive}
composer network update -a ${archive} -c ${adminNetwork}
