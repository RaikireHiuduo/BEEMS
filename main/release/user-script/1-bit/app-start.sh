#!/bin/sh

# This assume app-install is done.

CARDNAME="bit@beems"

cd ../../fabric/networkSetup
echo "REST with bit information"
echo
composer network ping -c ${CARDNAME}
composer-rest-server -c ${CARDNAME} -n never -w true