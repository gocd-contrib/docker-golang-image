FROM golang:1.12.3-alpine
MAINTAINER GoCD Team <go-cd-dev@googlegroups.com>

RUN apk add --no-cache \
  tini \
  git \
  gcc \
  musl-dev \
  bash \
  zip \
  curl \
  nss \
  subversion \
  openjdk8-jre-base

ENTRYPOINT ["/sbin/tini", "--"]

# Add a user to run the go agent
RUN adduser go go -h /go -S -D

# ensure that the container logs on stdout
ADD log4j.properties /go/log4j.properties
ADD log4j.properties /go/go-agent-log4j.properties

ADD go-agent /go/go-agent
RUN chmod 755 /go/go-agent

# Run the bootstrapper as the `go` user
USER go
CMD ["/go/go-agent"]
