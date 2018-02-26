#!/bin/bash

# SPDX-License-Identifier: Apache-2.0

# --------------------------------------------------
# export

# prepending $PWD/../bin to PATH to ensure we are picking up the correct binaries
# this may be commented out to resolve installed version of tools if desired
export PATH=${PWD}/../bin:${PWD}:$PATH
export FABRIC_CFG_PATH=${PWD}

# --------------------------------------------------

# Obtain CONTAINER_IDS and remove them
# TODO Might want to make this optional - could clear other containers
function clearContainers () {
  CONTAINER_IDS=$(docker ps -aq)
  if [ -z "$CONTAINER_IDS" -o "$CONTAINER_IDS" == " " ]; then
    echo "---- No containers available for deletion ----"
  else
    docker rm -f $CONTAINER_IDS
  fi
}

# Delete any images that were generated as a part of this setup
# specifically the following images are often left behind:
# TODO list generated image naming patterns
function removeUnwantedImages() {
  DOCKER_IMAGE_IDS=$(docker images | grep "dev\|none\|test-vp\|peer[0-9]-" | awk '{print $3}')
  if [ -z "$DOCKER_IMAGE_IDS" -o "$DOCKER_IMAGE_IDS" == " " ]; then
    echo "---- No images available for deletion ----"
  else
    docker rmi -f $DOCKER_IMAGE_IDS
  fi
}

# Generate the needed certificates, the genesis block and start the network.
function networkUp () {
  # generate artifacts if they don't exist
  if [ ! -d "crypto-config" ]; then
    ./generate.sh ${CHANNEL_NAME}
  fi

  COMPOSE_FILE_ADDITIONS=""
  if [ "${IF_COUCHDB}" == "couchdb" ]; then
    COMPOSE_FILE_ADDITIONS="${COMPOSE_FILE_ADDITIONS} -f $COMPOSE_FILE_COUCH"
  fi
  if [ "${IF_CAS}" == "1" ]; then
    COMPOSE_FILE_ADDITIONS="${COMPOSE_FILE_ADDITIONS} -f $COMPOSE_FILE_CAS"
  fi

  CHANNEL_NAME=$CHANNEL_NAME TIMEOUT=$CLI_TIMEOUT DELAY=$CLI_DELAY LANG=$LANGUAGE docker-compose -f ${COMPOSE_FILE}${COMPOSE_FILE_ADDITIONS} up -d 2>&1
  if [ $? -ne 0 ]; then
    echo "ERROR !!!! Unable to start network"
    docker logs -f cli
    exit 1
  fi
  
  docker logs -f cli
}

# Tear down running network
function networkDown () {
  docker-compose -f $COMPOSE_FILE down
  docker-compose -f $COMPOSE_FILE -f $COMPOSE_FILE_COUCH down
  if [ -f ${COMPOSE_FILE_CAS} ]; then
    docker-compose -f $COMPOSE_FILE -f $COMPOSE_FILE_CAS down
  fi
  # Don't remove containers, images, etc if restarting
  if [ "$MODE" != "restart" ]; then
    #Cleanup the chaincode containers
    clearContainers
    #Cleanup images
    removeUnwantedImages
    # remove orderer block and other channel configuration transactions and certs
    rm -rf channel-artifacts/*.block channel-artifacts/*.tx crypto-config ./org3-artifacts/crypto-config/ channel-artifacts/org3.json
    # remove the docker-compose yaml file that was customized to the example
    rm -f docker-compose-e2e.yaml docker-compose-cas.yaml
  fi
}


# ---

# Obtain the OS and Architecture string that will be used to select the correct
# native binaries for your platform
OS_ARCH=$(echo "$(uname -s|tr '[:upper:]' '[:lower:]'|sed 's/mingw64_nt.*/windows/')-$(uname -m | sed 's/x86_64/amd64/g')" | awk '{print tolower($0)}')
# timeout duration - the duration the CLI should wait for a response from
# another container before giving up
CLI_TIMEOUT=100
#default for delay
CLI_DELAY=3
# channel name defaults to "chbeems"
CHANNEL_NAME="chbeems"
# use this as the default docker-compose yaml definition
COMPOSE_FILE=docker-compose-cli.yaml
#
COMPOSE_FILE_COUCH=docker-compose-couch.yaml
#
COMPOSE_FILE_CAS=docker-compose-cas.yaml
# use golang as the default language for chaincode
LANGUAGE=golang
# Parse commandline args
while getopts "h?m:c:t:d:f:s:l:a?" opt; do
  case "$opt" in
    h|\?)
      printHelp
      exit 0
    ;;
    m)  MODE=$OPTARG
    ;;
    c)  CHANNEL_NAME=$OPTARG
    ;;
    t)  CLI_TIMEOUT=$OPTARG
    ;;
    d)  CLI_DELAY=$OPTARG
    ;;
    f)  COMPOSE_FILE=$OPTARG
    ;;
    s)  IF_COUCHDB=$OPTARG
    ;;
    l)  LANGUAGE=$OPTARG
    ;;
    a)  IF_CAS=1
    ;;
  esac
done

# Determine whether starting, stopping, restarting or generating for announce
if [ "$MODE" == "up" ]; then
  EXPMODE="Starting"
  elif [ "$MODE" == "down" ]; then
  EXPMODE="Stopping"
  elif [ "$MODE" == "generate" ]; then
  EXPMODE="Generating certs and genesis block for"
else
  printHelp
  exit 1
fi

# Announce what was requested
ADDITIONS=""
if [ "${IF_COUCHDB}" == "couchdb" ]; then
  ADDITIONS="${ADDITIONS} and using database '${IF_COUCHDB}'"
fi
if [ "${IF_CAS}" == "1" ]; then
  ADDITIONS="${ADDITIONS} and using Fabric CAs"
fi
echo "${EXPMODE} with channel '${CHANNEL_NAME}' and CLI timeout of '${CLI_TIMEOUT}' seconds and CLI delay of '${CLI_DELAY}' seconds${ADDITIONS}"

#Create the network using docker compose
if [ "${MODE}" == "up" ]; then
  networkUp
  elif [ "${MODE}" == "down" ]; then ## Clear the network
  networkDown
  elif [ "${MODE}" == "generate" ]; then ## Generate Artifacts
  ./generate.sh ${CHANNEL_NAME}
else
  printHelp
  exit 1
fi
