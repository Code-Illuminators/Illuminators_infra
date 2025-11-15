# Birdwatching IaC - Environment Setup Module

## Overview

Terraform module for AWS environment setup in the Birdwatching project. Provides:

- Route tables for private and public subnets.
- Consul EC2 instance in private subnets with SSM.
- Internet Gateway.
- Elastic IP for NAT.
- Binds the private subnet of Jenkins and Consul to the private routing table.

## Requirements

- Pre-deployed module [`birdwatching-iac/account-setup`]
- Terraform v1.13.3.
- AWS CLI configured.
- Git and Make.

## Installation and Setup

1. **Install AWS CLI:**
   Download and install the AWS CLI. Then configure your credentials:

```bash
aws configure
```

Enter your AWS Access Key ID, Secret Access Key, default region (e.g., us-east-1), and output format (e.g., json).

2. **Clone the Repository:**

```bash
git clone https://github.com/Maars-Team/birdwatching-iac.git
cd birdwatching-iac/environment-setup
```

3. **Run with Makefile:**

```bash
export BIRD_ENV=dev-01
make init # Init
make plan # Generates plan for current workspace.
make apply # Deploys changes
make destroy # Destroy all resources
```
