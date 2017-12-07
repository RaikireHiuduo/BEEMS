# Hyperledger Fabric demo README

## tl;dr

[Do check out the CHEATCODE.md for cool stuffs to keep notes about after everything is done](../CHEATCODE.md)

- Introduction: https://hyperledger-fabric.readthedocs.io/en/latest/blockchain.html
- Model glossary and benefits: https://hyperledger-fabric.readthedocs.io/en/latest/fabric_model.html

- Difficulty: Sounds easy in theory; for implementation, an architect's precision level of design (as in, down to all the tools and resources to use for one component) with zero room for errors is expected. It basically assumed you know _something_ about how the whole thing works along with the tools used and there is no comprehensive debugging help so yes, some implementation-specific reading ~~may be~~ required.
- Size required: Have a dedicated server machine for this. It took up about ~10GB or more if not mistaken. Did not bothered to do a precise count including all the prerequisites and the binaries to run the Hyperledger Fabric.

Simplified walkthrough:-

1. Install a lot of prerequisites components just to get Hyperledger Fabric running. Get the Hyperledger Fabric binaries images into the docker manually by script because there is no one-click installer.
1. Pick either as a developer (dev; one that build the application and/or chaincode specifically) or as a network operator (NO; one that implement the developer's chaincode to run in the network).
   1. \[dev\] Learn Node.js/Java for front-end application communication and Go for back-end code that deals with the blockchain (chaincode)
   1. \[NO\] Prepare a startup bash/shell script to deploy the chaincode to run.
1. Have a CA (Certificate Authority) or use the one provided (`Hyperledger Fabric CA`).
1. Check the project document.
1. Learn how to code JavaScript/Java/Go for dummies and the Hyperledger Fabric's codes.

Hyperledger Fabric overall:-

- front-end SDK (Node.js or Java) \<\-\> back-end chaincode/smart contract (Go) \<\-\> blockchain/ledger.

Hyperledger Fabric idea for developers:-

- Learn to code for SDK (front-end) or chaincode/smart contract (Go-only for now, back-end). Test in Docker mode.

Hyperledger Fabric for network operator (aka system admins or deploying it live):-

- Pray that the chaincode and blockchain implemented on a peer is alive and running in real-time on the network.

Tutorial notes:-

- dev: https://hyperledger-fabric.readthedocs.io/en/latest/write_first_app.html (app) and https://hyperledger-fabric.readthedocs.io/en/latest/chaincode4ade.html (chaincode dev)
- NO or deployment: https://hyperledger-fabric.readthedocs.io/en/latest/build_network.html (network) and https://hyperledger-fabric.readthedocs.io/en/latest/chaincode4noah.html (chaincode implement)

## Preparation for Hyperledger Fabric

Tested for uBuntu 16.04, accurate as of 18/10/2017. All explanation assumed the reader is in the uBuntu (Linux) environment. Improvise accordingly to the official installation documentation if using different architecture like Arch.

Windows OS have some specific modifications to be done. A bit less for macOS. Easiest on Linux OS. As usual, please refer to the official installation documentation for more information.

It is recommended to try to dedicate and complete this in one day on an undisturbed, quotaless connection line.

## Installation

### Prerequisites

Reference: https://hyperledger-fabric.readthedocs.io/en/latest/prereqs.html

Whenever possible, refer to the docs rather than copying the codes here. Also, refer to the official website documentation on how to download and configure it properly. Use these with a grain of salt.

#### Test code (Linux only)

Do this on the terminal (`Ctrl` + `Alt` + `T`) once all the prerequisites are installed. If any of the commands is not working, check again the official installation guide.

```bash
git --version
curl --version
docker version
docker-compose version
go version
nodejs --version
python --version
npm --version
docker images
```

What it does is to check the versions in this order: git-scm, curl, docker, docker-compose, go, nodejs, python, npm, and lastly the images of Hyperledger Fabric binaries (if you went ahead and downloaded it; should be empty otherwise) in the local Docker repository.

Please ensure that the version for NodeJS (6.9 - not 7.x) and Go (1.9) are fulfilled correctly to the official criteria to ensure no unexpected errors stemming from unsupported tools installation issues.

There are `nvm` and `gvm` (for version manager for NodeJS and Go respectively) that may be of interest if all else fails. 

#### Update everything first.

```bash
sudo apt-get update
```

#### git-scm

Not required to do but might as well since we are in GitHub that rely on `git`. Required if wanting to test for the sample code provided.

```bash
sudo apt-get install git
git --version
```

git one-time configuration (replace `{name}` and `{email}` with a GitHub's account details)

```bash
git config --global user.name "{name}"
git config --global user.email "{email}"
```

#### cURL

```bash
sudo apt-get install     apt-transport-https     ca-certificates     curl     software-properties-common
```

#### Docker CE (repository style, Intel)

Reference (Docker Community Edition): https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-docker-ce

Any variation of Docker is fine. Only Docker CE is free.

```bash
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

```bash
sudo apt install docker-compose
docker-compose version
```

#### Go

Installation note: https://golang.org/doc/install

Download binary file first, then move to the same directory of the binary file:-

```bash
tar -C /usr/local -xzf {archive}
```

Then, do this:-

```bash
sudo nano /etc/environment
```

Append `:/usr/local/go/bin` at the end of the line \[use the `rightArrowKey` (`->`)\] before the `"`.

Logout and login again.

Test with `go version`

#### Node.js (manual)

Official reference for Linux side: https://nodejs.org/en/download/package-manager/

```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
nodejs --version
```

Note: If the version said: `v4.2.6`, then try again with reference to: https://askubuntu.com/questions/786272/why-does-installing-node-6-x-on-ubuntu-16-04-actually-install-node-4-2-6

It must be more than or equal to 6.9 and less than 7.x as per https://stackoverflow.com/a/45235205 .

The team is using: `v6.11.4` .

#### Python 2

```bash
sudo apt-get install python
python --version
```

#### npm

```bash
sudo apt-get install npm
npm --version
```

### Hyperledger Fabric

This is the part where the documentation becomes confusing. Take these with extreme caution. In fact, it may be difficult to even _know_ it is done right since everything is everywhere and with assumed understanding that the user knows how to find and solve manually.

The binary and the SDK must be in the development folder environment.

#### Hyperledger Fabric code samples

Can be safely ignored if not using.

```bash
git clone https://github.com/hyperledger/fabric-samples.git
```

#### Hyperledger Fabric binary (Important)

There is no real one-click installer for Hyperledger Fabric yet.

It must be done manually but there is a scipt below that can just collect everything needed and place it into a `bin` folder (will be created if not found) and modify the Docker directly to add in the Hyperledger Fabric binary images files (please make sure the current account is in `docker` group to prevent errors because no `sudo` rights)

```bash
curl -sSL https://goo.gl/Q3YRTi | bash
```

Note: It is suggested to run it at least twice in case of bad connection breaking one part of the download. Unlike the prerequisites, these files are huge so consider running the command on an unlimited connection.

Binaries and update shell scripts for the docker images of Hyperledger Fabrics are located in the `bin` folder and the images saved in local Docker repository with:-

```bash
docker images -a
```

#### Hyperledger Fabric Software Development Kits (SDK)

Pick at least one for front-end application developement.

The back-end code that communicate with the blockchain (called chaincode in this context) must be coded in Go which comes with the binary of the necessary codes.

##### Node.js

Reference: https://github.com/hyperledger/fabric-sdk-node

Only do this when there is `package.json` and `.js` files to run.

```bash
npm install
```

You will have a `node_modules` folder. Whenever possible, always delete this before running `npm install` for the sake of sanity. 

`WARN` notice can _usually_ be ignored safely unless it was developed manually in which it is the responsibility of the developer to try to fix it. 

##### using Java

\#noIdea

##### No JavaScript and Java, please.

Too bad. The Python SDK is still in developement by time of writing (06/12/2017). Deal with it for now.

### Et Cetera

#### Clean-up

```bash
sudo apt autoremove
```

#### Got a problem? Use this and read the terminal question and answer it

```bash
sudo apt-get -f install
```
