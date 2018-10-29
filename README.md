# Continuous Integration Server

Create and provision a Continuous Integration server on DigitalOcean using Docker, Terraform, Ansible and Jenkins.

## Prerequisites

You'll need the following things before you get started:

### Docker

To install Docker, follow the installation guide: [https://docs.docker.com/install/](https://docs.docker.com/install/)

### DigitalOcean account

[Sign up](https://m.do.co/c/344de7bea76b) for a DigitalOcean account

### DigitalOcean Personal Access Token

Once you have a DigitalOcean account you can create a Personal Access Token by following this guide in their API docs: https://www.digitalocean.com/docs/api/create-personal-access-token/

## Getting Started

1. To start, run the following commands to get set up:

```sh
git clone git@github.com:samwrigley/continuous-integration.git
cd continuous-integration
```

2. Build the `ci` Docker image from the `Dockerfile` by running the following command from the root the project. Make sure to replace `<ssh-email>` with your own email.

```sh
docker build \
    --build-arg SSH_EMAIL=<ssh-email> \
    --tag ci .
```

3. Create a container from the Docker image using the follow command, again from the root of the project. Make sure to replace `<digitalocean-token>` with your DigitalOcean token.

```sh
docker run -it \
    --name ci \
    --restart=unless-stopped \
    --env DIGITALOCEAN_TOKEN=<digitalocean-token> \
    ci
```

## Usage

To create and provision your Continuous Integration server on DigitalOcean, simply run the `create-server.sh` and `provision-server.sh` scripts inside the `ci` container:

```sh
docker exec -it ci /bin/sh \
    /etc/terraform/create-server.sh \
    /etc/ansible/provision-server.sh
```

Once the script has finished running, your Continuous Integration server is up and running at the IP address listed at the end of the `create-server.sh` script output 🚀:

```sh
ip = xxx.xxx.xxx.xxx
```

Please note that both the `create-server.sh` and `provision-server.sh` scripts only need to be run once, although no harm will come from running them multiple times. If you wish to run the scripts seperately, ensure `create-server.sh` is run first and finishes successfully before running `provision-server.sh`, otherwise there will be no server to provision.
