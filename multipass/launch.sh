#!/usr/bin/env bash

VM_NAME="fw-builder"
multipass launch \
    --name "$VM_NAME " \
    --cloud-init cloud-init.yaml \
    --cpus 4 \
    --mem 8G \
    --disk 200G

multipass mount \
    "$HOME/devel" \
    "$VM_NAME:/home/swysocki/devel"
