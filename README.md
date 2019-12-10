# Deepcode build/test guide

Self-managed container for Deepcode

To build the new Docker image run:
  ```
  source ./build.sh
  ```

# Set Host IP
On Mac:
  ```
  echo "export HOST_IP=$(ipconfig getifaddr en0)" | tee -a ~/.bashrc
  ```
On Linux:
  ```
  sudo apt-get install net-tools     # for ifconfig
  export HOST_IP=$(ifconfig enp24s0 | fgrep inet | head -1 | awk '{print $2}') | tee -a ~/.bashrc
  ```
Manually copy this dynamic IP address to /etc/hosts using sudo for hostname localdc

# Run local instance of Gitlab together with Deepcode container
  ```
  docker-compose -f docker-compose.gitlab.yml up -d 
  ```

Once it's running, setup an Application following:
https://www.deepcode.ai/docs/Self-Managed%20Integrations%2FGitLab

## Configuration
Copy example configuration and fill it
  ```
  cp ./example.gl.evn ./gl.env
  ```

Copy application ID and secret and personal access token from your running Gitlab instance

## Run container for Gitlab integration:
  ```
  source ./run_local_gl_op.sh
  ```

# Bitbucket server
  ```
  docker-compose -f docker-compose.bitbucket.yml up -d 
  ```

Once it's running, setup an Application following: https://www.deepcode.ai/docs/Self-Managed%20Integrations%2FBitbucket%20Server

## Configuration
Copy example configuration and fill it
  ```
  cp ./example.bb.evn ./bb.env
  ```

Fill all required fields

Export private key into variable:
  ```
  export BIT_BUCKET_SERVER_OAUTH_PRIVATE_KEY=$(cat ./deepcode.pem)
  ```

## Run container for BitBucket Server:
  ```
  source ./run_local_bb_op.sh
  ```
