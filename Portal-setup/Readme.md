# Birdwatching IaC - Account Setup Module

## Overview

This project deploys a minimal AWS infrastructure using **Terraform** to host a simple, static **Portal Website**. The portal serves as a navigation page (using a single `index.html` file) to link to other projects.

1. **EC2 Instance (`portal_instance`)**:
   - Type: `t3.micro`.
   - Assigned a public IP address.
   - Deploys within the specified subnet (`portal_subnet_id`).
2. **Security Group (`portal_sg`)**:
   - Allows **inbound traffic** on ports **80 (HTTP)** and **443 (HTTPS)** from anywhere (`0.0.0.0/0`).
   - Allows all outbound traffic.
3. **IAM Role and Profile**:
   - Grants the instance permissions for **AWS Systems Manager (SSM)** for easy management without SSH keys.
   - Grants **S3 Read-Only** access.
4. **Backend**:
   - Uses an **S3 backend** for reliable remote state management (`terraform-state-birdwatching-2025`).

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
cd illuminators_infra/portal-setup
```

3. **Run with Makefile:**

```bash
export BIRD_ENV=stage-01
make init # Init
make plan # Generates plan for current workspace.
make apply # Deploys changes
make destroy # Destroy all resources
```

4. **Website configuration**

This website is configured with nginx.
The default /usr/share/nginx/html/index.html should be replaced by index.html from this Porta-setup module
To **birdwatching-portal-assets** s3 bucket should you should put images for background and for html containers with photos and names of developers
