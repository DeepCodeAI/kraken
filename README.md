# kraken
Self-managed container for GitLab

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

# Run local instance of Gitlab
  ```
  docker-compose -f docker-compose.gitlab.yml up -d 
  ```

Once it's running, setup an Application

# Configuration
Copy example configuration and fill it
  ```
  cp ./example.gl.evn ./gl.env
  ```

Copy application ID and secret from your running Gitlab instance

# Run container for Gitlab:

  ```
  docker run --rm -it -v '/var/run/docker.sock:/var/run/docker.sock' --env HOST_IP --env-file ./gl.env kraken
  ```
