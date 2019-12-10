FROM docker/compose:1.25.0-alpine as os-stage

RUN apk add --no-cache \
  --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
  --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
  bash

ENV USR_DIR /usr/src/app

RUN mkdir -p ${USR_DIR}
WORKDIR ${USR_DIR}
CMD source ${USR_DIR}/start.sh

ARG VERSION=latest
ENV VERSION ${VERSION}

ARG EXPIRATION_DATE=''
ENV EXPIRATION_DATE ${EXPIRATION_DATE}

COPY start.sh ./
COPY docker-compose* ./
COPY registry ./registry
COPY example* ./

