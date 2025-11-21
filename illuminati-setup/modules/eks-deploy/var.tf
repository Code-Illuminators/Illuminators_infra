variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "cluster-name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "external-dns-chart" {
  description = "The external-dns helm chart path"
  type        = string
}

variable "frontend-chart" {
  description = "The frontend helm chart path"
  type        = string
}

variable "backend-chart" {
  description = "The backend helm chart path"
  type        = string
}

variable "domain-name" {
  description = "The domain name for app"
  type        = string
}

variable "db-secret-name" {
  description = "The name of the Secrets Manager secret containing DB credentials"
  type        = string
}

variable "account-id" {
  description = "The AWS account ID"
  type        = string
}

variable "vpc-id" {
  description = "The VPC ID where rds will be deployed"
  type        = string
}

variable "aws-load-balancer-controller-chart" {
  description = "The aws load balancer controller helm chart path"
  type        = string
}

variable "ingress-class-chart" {
  description = "The ingress class helm chart path"
  type        = string

}
