# Terraform Infrastructure Modules

This repository contains all Terraform modules used to provision infrastructure across multiple AWS accounts and environments.  
Each module is responsible for a specific part of the platform — from initial AWS account bootstrapping to application deployments, CI/CD tooling, and supporting services.

---

# Modules Overview

Below is a summary of all modules included in this repository:

1. **Account Setup**
2. **Environment Setup**
3. **Birdwatching Setup**
4. **Illuminati Setup**
5. **Portal Setup**
6. **Tool Setup** -- if it needed

Each module serves a unique function within the overall architecture.

---

# 1. Account Setup Module

The `account-setup` module bootstraps a new AWS account with all required foundational resources.

## Includes

- Creation of initial IAM users
- Granting **AdministratorAccess**
- Creation of the **first VPC**
- Creation of a **deployment IAM role** for cross-account deployments
- The deployment role must be assumed from another AWS account (e.g. Jenkins or CI/CD account)

## How to Run

````sh
make apply BIRD_ENV=<environment>

# 2. Environment Setup Module

The `environment-setup` module provisions shared environment infrastructure used by multiple applications.

## Includes
- Creation of EKS resources
- Deployment of Consul infrastructure
- Provisioning of an S3 bucket for images
- Additional foundational environment-wide components

## Notes
- Must be deployed **after Account Setup**
- Depends on:
  - Initial VPC
  - Deployment IAM role

---

# 3. Birdwatching Setup Module

The `birdwatching-setup` module deploys all required infrastructure for the Birdwatching application.

## Includes
- Compute resources
- Networking components
- Application-specific AWS services
- Deployments into EKS or other compute layers (depending on architecture)

## Notes
- Must be deployed **after Environment Setup**

---

# 4. Illuminati Setup Module

The `illuminati-setup` module provisions infrastructure for the Illuminati application.

## Includes
- EKS cluster resources
- RDS database
- EKS node groups
- EKS application deployments

## Notes
- Depends on the resources created in **Environment Setup**

---

# 5. Portal Setup Module

The `portal-setup` module deploys infrastructure for hosting a one-page static website.

## Includes
- S3 bucket for static hosting
- CloudFront distribution
- DNS configuration
- Other web-serving infrastructure components

## Notes
- Can be deployed after environment-level modules are ready

---

# 6. Tool Setup Module

The `tool-setup` module provisions DevOps tooling and shared operational services.

## Includes
- Creation of ECR repositories
- Deployment of Jenkins
- Deployment of Prometheus monitoring stack

## Notes
- Executed as needed depending on required tooling

---

# Deployment Order

To ensure correct dependency resolution, modules must be deployed in the following order:

1. **Account Setup**
   - Bootstraps AWS account
   - Creates deployment IAM role
   - Sets up initial VPC

2. **Environment Setup**
   - Creates EKS
   - Deploys Consul
   - Creates shared S3 buckets

3. **Birdwatching Setup**
   - Deploys Birdwatching infrastructure

4. **Illuminati Setup**
   - Deploys Illuminati infrastructure
   - Creates RDS
   - Creates EKS node groups
   - Deploys EKS workloads

5. **Portal Setup**
   - Deploys static website infrastructure

6. **Tool Setup** (optional / as needed)
   - Creates ECR repositories
   - Deploys Jenkins
   - Deploys Prometheus

---

# How to Deploy Any Module

All modules use a unified deployment command:

```sh
make apply BIRD_ENV=<environment>
````

### Example:

```sh
make apply BIRD_ENV=stage
```

---

# AWS Credentials Requirements

AWS CLI must be configured with two profiles:

### `stage_account`

Used by CI/CD or Jenkins to perform deployments.

### `default`

Credentials for the target AWS account where resources will be deployed.

### Example `~/.aws/config`

```
[stage_account]
region = us-east-1
aws_access_key_id = <key>
aws_secret_access_key = <secret>

[default]
region = us-east-1
aws_access_key_id = <key>
aws_secret_access_key = <secret>
```

---

# 📄 Notes

- Each module must be executed only after its dependencies are created.
- CI/CD must assume the deployment role created in **Account Setup**.
- Environment Setup is required before any application-specific deployments.
- Tool Setup is optional and depends on project needs.

---
