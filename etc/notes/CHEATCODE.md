# CHEATCODE

aka stuff that may or may not brick the PC.

Note: As usual, the page assumes the reader is in UNIX environment.

## Special keyword

If you have no idea what it is, append `--help` at the end for any command you do not comprehend.

For example: `docker ps --help` or `docker images --help` .

## Docker

### Important commands

- Display all the currently running docker processes: `docker ps -a`
- Display all the images in local docker repository: `docker images -a`
- Clean-up the garbage: `docker system prune`

### Hard Reset

**PURGE EVERYTHING INSIDE DOCKER** command, aka factory hard reset.

```bash
docker rm -f $(docker ps -aq)
docker rmi -f $(docker images -q)
```

- The first line **remove all running image processes** in Docker environment.
- The second line is probably the most dangerous; it will **remove all images** in the **local Docker repository**. Unless the user has abandon all hopes of Docker images recovery, just do the first line and try to repull the image again instead should be fine in most cases.

## Hyperledger Fabric

Do this on the root directory of the program folder. A new folder called `bin` (if not created) will be created and all the necessary codes will be stored there.

```bash
curl -sSL https://goo.gl/Q3YRTi | bash
```

Notes:-

- Consider using the command on an unlimited quota connection, especially for fresh install.
  - It is depending on the size of the updates.
- It is suggested to run it daily to update the Hyperledger Fabric to the latest version.
  - It is also suggested to run it at least twice in case of bad connection breaking one part of the download. If there is no problem, it should be a quick check without any noticable downloading actions and done.
  
## Development

### Node.js

Reference: https://github.com/hyperledger/fabric-sdk-node

Only do this when there is `package.json` and `.js` files to run.

```bash
npm install
```

You will have a `node_modules` folder. Whenever possible, always delete this before running `npm install` for the sake of sanity. 

`WARN` notice can _usually_ be ignored safely unless it was developed manually in which it is the responsibility of the developer to try to fix it. 
