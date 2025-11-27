# Birdwatching IaC - Account Setup Module

## Overview

Terraform module for initial AWS account setup in the Birdwatching project. Provides:

- S3 state bucket with encryption/versioning/locks.
- DynamoDB lock table.
- IAM users/roles.
- VPC.
- Jenkins EC2 instance in private subnets with SSM.
- Creates initial IAM users
- Grants them **AdministratorAccess**
- Creates a **deployment IAM role**
- This role is assumed by another AWS account (such as Jenkins or a central CI/CD account)
- Used for performing deployments into this target AWS account
- Creates the **first VPC** in the account
- Sets up essential base networking components

## Requirements

- Terraform v1.13.3.
- AWS CLI configured.
- Git and Make.

## Installation and Setup

1. **Preparation**
   In your .aws/config you should have at least 2 profiles:
   [stage_account]
   aws_access_key_id = <your-ci-access-key>
   aws_secret_access_key = <your-ci-secret-key>
   region = us-east-1
   -- the main account, where Jenkins or something else can deploy across account from(exp. from stage account to dev/prod)

[profile default]
aws_access_key_id = <target-account-access-key>
aws_secret_access_key = <target-account-secret-key>
region = us-east-1
--the account, you want want to setup this module for

2. **Install AWS CLI:**
   Download and install the AWS CLI. Then configure your credentials:

```bash
aws configure
```

Enter your AWS Access Key ID, Secret Access Key, default region (e.g., us-east-1), and output format (e.g., json).

3. **Clone the Repository:**

```bash
git clone https://github.com/Maars-Team/birdwatching-iac.git
cd birdwatching-iac/account-setup
```

4. **Run with Makefile:**

```bash
export BIRD_ENV=dev-01
make init # Init
make plan # Generates plan for current workspace.
make apply # Deploys changes
make destroy # Destroy all resources
```
