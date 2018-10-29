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

# Copy all configuration files into container
COPY ./terraform/ /etc/terraform/
COPY ./ansible/ /etc/ansible/

# Grant permissions
RUN chmod +x /etc/terraform/create-server.sh \
    /etc/ansible/provision-server.sh 

# Initialise Terraform
WORKDIR /etc/terraform/
RUN terraform init

# Stop Ansible from checking authenticity of host SSH key
ENV ANSIBLE_HOST_KEY_CHECKING=False

WORKDIR /
