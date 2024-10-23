# Vault Dev Server Setup using Ansible

Ansible playbook to set up and start HashiCorp Vault in development mode on a virtual machine (VM). 

In development mode, Vault:
- Runs unsealed and unsecure (for testing purposes only).
- Uses a single, pre-generated root token.
- Stores data in-memory and is wiped on restart.

## Prerequisites

Before running the playbook, ensure that you have the following:

- **Ansible** installed on your local machine.
- A remote VM or server with SSH access.
- An SSH key configured for access to the VM.

## Steps
    
    - Update the inventory file with the IP address of VM
    - Run the playbook vault_dev.yml to install and run vault dev server on VM
    - Use "http://<server-ip>:8200" to access vault UI
    - Run the playbook host_configure.yml to configure host machine after you have configured the vault using terraform