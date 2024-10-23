# Setting Up a Dummy Server using Multipass

This guide explains how to use [Multipass](https://multipass.run/) to launch a dummy server (virtual machine) and retrieve its IP address. Multipass is a lightweight tool that allows you to spin up Ubuntu virtual machines quickly on your local machine.

## Prerequisites

Before starting, make sure you have the following:

- **Multipass** installed on your local machine. Follow the official installation instructions for your platform [here](https://multipass.run/install).
  
## Steps to Launch a Dummy Server with Multipass

### 1. Verify Multipass Installation

Once you’ve installed Multipass, verify the installation by running:

`multipass --version`

### 2. Launch Vault Server

We will use this server to setup vault

`multipass launch --name vault-server --network "Wi-Fi"`

To retrieve the IP address run:

`multipass info vault-server`

### 2. Launch Dev Servers

We will us these machine to simulate the client

`multipass launch --name dev-01 --network "Wi-Fi"`
`multipass launch --name dev-02 --network "Wi-Fi"`

### 3. Launch Host Servers

These are the machine to which devs need access to

`multipass launch --name host-01 --network "Wi-Fi"`
`multipass launch --name host-02 --network "Wi-Fi"`







