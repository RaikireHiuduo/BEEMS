#!/bin/sh

# This assume app-install is done.

CARDNAME="mimos@beems"

cd ../../fabric/networkSetup
echo "REST with mimos information"
echo
composer network ping -c ${CARDNAME}
composer-rest-server -c ${CARDNAME} -n never -w true