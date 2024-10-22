# Vault Configuration with Terraform

This repository contains a Terraform configuration that sets up HashiCorp Vault to create user accounts and configure SSH signed certificates. It leverages the Userpass authentication method for user management and the SSH secrets engine for managing SSH certificates.

## Prerequisites

Before you begin, ensure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html)
- [HashiCorp Vault](https://www.vaultproject.io/downloads) running locally or on a VM.

## Configuration Overview

The provided Terraform configuration includes the following components:

1. **Vault Provider**: Configures the Vault provider to connect to a Vault instance running on `http://192.168.0.106:8200` using a root token.

2. **Userpass Authentication**: Enables the Userpass authentication method in Vault.

3. **User Creation**: Creates two users, `dev1` and `dev2`, with associated passwords and policies.

4. **Policy Definition**: Defines policies for each user that specify what paths they can access within Vault.

5. **SSH Secrets Engine**: Enables the SSH secrets engine to manage SSH certificates.

6. **SSH Role**: Configures an SSH role that allows signing certificates for the specified users.

7. **Output**: Outputs the SSH CA public key, which can be used on remote servers.