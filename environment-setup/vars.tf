variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

# variable "private-subnets-for-consul" {
#   description = "CIDR block for consul-subnet"
#   type        = string
# }

variable "availability-zone" {
  description = "Availability zone for subnets"
  type        = string
  default     = "us-east-1a"
}

variable "ami" {
  description = "Machine Image that provides the software necessary to configure and launch an EC2 instance"
  type        = string
  default     = "ami-038b732f1ef375eb5"
}

data "aws_vpc" "account-vpc" {
  tags = {
    Name = "BirdwatchingProject"
  }
}

variable "private-subnet-a-cidr" {
  type        = string
  description = "CIDR block for private subnet A"
}

variable "private-subnet-b-cidr" {
  type        = string
  description = "CIDR block for private subnet B"
}

variable "private-subnet-c-cidr" {
  type        = string
  description = "CIDR block for private subnet C"
}

variable "account-id" {
  type        = string
  description = "AWS Account ID"
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
