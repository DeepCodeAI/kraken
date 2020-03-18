#!/usr/bin/env bash

# check that expiration date is set
if [ -z ${EXPIRATION_DATE+x} ]; then
  echo 'Please set date in format "%Y-%m-%d" to environment EXPIRATION_DATE, like: ';
  echo 'export EXPIRATION_DATE="2020-03-01"'
  return 1;
fi

echo "Saving suggest image"
docker pull deepbuild:5000/dc_suggest:dev
docker tag deepbuild:5000/dc_suggest:dev dc_suggest:latest
docker save dc_suggest:latest | gzip > registry/dc_suggest.tar.gz

echo "Saving redis image"
docker pull redis:5.0.7-alpine
docker tag redis:5.0.7-alpine dc_redis:latest
docker save dc_redis:latest | gzip > registry/dc_redis.tar.gz

echo "Saving bundle image"
docker pull deepbuild:5000/dc_bundle:dev
docker tag deepbuild:5000/dc_bundle:dev dc_bundle:latest
docker save dc_bundle:latest | gzip > registry/dc_bundle.tar.gz

echo "Saving mysql image"
docker pull mysql:5.7
docker tag mysql:5.7 dc_mysql:latest
docker save dc_mysql:latest | gzip > registry/dc_mysql.tar.gz

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
docker build --build-arg VERSION --build-arg EXPIRATION_DATE -t deepcode:$VERSION .
if [ $? -ne 0 ]; then
  echo "Docker build failed. exiting";
  return 1;
fi

docker tag deepcode:$VERSION deepcode:latest

echo "Saving docker image"
docker save deepcode:latest | gzip > deepcode_${VERSION:0:5}_$EXPIRATION_DATE.tar.gz

echo "Pushing docker image to registry"
docker tag deepcode:$VERSION deepbuild:5000/deepcode:$VERSION
docker tag deepcode:latest deepbuild:5000/deepcode:latest
docker push deepbuild:5000/deepcode
