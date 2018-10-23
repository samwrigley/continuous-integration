#!/bin/bash

# Move to Ansible directory
cd /etc/ansible

# Set up Ansible hosts
printf "[ci]\n${IP}" > hosts

# Run Ansible
ansible-playbook \
    --private-key=/.ssh/id_rsa \
    docker.yml
