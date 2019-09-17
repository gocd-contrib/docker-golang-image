# docker-golang-image
A docker image containing a Golang environment for builds

## Includes everything needed to build a basic golang project

- golang 1.13.0 (based on the official golang debian buster image)
- git
- gcc
- bash

## And some some extra utils that are useful:

- curl
- zip
- curl
- ssh
- subversion (some builds need this)

## Building the image locally

```
docker build . -t gocddev/golang-build:2.0.0 -f Dockerfile
```

## Running

```
# starts bash session, `-v` mounts a host path to container mount point
docker run -it -v /host/path:/path/to/mount/point gocddev/golang-build:2.0.0 /bin/bash
```
