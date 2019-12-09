#!/usr/bin/env bash

: "${PRODUCT:?Need to set PRODUCT non-empty}"
: "${VUE_APP_OP:?Need to set VUE_APP_OP non-empty}"
: "${HOST_URL:?Need to set HOST_URL non-empty}"

#export $(egrep -v '^#' gl.env | xargs)

docker load -i registry/dc_suggest.tar.gz
docker load -i registry/dc_bundle.tar.gz
docker load -i registry/dc_api.tar.gz
docker load -i registry/dc_website.tar.gz

docker-compose up
