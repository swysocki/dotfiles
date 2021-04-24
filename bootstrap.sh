#!/usr/bin/env bash

# We have to start somewhere

if [ "$(uname)" == "Darwin" ]; then
    brew install ansible
    echo "The playbook does not yet support macOS"
    exit()
elif [ "$(uname)" == "Linux" ]; then
    # make the assumption we are on Debian based
    apt update && apt install -y ansible
fi

ansible-galaxy collection install ansible.posix community.general

ansible-playbook ./ansible/playbook.yml

