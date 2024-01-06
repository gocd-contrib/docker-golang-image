# See https://hub.docker.com/_/golang/tags
FROM golang:1.21-alpine3.18 as golang

FROM gocd/gocd-agent-alpine-3.18:v23.5.0

USER root

COPY --from=golang /usr/local/go /usr/local/go

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
