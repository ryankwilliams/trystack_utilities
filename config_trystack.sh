#!/bin/bash

# Bash script to configure a trystack environment to create vm instances.

# Trap all keyboard interrupts and call function to handle exception
trap keyboard_interrupt INT

function keyboard_interrupt() {
	echo "CRTL-C, exiting.."
	exit 1
}

# Run Ansible playbook
ansible-playbook config_trystack.yml
