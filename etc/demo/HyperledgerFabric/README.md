# tl;dr

1. Install a lot of components just to get Hyperledger Fabric running. Get the Hyperledger Fabric binaries manually by script because there is no one-click installer.
1. Pick a poison either as a developer (one that build the application and/or chaincode specifically) or as a network operator (aka system administrator; one that implement the developer's chaincode to run).
   1. \[Developer-only\] Learn Node.js/Java for front-end application communication and Go for back-end that deals with the blockchain (chaincode)
1. Have a CA (Certificate Authority).
1. Check the project document.
1. Learn how to code for dummies and the Hyperledger Fabric's codes

Hyperledger Fabric overall:-
front-end SDK (Node.js or Java) \<\-\> back-end chaincode/smart contract (Go) \<\-\> blockchain/ledger.

Hyperledger Fabric idea for developers:-
- Lrn2code for SDK (front-end) or chaincode (Go-only for now, back-end). Test in dummy Docker mode.

Hyperledger Fabric for network operator (aka system admins):-
- Pray that the chaincode and blockchain implemented is alive and running in real-time on the network.

Tutorial notes:-
- dev: https://hyperledger-fabric.readthedocs.io/en/latest/write_first_app.html (app) and https://hyperledger-fabric.readthedocs.io/en/latest/chaincode4ade.html (chaincode dev)
- NO: https://hyperledger-fabric.readthedocs.io/en/latest/build_network.html (network) and https://hyperledger-fabric.readthedocs.io/en/latest/chaincode4noah.html (chaincode implement)

# Preparation for Hyperledger Fabric

Tested for uBuntu 16.04, accurate as of 11/10/2017.

Windows OS have some specific modifications to be done. A bit less for macOS.

Note: Very large (about 3-4 GB or so space will be needed just for the preparation) size and may take up to a day depending on connection speed (about 20 hours for my side due to horrible library connection speed).

## Installation

### Prerequistics

Reference: https://hyperledger-fabric.readthedocs.io/en/latest/prereqs.html

Whenever possible, refer to the docs rather than copying the codes here. Use these with a grain of salt.

#### Update everything first.

```bash
sudo apt-get update
```

#### git-scm

Not required to do but might as well since we are in GitHub that rely on git.

```
sudo apt-get install git
git --version
```

git one-time configuration (replace `{name}` and `{email}` with your own details)

```
git config --global user.name "{name}"
$ git config --global user.email "{email}"
```

#### cURL

```
sudo apt-get install     apt-transport-https     ca-certificates     curl     software-properties-common
```

#### Docker (repository style, Intel)

```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"
sudo apt-get install docker-ce
sudo docker run hello-world
sudo docker info
```

##### Docker Compose
```
sudo apt install docker-compose
```

#### Go

Installation note: https://golang.org/doc/install

Download binary first, then:-

```
tar -C /usr/local -xzf {archive}
export GOPATH=/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin
```

#### Node.js (manual)

```
sudo apt-get install nodejs.
```

#### Python 2

```
sudo apt-get install python
python --version
```

#### npm

```
sudo apt-get install npm
```

### Hyperledger Fabric

The binary and the SDK must be in the development folder environment.


#### Hyperledger Fabric code samples

Can be safely ignored if not using.

```
git clone https://github.com/hyperledger/fabric-samples.git
cd fabric-samples
```

#### Hyperledger Fabric binary (Important)

Make a development folder. Enter this development folder. Do below.

There is no real one-click installer for Hyperledger Fabric yet.

It must be done manually but there is a scipt below that can just collect everything needed and place it in the `bin` folder and modify the Docker directly (please make sure the current account is in `docker` group to prevent errors because no `sudo` rights)

```
curl -sSL https://goo.gl/Q3YRTi | bash
```

#### Hyperledger Fabric Software Development Kits (SDK)

Pick at least one for front-end application developement.

The back-end code that communicate with the blockchain (called chaincode in this context) must be coded in Go which comes with the binary the necessary codes.

##### Node.js

TODO (I have no idea)

Reference: https://github.com/hyperledger/fabric-sdk-node

Only do this on the project root when it has `.js` files

```
npm install
```

##### using Java

\#no 

##### No JavaScript and Java, please.

Too bad. The Python SDK is still in developement by time of writing. Deal with it.

### Et Cetera

#### Clean-up

```
sudo apt autoremove
```

#### Got a problem? Use this

```
sudo apt-get -f install
```
