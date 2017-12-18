[HCI]: https://hyperledger.github.io/composer/installing/development-tools.html "Installing and developing with Hyperledger Composer by Hyperledger Composer"

# Hyperledger Composer

**[Always refer to the official documentation of Hyperledger Composer](https://hyperledger.github.io/composer/introduction/introduction.html "Introduction to Hyperledger Composer")**

Read "[Installing and developing with Hyperledger Composer by Hyperledger Composer][HCI]" for installation help.

## Installation notes

- As per the documentation, the playground is optional and can be safely ignored.
- Since the Hyperledger Composer is based on Hyperledger Fabric, the Hyperledger Fabric code will need to be downloaded too.
  - The good news is that the nice folks of the documentation has prepared shell scripts for the installation from scratch to the end, especially for uBuntu users.

### Installation code used

**WARNING:** Information is accurate to documentation by time of writing. Please be reminded **these commands may not work or inaccurate in the future**. As such, it is highly suggested to read the [official documentation on the proper way to install instead][HCI].

Important notes:-

- Run on `uBuntu 16.04 LTS`.
- `cURL` must be installed. Please install `cURL` first before continuing.

Run on `Terminal`:-

```bash
# Download the prerequistics for Hyperledger Fabric (script for uBuntu).
curl -O https://hyperledger.github.io/composer/prereqs-ubuntu.sh
chmod u+x prereqs-ubuntu.sh
./prereqs-ubuntu.sh

# Logout and then, login. Alternatively, just shutdown and then starting up manually or restart would be fine.

# Download and install the tools for Hyperledger Composer.
npm install -g composer-cli
npm install -g generator-hyperledger-composer
npm install -g composer-rest-server
npm install -g yo

# Get the one-stop composer-fabric toolkits and put it at user's home.
mkdir ~/fabric-tools && cd ~/fabric-tools
curl -O https://raw.githubusercontent.com/hyperledger/composer-tools/master/packages/fabric-dev-servers/fabric-dev-servers.zip
unzip fabric-dev-servers.zip

# Download the Hyperledger Fabric (WARNING: Huge filesize). Consider reruning the script again if having a bad connection.
cd ~/fabric-tools
./downloadFabric.sh

# Start the Hyperledger Fabric network and create an entry-point as admin (one-time only)
cd ~/fabric-tools
./startFabric.sh
./createPeerAdminCard.sh

# Shutdown the Hyperledger Fabric network.
cd ~/fabric-tools
./stopFabric.sh
```

Note for Composer: Only rerun `./createPeerAdminCard.sh` (create an admin card) if you did `./teardownFabric.sh` (destroy the whole fabric network and the admin card). Only run `./teardownFabric.sh` after `./stopFabric.sh`.

## Expected results

- `fabric-tools` at `~/` (user's home or `$HOME`) path. Important and very useful.
- Hyperledger Fabric images in Docker (test with `docker images`).
- Hyperledger Composer in cli is active (test with `composer -v`).
- All the prerequistics tools and extensions as per the documentation for the tools and images above.

## Next steps

- Download [Microsoft's Visual Studio Code (VSCode)](https://code.visualstudio.com/ "Microsoft's Visual Studio Code") and download the `Hyperledger Composer` extension inside VSCode.
