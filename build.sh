#!/usr/bin/env bash

mkdir -p registry

echo "Saving suggest image"
docker pull deepbuild:5000/dc_suggest:dev
docker tag deepbuild:5000/dc_suggest:dev dc_suggest:latest
docker save dc_suggest:latest | gzip > registry/dc_suggest.tar.gz

echo "Saving bundle image"
docker pull deepbuild:5000/dc_bundle:dev
docker tag deepbuild:5000/dc_bundle:dev dc_bundle:latest
docker save dc_bundle:latest | gzip > registry/dc_bundle.tar.gz

echo "Saving API image"
docker pull deepbuild:5000/dc_api:latest
docker tag deepbuild:5000/dc_api:latest dc_api:latest
docker save dc_api:latest | gzip > registry/dc_api.tar.gz

echo "Saving website image"
docker pull deepbuild:5000/dc_website:latest
docker tag deepbuild:5000/dc_website:latest dc_website:latest
docker save dc_website:latest | gzip > registry/dc_website.tar.gz

echo "Packaging altogether"
docker build -t kraken .

echo "Saving docker image"
docker save kraken | gzip > kraken.tar.gz
