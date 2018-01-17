# org.bit.beems

## Description

Blockchain-based Enterprise Entity Management System. Using blockchain technologies in asset management context. Project with MIMOS.

## Usage

The blockchain is intended to be used only as a storage point for digital signatures used for comparison between the MySQL database of the enterprise system by a REST API server.

Everything here assume you are doing it in `terminal`.

```bash
# chmod
chmod u+x createFabricNetwork.sh
chmod u+x startApp.sh
chmod u+x stopApp.sh
chmod u+x createApp.sh
chmod u+x updateApp.sh
chmod u+x uninstall.sh

# Destroy and create the fabric-network from scratch and install the app specifically for one fabric-network.
./createFabricNetwork.sh

# Start the app/fabric-network with REST API. One channel, one peer.
./startApp.sh

# Close the app/fabric-network
./stopApp.sh

# Et Cetera stuff
# Create the app
./createApp.sh

# Update the app in the fabric-network
./updateApp.sh

# Uninstall the app and the fabric-network
./uninstall.sh
```

### ELI5

```bash
# chmod
chmod u+x createFabricNetwork.sh
chmod u+x startApp.sh
chmod u+x stopApp.sh
chmod u+x createApp.sh
chmod u+x updateApp.sh
chmod u+x uninstall.sh

# For first time or when all else fails (all information will be lost; Hard install).
./createFabricNetwork.sh

# Next time onwards.
./startApp.sh

# Stop
./stopApp.sh

# Application updated? (for developers only)
./updateApp.sh

# Uninstall
./uninstall.sh
```

## Available commands/queries

(to be added...)
