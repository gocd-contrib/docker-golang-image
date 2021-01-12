FROM golang:1.14-alpine3.11 as golang

FROM gocd/gocd-agent-alpine-3.11:v21.1.0

MAINTAINER GoCD Team <go-cd-dev@googlegroups.com>

LABEL gocd.version="20.6.0" \
  description="GoCD agent with golang 1.14.6 based on alpine version 3.12" \
  maintainer="GoCD Team <go-cd-dev@googlegroups.com>" \
  url="https://www.gocd.org" \
  gocd.full.version="20.6.0-12005" \
  gocd.git.sha="12860aac6351e2a353728c7d7913f34d741c63e0"

USER root

COPY --from=golang /etc/nsswitch.conf /etc/nsswitch.conf
COPY --from=golang /usr/local/go /usr/local/go

ENV GOLANG_VERSION 1.14.6
ENV GOPATH /home/go
ENV PATH "$GOPATH/bin:/usr/local/go/bin:$PATH"

RUN \
  apk --no-cache upgrade && \
  # need the following for building golang projects
  # which might need cgo, netgo, etc.
  apk add --no-cache \
    ca-certificates \
    gcc \
    musl-dev \
    openssl \
    zip && \
  mkdir -p "$GOPATH/src" "$GOPATH/bin" && \
  chown -R go:root /usr/local/go $GOPATH && \
  chmod -R a+rx /usr/local/go/bin $GOPATH/bin && \
  # set for login shells too
  printf "export PATH=\"\$GOPATH/bin:/usr/local/go/bin:\$PATH\"\n" > /etc/profile.d/golang.sh

USER go

WORKDIR /
