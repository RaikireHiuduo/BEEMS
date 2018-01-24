# org.bit.beems

## Description

Blockchain-based Enterprise Entity Management System. Using blockchain technologies in asset management context. Project with MIMOS.

## Usage

The blockchain is intended to be used only as a storage point for digital signatures used for comparison between the MySQL database of the enterprise system by a REST API server.

Everything here assume you are doing it in `terminal`.

```bash
# chmod
chmod u+x install.sh
chmod u+x startApp.sh
chmod u+x stopApp.sh
chmod u+x createApp.sh
chmod u+x updateApp.sh
chmod u+x uninstall.sh

# Install (dependent on createApp.sh). REST API server will be deployed if successful.
./install.sh

# Start the app/fabric-network with REST API. One channel, one peer.
./startApp.sh

# Close the app/fabric-network
./stopApp.sh

# Et Cetera stuff
# Create the app
./createApp.sh

# Update the app in the fabric-network when it is up
./updateApp.sh

# Uninstall the app and the fabric-network
./uninstall.sh
```

### ELI5

```bash
# chmod
chmod u+x install.sh
chmod u+x startApp.sh
chmod u+x stopApp.sh
chmod u+x createApp.sh
chmod u+x updateApp.sh
chmod u+x uninstall.sh

# For first time or when all else fails (all information will be lost; Hard install).
./install.sh

# Next time onwards.
./startApp.sh

# Stop service
./stopApp.sh

# Uninstall (Hard purge)
./uninstall.sh
```

## Available commands/queries

Only `CR--` supported. Please use the REST API located at `localhost:3000`.

- Create
  - Direct `POST` to `DigitalSignature` asset registry.
  - WIP code: `addDigitalSignature` (Broken by time of writing)
- Read
  - Query
    - `selectDigitalSignature`: Returns all.
    - `selectDigitalSignatureByID`: Returns one.
