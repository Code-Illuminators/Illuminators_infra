# Consul ECS Secure Cluster Module

This Terraform module deploys a secure 3-node Consul server cluster on AWS ECS (Fargate) with full automation for certificates, tokens, networking, and cluster formation.
It is designed for multi-application environments, including support for the Birdwatching and Illuminators apps.

---

# Secure Consul Cluster on ECS

Runs three Consul server nodes across three availability zones.

Uses TLS encryption, ACLs, and custom bootstrap token.

Supports retry_join with dynamic discovery (AWS Cloud Map / Route 53).

# Automated Secrets & Config

Jenkins (or CI pipeline) generates:

TLS certificates

Gossip encryption key

Bootstrap ACL token

Terraform loads all generated secrets from AWS Secrets Manager.

# Custom Consul Image

Module supports a custom ECR image with:

Pre-baked certificates

Server configuration

ACL bootstrap logic

# Full Networking Setup

Multi-AZ subnets

Private DNS namespace via Route 53 / Cloud Map

# SSM Exec Support

Connect to ECS tasks using AWS SSM:

```
aws ecs execute-command \
  --cluster consul-cluster \
  --task <task-id> \
  --container consul-server \
  --command "/bin/sh" \
  --interactive
```

Allows validating cluster state from inside the container.

# Module Inputs

| Variable           | Description                            | Required |
| ------------------ | -------------------------------------- | -------- |
| env                | Environment name (dev, stage, prod)    | Yes      |
| vpc_id             | VPC where the cluster will run         | Yes      |
| private_subnet_ids | List of 3 private subnets (one per AZ) | Yes      |
| common_tags        | Map of tags applied to all resources   | Yes      |
| consul_image       | URI of the custom Consul image in ECR  | Yes      |

# How It Works

1. CI/CD Generates Secrets

Jenkins creates:

```
consul keygen         → gossip encryption key
python uuid           → master token
consul                → TLS certificates
```

Secrets uploaded to:

```
/consul/consul-agent-ca
/consul/consul-agent-ca-key
/consul/server-hcl
/consul/dc1-server-consul-0
```

2. Terraform Reads Secrets

Terraform loads all values from AWS Secrets Manager and injects them into ECS task definitions.

3. ECS Deploys Consul Cluster

Each container uses:

Correct bind interface

TLS certificates

ACL tokens

Dynamic retry_join configuration

4. Cluster Becomes Reachable

You can join the cluster and inspect it:

```
consul members
curl -f https://localhost:8500/v1/status/leader
```

# Validation Steps

1. Check ECS service

All three tasks should be running

Cloud Map should show 3 healthy endpoints

2. Connect via SSM

```
aws ecs execute-command --cluster consul-cluster --task <task-id>   --container consul-server  --command "/bin/sh" --profile <aws_profile> --region <region>

```

Enter the master token

```
export CONSUL_HTTP_TOKEN=<bootstrap-token>
```

Verify members

```
consul members
```

Expected output:

```
Node  Address      Status  Type
server-0 10.0.x.x  alive   server
server-1 10.0.x.x  alive   server
server-2 10.0.x.x  alive   server
```
