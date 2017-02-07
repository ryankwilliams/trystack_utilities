# trystack_utilities

The purpose of this project is to provide Ansible playbook's to automate the
process of setting up a new trystack OpenStack environment.

## Requirements

* Bash
* Python
* Python virtualenv (optional)

## Install Python virtualenv

Install Python virtualenv if you would like to install the required Python
packages in an isolated environent.

```Bash
$ pip install virtualenv
```

## Install required Python packages

Install the Python packages defined inside the projects requirements.txt.

```Bash
$ pip install -r requirements.txt
```

## Access TryStack

Visit http://trystack.org to learn more.

You will need to create a trystack account in order to use the tenant. This
will require you to login with your Facebook account. The trystack dashboard
link can be found here: https://x86.trystack.org/dashboard/auth/login/

## Download your OpenStack RC File

Once you logged in, you will need to download your OpenStack RC file for API
access. Follow the paths below by clicking on each one in your web browser.

**Project -> Access & Security -> API Access -> Download OpenStack RC File**

Save this file to any location you prefer.

## Get your OpenStack account password

Now that you have your OpenStack RC file, you will need to get the API
password and add it to the RC file. This file contains your credential
information to access the tenant via API.

Follow the paths below by clicking on each one in your web browser to get
your API password.

**Project -> Settings -> API Password -> Request API password**

Once you have the password, you will need to update your RC file to export
this value in the OS_PASSWORD environment variable. Make sure to comment out
the lines that ask you for the password.

```Bash
#echo "Please enter your OpenStack Password: "
#read -sr OS_PASSWORD_INPUT
#export OS_PASSWORD=$OS_PASSWORD_INPUT

export OS_PASSWORD="password_goes_here"
```

## Setup your OpenStack tenant

In order to call the playbook's you will need to source the OpenStack RC file.
This will inject the environment variables (the credential information) which
the API's will read from.

```Bash
$ source trystack-rc.sh
```

The playbooks below range from setting up your trystack tenants network,
configuring security group rules, creating keys for SSH protocol and
adding key pair to OpenStack.

**Configure Network**
```Bash
$ (venv) ansible-playbook create_network.yaml
```

**Add Security Group Rules**
```Bash
$ (venv) ansible-playbook add_secgroup_rules.yaml
```

**Add SSH key for key pair**
```Bash
$ (venv) ansible-playbook add_keypair.yaml
```

**Create keys for SSH protocol**
```Bash
$ (venv) ansible-playbook create_ssh_keys.yaml
```

## Create a resource
```Bash
# Boot a VM
$ (venv) nova boot --flavor 2 --image Fedora24 --key-name cloud fedora24_vm

# Create floating IP
$ (venv) nova floating-ip-create

# Associate IP with VM
$ (venv) nova floating-ip-associate fedora24_vm 0.0.0.0
```

## Delete a resource
```Bash
# Disassociate floating IP
$ (venv) nova floating-ip-disassociate fedora24_vm 0.0.0.0

# Delete a floating IP
$ (venv) nova floating-ip-delete 0.0.0.0

# Delete a VM
$ (venv) nova delete fedora24_vm
```
