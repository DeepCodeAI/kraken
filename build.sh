#!/usr/bin/env bash

if [ -z ${EXPIRATION_DATE+x} ]; then
  echo "Please set value to environment EXPIRATION_DATE";
  return;
fi

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

# Version is the last commit's hash
export VERSION=$(git log -1 --pretty=%H)

echo "Packaging altogether"
docker build --build-arg VERSION --build-arg EXPIRATION_DATE -t deepcode .

echo "Saving docker image"
docker save deepcode | gzip > deepcode_${VERSION:0:5}_$EXPIRATION_DATE.tar.gz

echo "Pushing docker image to registry"
docker tag deepcode deepbuild:5000/deepcode:$VERSION
docker tag deepcode deepbuild:5000/deepcode:latest
docker push deepbuild:5000/deepcode
