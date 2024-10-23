# Vault SSH Signing - Client Configuration Guide

Detailed steps for setting up your system to use Vault for SSH key signing. You need to generate SSH key pairs, retrieve a Vault token, sign your public SSH key using Vault, and connect to a server using the signed certificate.

## Step 1: Generate SSH Key Pairs

You first need to generate an SSH key pair to use for authentication.

1. Open your terminal.
2. Run the following command to generate a new SSH key pair:
   
   `ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa`
  

   This will create two files:
   - `~/.ssh/id_rsa`: Your private key (keep this safe).
   - `~/.ssh/id_rsa.pub`: Your public key (you'll use this to get signed).

## Step 2: Retrieve a Token from Vault

To sign your public key, you need to authenticate with Vault and retrieve a token.

   ```bash
   export VAULT_ADDR="http://192.168.0.109:8200" # Replace ip with vault-server ip
   ```

1. Log in to Vault using the `userpass` authentication method:
   ```bash
   vault login -method=userpass username="dev1" password="dev1pass"
   ```

2. Vault will return a token upon successful login. Export this token as an environment variable so it can be used in subsequent commands:
   ```bash
   export VAULT_TOKEN="your-vault-token"
   ```

3. Confirm that the token is correctly set by running:
   ```bash
   echo $VAULT_TOKEN
   ```

## Step 3: Sign Your Public Key Using Vault

Now that you have your Vault token, you can request Vault to sign your SSH public key.

1. Use the `vault write` command to sign your public key:
   ```bash
   vault write ssh/sign/my-ssh-role \
     public_key=@~/.ssh/id_rsa.pub \
     valid_principals="ubuntu"
   ```

   - **public_key**: Path to the SSH public key file you generated earlier.
   - **valid_principals**: The SSH user for whom the certificate is valid (this should match the user that will be logging into the server).

2. Vault will return a signed SSH certificate. Save this certificate here:
   ```bash
    ~/.ssh/id_rsa-cert.pub
   ```

   The certificate can now be used alongside your private key for authentication.

## Step 4: Configure SSH to Use the Signed Certificate

Once you have the signed certificate, you can use it to authenticate with your server.

1. Use the following command to connect to a remote server using the private key and the signed certificate:
   ```bash
   ssh -i ~/.ssh/id_rsa -i ~/.ssh/id_rsa-cert.pub ubuntu@server-ip-host
   ```

   - **server-ip-host**: The IP address of the server you're connecting to.

Ensure that the server has been configured to trust the Vault CA public key.
