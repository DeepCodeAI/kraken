FROM docker/compose:1.25.0-alpine as os-stage

RUN apk add --no-cache \
  --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
  --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
  bash

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

CMD source ./start.sh

COPY . .
