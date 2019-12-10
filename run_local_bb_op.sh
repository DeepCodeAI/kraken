#!/usr/bin/env bash

docker-compose -f docker-compose.bitbucket.yml up -d --remove-orphans  || true

docker run --rm -it \
    -v '/var/run/docker.sock:/var/run/docker.sock' \
    -v $PWD:$PWD \
    -w $PWD \
    --env HOST_IP --env FRONT_PORT=8080 \
    --env "BIT_BUCKET_SERVER_OAUTH_PRIVATE_KEY=$(cat deepcode.pem)" \
    --env-file ./bb.env \
    --name deepcode \
    deepcode $@
