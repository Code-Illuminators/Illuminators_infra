variable "vpc-id" {
  description = "The VPC ID where resources will be deployed"
  type        = string
}

variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "common_tags_illuminati" {
  type = map(string)
  default = {
    "CreatedBy"   = "Terraform"
    "Project"     = "Illuminati"
    "Environment" = "stage-01"
    "Repository"  = "https://github.com/Code-Illuminators/Illuminators_infra"
    "Module"      = "environment-setup"
  }
}

variable "private-route-table-id" {
  description = "Route table id with which the private subnets should be associated"
  type        = string
}

variable "public-route-table-id" {
  description = "Route table id with which the public subnet should be associated"
  type        = string
}

variable "cluster-name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "private-eks-subnet-a" {
  description = "CIDR block for private EKS subnet A"
  type        = string
}

variable "private-eks-subnet-b" {
  description = "CIDR block for private EKS subnet B"
  type        = string
}

variable "public-eks-subnet-a" {
  description = "CIDR block for public EKS subnet A"
  type        = string
}

variable "public-eks-subnet-b" {
  description = "CIDR block for public EKS subnet B"
  type        = string
}

variable "eks-k8s-version" {
  description = "The Kubernetes version for the EKS cluster"
  type        = string
}


