#!/usr/bin/env python3

import yaml
import os

with open('config.yml', 'r') as file:
    config = yaml.safe_load(file)

inventory = {
    'all': {
        'hosts': {}
    },
    'masters': {
        'hosts': {}
    },
    'workers': {
        'hosts': {}
    },
    '_meta': {
        'hostvars': {}
    }
}

ssh_user = config['ssh_user']
ssh_key = config['ssh_key']

for master in config['masters']:
    inventory['all']['hosts'][master['name']] = {'ansible_host': master['ip']}
    inventory['masters']['hosts'][master['name']] = {'ansible_host': master['ip']}
    inventory['_meta']['hostvars'][master['name']] = {
        'ansible_user': ssh_user,
        'ansible_ssh_private_key_file': ssh_key
    }

for worker in config['workers']:
    inventory['all']['hosts'][worker['name']] = {'ansible_host': worker['ip']}
    inventory['workers']['hosts'][worker['name']] = {'ansible_host': worker['ip']}
    inventory['_meta']['hostvars'][worker['name']] = {
        'ansible_user': ssh_user,
        'ansible_ssh_private_key_file': ssh_key
    }

# Create the ansible directory if it doesn't exist
os.makedirs('ansible', exist_ok=True)

# Write the inventory to ansible/inventory.yml
with open('ansible/inventory.yml', 'w') as outfile:
    yaml.dump(inventory, outfile, default_flow_style=False)

print("Ansible inventory written to ansible/inventory.yml")

