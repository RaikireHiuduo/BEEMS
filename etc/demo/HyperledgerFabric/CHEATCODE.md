# CHEATCODE

aka stuff that may or may not brick the PC.

## Special keyword

If you have no idea what it is, append `--help` at the end for any command you do not comprehend.

For example: `docker ps --help` or `docker images --help` .

## Docker

### Important commands

- Display all the currently running docker processes: `docker ps -a`
- Display all the images in local docker repository: `docker images -a`

### Hard Reset

**PURGE EVERYTHING INSIDE DOCKER** command, aka reset.

```bash
docker rm -f $(docker ps -aq)
docker rmi -f $(docker images -q)
```

- The first line **remove all running image processes** in Docker environment.
- The second line is probably the most dangerous; it will **remove all images** in the **local Docker repository**. If you understand what you are doing is effectively a hard reset, then please go ahead. Otherwise, just do the first line instead.

## Hyperledger Fabric

Do this on the root directory of the program folder. A new folder called `bin` (if not created) will be created and all the necessary codes will be stored there.

```bash
curl -sSL https://goo.gl/Q3YRTi | bash
```

Notes:-

- Consider using the command on an unlimited quota connection.
  - It is depending on the size of the updates.
- You may want to run it daily to update the Hyperledger Fabric to the latest version.
  - You may also want to run it at least twice in case of bad connection breaking one part of the download.
