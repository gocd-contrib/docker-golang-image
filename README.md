# docker-golang-image
A docker image containing a Golang environment for builds

## Includes everything needed to build a basic golang project

- golang 1.12.0
- git
- gcc
- bash

## And some some extra utils that are useful:

- curl
- zip

## Building the image locally

```
docker build . -t gocddev/golang-build:1.12.0-alpine -f Dockerfile
```
