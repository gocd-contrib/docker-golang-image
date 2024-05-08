# docker-golang-image
A docker image containing a Golang environment for builds

## Includes everything needed to build a basic golang project

- golang (based on the official golang alpine image)
- git
- gcc
- bash

## And some some extra utils that are useful:

- curl
- zip
- ssh
- subversion (some builds need this)

## Building the image locally

```shell
docker build . --pull --platform linux/amd64 -t gocddev/golang-build:SNAPSHOT -f Dockerfile
```

## Running

Start the container with this:

```
docker run -d -e GO_SERVER_URL=... gocddev/golang-build:SNAPSHOT
```

## Auto-registering the agents

```
docker run -d \
  -e AGENT_AUTO_REGISTER_KEY=... \
  -e AGENT_AUTO_REGISTER_RESOURCES=... \
  -e AGENT_AUTO_REGISTER_ENVIRONMENTS=... \
  -e AGENT_AUTO_REGISTER_HOSTNAME=... \
  gocddev/golang-build:4.0.0
```

If the `AGENT_AUTO_REGISTER_*` variables are provided (we recommend that you do), then the agent will be automatically approved by the server. See the [auto registration docs](https://docs.gocd.org/current/advanced_usage/agent_auto_register.html) on the GoCD website.

## Development

Pushing the built image to [Docker Hub](https://hub.docker.com/r/gocddev/golang-build) for use in [build.gocd.org](https://build.gocd.org/) builds under the `ecs-golang-build` elastic agent profile:
* Configure Docker with with `godemo` push token/credentials for the [gocddev](https://hub.docker.com/u/gocddev) organisation
* Run
  ```shell
  VERSION=4.0.11
  docker tag gocddev/golang-build:SNAPSHOT gocddev/golang-build:${VERSION}
  docker --config ../.docker-godemo push gocddev/golang-build:${VERSION}
  ```