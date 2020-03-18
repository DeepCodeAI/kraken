FROM docker/compose:1.25.0-alpine as os-stage

RUN apk add --no-cache \
  --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
  --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
  bash

ENV USR_DIR /usr/src/app

RUN mkdir -p ${USR_DIR}
WORKDIR ${USR_DIR}
ENTRYPOINT [] 
CMD ["/start.sh"]

ARG VERSION=latest
ENV VERSION ${VERSION}

ARG EXPIRATION_DATE
ENV EXPIRATION_DATE ${EXPIRATION_DATE}

# Validate expiration date
RUN date "+%Y-%m-%d" -d ${EXPIRATION_DATE} 2>&1 || \
  { echo "Please specify a valid date, ${EXPIRATION_DATE} is invalid"; exit 1; }

ARG NODE_TLS_REJECT_UNAUTHORIZED=1
ENV NODE_TLS_REJECT_UNAUTHORIZED ${NODE_TLS_REJECT_UNAUTHORIZED}

COPY start.sh /start.sh
COPY docker-compose* ./
COPY registry ./registry
