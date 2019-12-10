#!/usr/bin/env bash

: "${PRODUCT:?Need to set PRODUCT non-empty}"
: "${HOST_URL:?Need to set HOST_URL non-empty}"

if [ -n ${EXPIRATION_DATE} ]; then
  expire=$(date -d "${EXPIRATION_DATE}" +%Y%m%d)
  now=$(date +%Y%m%d)
  if [ $now -ge $expire ]; then
    echo "Your container is expired. Please request a newer version on deepcode.ai";
    exit 1;
  fi
fi

docker load -i $USR_DIR/registry/dc_suggest.tar.gz
docker load -i $USR_DIR/registry/dc_bundle.tar.gz
docker load -i $USR_DIR/registry/dc_api.tar.gz
docker load -i $USR_DIR/registry/dc_website.tar.gz

docker-compose --file $USR_DIR/docker-compose.yml --project-directory $PWD --log-level ERROR  up -V
