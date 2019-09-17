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

Start the container with this:

```
docker run -d -e GO_SERVER_URL=... gocddev/golang-build:2.0.0
```

## Auto-registering the agents

```
docker run -d \
        -e AGENT_AUTO_REGISTER_KEY=... \
        -e AGENT_AUTO_REGISTER_RESOURCES=... \
        -e AGENT_AUTO_REGISTER_ENVIRONMENTS=... \
        -e AGENT_AUTO_REGISTER_HOSTNAME=... \
        gocd/gocd-agent-debian-9:v19.8.0
```

If the `AGENT_AUTO_REGISTER_*` variables are provided (we recommend that you do), then the agent will be automatically approved by the server. See the [auto registration docs](https://docs.gocd.org/current/advanced_usage/agent_auto_register.html) on the GoCD website.

## Notable difference from other gocddev images

The `AGENT_WORK_DIR` is set to `/gocd` so as to not conflict with golang's `GOPATH`.
