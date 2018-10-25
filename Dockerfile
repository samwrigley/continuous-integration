FROM alpine:edge

# Variables
ARG SSH_EMAIL=''

# Install dependencies
RUN apk add --no-cache \
    openssh-client \
    terraform \
    ansible \
    ca-certificates

# Generate SSH key
RUN mkdir /.ssh && \
    ssh-keygen -t rsa -b 4096 -C $SSH_EMAIL -f /.ssh/id_rsa -N ''

COPY ./terraform/ /etc/terraform/
COPY ./ansible/ /etc/ansible/

# Initialise Terraform
WORKDIR /etc/terraform/
RUN terraform init

# Stop Ansible from checking authenticity of host SSH key
ENV ANSIBLE_HOST_KEY_CHECKING=False

WORKDIR /
