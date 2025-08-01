FROM gocd/gocd-agent-wolfi:v25.3.0
ARG GOVERSION=1.24

USER root

ENV GOPATH=/home/go
ENV PATH="$GOPATH/bin:$PATH"

RUN \
  apk --no-cache upgrade && \
  # need the following for building golang projects
  # which might need cgo, netgo, etc.
  apk --no-cache add \
    ca-certificates \
    go~=${GOVERSION} \
    openssl \
    zip && \
  mkdir -p "$GOPATH/src" "$GOPATH/bin" && \
  chown -R go:root $GOPATH && \
  chmod -R a+rx $GOPATH/bin && \
  # set for login shells too
  printf "export PATH=\"\$GOPATH/bin:\$PATH\"\n" > /etc/profile.d/golang.sh

USER go

WORKDIR /
