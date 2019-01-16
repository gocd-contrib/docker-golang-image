FROM golang:1.11.4-alpine
MAINTAINER GoCD Team <go-cd-dev@googlegroups.com>

RUN apk add --no-cache bash git gcc musl-dev

CMD ["/bin/bash"]
