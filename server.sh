#!/bin/sh

echo 'Creating server...'

if [ -z "$DIGITALOCEAN_TOKEN" ]; then
    echo 'Cannot create server as `DIGITALOCEAN_TOKEN` environment variable is not set'
else
    cd /etc/terraform

    terraform apply \
        -auto-approve \
        -var "digitalocean_token=${DIGITALOCEAN_TOKEN}" \
        -var "public_key=/.ssh/id_rsa.pub" \
        -var "private_key=/.ssh/id_rsa"

    IP=$(terraform output ip)

    echo 'Successfully created server'
fi

echo 'Provisioning server...'

if [ -z "$IP" ]; then
    echo 'Cannot provision server as no IP address'
else
    cd /etc/ansible

    printf "[ci]\n${IP}" > hosts

    ansible-playbook \
        --private-key=/.ssh/id_rsa \
        docker.yml
    
    echo 'Successfully provisioned server'
fi
