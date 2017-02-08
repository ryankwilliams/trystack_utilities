#!/bin/bash

# Bash script to configure a trystack environment to create vm instances.

# Trap all keyboard interrupts and call function to handle exception
trap keyboard_interrupt INT

function keyboard_interrupt() {
	echo "CRTL-C, exiting.."
	exit 1
}

# Ansible playbooks
playbooks=(
	"create_network.yaml"
	"add_secgroup_rules.yaml"
	"create_ssh_keys.yaml"
	"add_keypair.yaml"
)

# Run Ansible playbooks
for pb in ${playbooks[@]}; do
	ansible-playbook playbooks/$pb
done
