# Birdwatching IaC - Account Setup Module

## Overview

Terraform module for initial AWS account setup in the Birdwatching project. Provides:

- ECR for images.
- Prometheus EC2 instance in private subnets with SSM.
- Jenkins EC2 instance in private subnets with SSM.

## Requirements

- Terraform v1.12.2.
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
git clone https://github.com/Code-Illuminators/Illuminators_infra
cd birdwatching-iac/tools-setup
```

3. **Run with Makefile:**

```bash
export BIRD_ENV=dev-01
make init # Init
make plan # Generates plan for current workspace.
make apply # Deploys changes
make destroy # Destroy all resources
```
