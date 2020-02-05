# Self-managed container for Deepcode

## Build process

The process is super simple. Just run:
  ```
  source ./build.sh
  ```

It will create a new tarball. Just upload it to https://drive.google.com/drive/u/0/folders/1jjFQA6aGNuOeEhg0JaUDC7mKbDWa5J-X

## Test Bitbucket server integration

Complete guide is [online](https://www.deepcode.ai/docs/Self-Managed%20Integrations%2FBitbucket%20Server)

### Start Bitbucket locally:
  ```
  docker-compose -f <product-repo-path>/dc_op/bitbucket/docker-compose.yml up -d --remove-orphans  || true
  ```

### Start Deepcode container locally:
  ```
  docker run --rm -it \
    -v '/var/run/docker.sock:/var/run/docker.sock' \
    -v $PWD:$PWD \
    -w $PWD \
    --env HOST_IP \
    --env "BIT_BUCKET_SERVER_OAUTH_PRIVATE_KEY=$(cat <product-repo-path>/dc_op/bitbucket/deepcode.pem)" \
    --env-file <product-repo-path>/dc_op/bitbucket/local.env \
    --name deepcode \
    deepcode
  ```
  
## Test Gitlab integration:

### Start Gitlab locally:
  ```
  docker-compose -f <product-repo-path>/dc_op/gitlab/docker-compose.yml up -d --remove-orphans || true
  ```

### Start Deepcode container locally
  ```
  docker run --rm -it \
    -v '/var/run/docker.sock:/var/run/docker.sock' \
    -v $PWD:$PWD \
    -w $PWD \
    --env HOST_IP \
    --env-file <product-repo-path>/dc_op/gitlab/local.env \
    --name deepcode \
    deepcode
  ```
