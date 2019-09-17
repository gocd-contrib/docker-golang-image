# docker-golang-image
A docker image containing a Golang environment for builds

## Includes everything needed to build a basic golang project

- golang 1.12.9
- git
- gcc
- musl-dev (lib c headers, etc.)
- bash

## And some some extra utils that are useful:

- curl
- zip

## Building the image locally

```
docker build . -t gocddev/golang-build:1.13.0-buster -f Dockerfile
```

## Running

```
# starts bash session, `-v` mounts a host path to container mount point
docker run -it -v /host/path:/path/to/mount/point gocddev/golang-build:1.13.0-buster /bin/bash
```
