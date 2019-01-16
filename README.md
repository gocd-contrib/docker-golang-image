# docker-golang-image
A docker image containing a Golang environment for builds

## Includes everything needed to build a basic golang project

- golang 1.11.4
- git
- gcc
- bash

## Building the image locally

```
docker build . -t gocddev/golang-build:1.11.4-alpine -f Dockerfile
```
