FROM golang:1.14-alpine3.11 as golang

FROM gocd/gocd-agent-alpine-3.16:v22.2.0

MAINTAINER GoCD Team <go-cd-dev@googlegroups.com>

LABEL gocd.version="22.2.0" \
  description="GoCD agent with golang 1.19.1 based on alpine version 3.16" \
  maintainer="GoCD Team <go-cd-dev@googlegroups.com>" \
  url="https://www.gocd.org" \
  gocd.full.version="22.2.0-14697" \
  gocd.git.sha="4bdda4e0d769e66da651926c7066979740bd7ae7"

USER root

COPY --from=golang:1.19.1-alpine3.16 /usr/local/go /usr/local/go

ENV GOLANG_VERSION 1.19.1
ENV GOPATH /home/go
ENV PATH "$GOPATH/bin:/usr/local/go/bin:$PATH"

RUN \
  apk --no-cache --force-overwrite upgrade && \
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
