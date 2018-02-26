# networkSetup

Based from ["Build Your First Network"](http://hyperledger-fabric.readthedocs.io/en/latest/build_network.html) tutorial.

## Basic specification

## Fabric Information

Orderer: Orderer.

Org | User | Peer count | Admin count
---|---|---|---
1 | bit | 2 | 1
2 | mimos | 2 | 1

Channel name: `chbeems`

### Running notes

```bash
chmod u+x fabric-install.sh
chmod u+x fabric-start.sh
chmod u+x fabric-stop.sh
chmod u+x test.sh
chmod u+x test2.sh
chmod u+x uninstall.sh
chmod u+x user-script/1-bit/app-cp.sh
chmod u+x user-script/1-bit/app-install.sh
chmod u+x user-script/1-bit/app-start.sh
chmod u+x user-script/2-mimos/app-cp.sh
chmod u+x user-script/2-mimos/app-install.sh
chmod u+x user-script/2-mimos/app-start.sh
chmod u+x fabric/networkSetup/scripts/script.sh
chmod u+x fabric/networkSetup/build.sh
chmod u+x fabric/networkSetup/generate.sh

# one-point installer script
./test.sh

# one-point network starter script
./test2.sh
```

## Adding new members

Basically everything needs to be updated. Please consider doing it in this order to save sanity.

in `fabric/networkSetup`:-

1. crypto-config.yaml
1. configtx.yaml
1. docker-compose-cli.yaml (only do this if regenerate from scratch)
1. docker-compose-couch.yaml
1. docker-compose-cas.yaml (template one if regenerate from scratch)
1. docker-compose-e2e.yaml (template one if regenerate from scratch)
1. base/docker-compose-base.yaml
1. base/peer-base.yaml
1. endorse/endorsement-policy.json
1. generate.sh (requires new improvised code if not from scratch)
1. scripts/script.sh (requires new improvised code if not from scratch)

etc stuff to do:-

1. connection information for the new member
1. `user-script` for the new member

## Updating the app

TODO