# Vault provider configuration (assuming Vault is running locally)
provider "vault" {
  address = "http://192.168.0.109:8200" # Replace ip with vault-server ip
  token = "root"
}

# Enable Userpass authentication method if not already enabled
resource "vault_auth_backend" "userpass" {
  type = "userpass"
  description = "Userpass Authentication"
}

# Vault_generic_endpoint allows HTTP API calls through Vault
# Create dev1 in Vault using Userpass auth
resource "vault_generic_endpoint" "dev1" {
  path                 = "auth/${vault_auth_backend.userpass.path}/users/dev1"
  ignore_absent_fields = true

  data_json = <<EOT
    {
    "token_policies": ["dev1_policy"],
    "password": "dev1pass"
    }
    EOT
}

# Create dev2 in Vault using Userpass auth
resource "vault_generic_endpoint" "dev2" {
  path                 = "auth/${vault_auth_backend.userpass.path}/users/dev2"
  ignore_absent_fields = true

  data_json = <<EOT
    {
    "token_policies": ["dev2_policy"],
    "password": "dev2pass"
    }
    EOT
}

# Define a policy for dev1
resource "vault_policy" "dev1_policy" {
  name = "dev1_policy"
  policy = <<EOT
    path "secret/data/dev1/*" {
    capabilities = ["read", "list"]
    }

    path "ssh/sign/my-ssh-role" {
    capabilities = ["create", "update"]
    }
    EOT
}

# Define a policy for dev2
resource "vault_policy" "dev2_policy" {
  name = "dev2_policy"
  policy = <<EOT
    path "secret/data/dev2/*" {
    capabilities = ["read", "list"]
    }

    path "ssh/sign/my-ssh-role" {
    capabilities = ["create", "update"]
    }
    EOT
}

# Enable the SSH secrets engine in Vault
resource "vault_mount" "ssh" {
  path = "ssh"
  type = "ssh"
  description = "SSH Certificate Authority"
}

# Generate the SSH CA signing key
resource "vault_ssh_secret_backend_ca" "signing_key" {
  backend = vault_mount.ssh.path
  generate_signing_key = true
}

# Define an SSH role that allows signing certificates
resource "vault_ssh_secret_backend_role" "ssh_cert_role" {
  name                = "my-ssh-role"
  backend             = vault_mount.ssh.path
  allow_user_certificates = true
  allowed_users       = "*"
  allowed_extensions  = "permit-pty"
  key_type            = "ca"
  default_extensions  = {
    "permit-pty" = ""
  }
  default_user        = "ubuntu"
  ttl                 = "30m"  # Set a maximum TTL for the certificates
}

# Output the SSH CA public key for use on remote servers
output "ssh_ca_public_key" {
  value = vault_ssh_secret_backend_ca.signing_key.public_key
}

