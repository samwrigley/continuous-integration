#!/bin/bash

# Move to Terraform directory
cd /etc/terraform

# Run Terraform
terraform apply \
    -var "digitalocean_token=${DIGITALOCEAN_TOKEN}" \
    -var "public_key=/.ssh/id_rsa.pub" \
    -var "private_key=/.ssh/id_rsa" \

# Assign droplet IP address
export IP=$(terraform output ip)
