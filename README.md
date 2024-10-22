# ssh-access-management

## Objective

The **SSH Access Management System** aims to provide a secure, automated solution for granting and revoking time-limited SSH access to developers in an organization. This system leverages Hashicorp Vault for key generation Ansible and Terraform for automation, ensuring that developers can request temporary access to specific servers without compromising security. By automating the process of SSH key creation, public key deployment, and access revocation, the system addresses the challenges of manual access management, improves security, and ensures compliance with organizational access control policies.

## Problems Solved

1. **Temporary Access**: 
   - Provides time-limited access to servers, ensuring that developers do not retain indefinite access, reducing the risk of unauthorized or forgotten accounts.

2. **Automation**: 
   - Eliminates manual steps in key generation and deployment, reducing human error and operational overhead.

3. **Scalability**: 
   - Automates key distribution and management across multiple servers, making it easier to manage access in large environments.

4. **Security**: 
   - Centralizes and secures key handling, reducing the risks of key exposure or misuse by automating public key deployment and timely access revocation.

5. **Auditability**: 
   - Logs all access requests, key generation, and revocation events for better visibility and auditing, ensuring compliance with security policies.

6. **User Convenience**: 
   - Provides an easy-to-use interface through Jenkins, enabling developers to request access on-demand without complex procedures or delays.

## Setup

1. Multipass to Launch Servers - [Dev, Vault, Host]
2. Ansible to setup Vault in Server and run in server mode
3. Terraform to configure the vault to launch secret engines and create users
4. Ansible to configure host machine to support certs created by vault
5. Dev Server which act as client machine which will try to access the host machines by signing their private keys using keys provided by vault.

There is README.md file in each module which explains how to configure and setup the infra required and steps to follow.



