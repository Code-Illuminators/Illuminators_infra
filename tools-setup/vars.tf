variable "env" {
  description = "Environment label for tooling account"
  type        = string
}

variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "ami" {
  description = "Machine Image for EC2 instances (Jenkins/Prometheus)"
  type        = string
}

variable "private_subnets_for_jenkins" {
  description = "Subnet where Jenkins will be deployed"
  type        = string
}

variable "private_subnets_for_prometheus" {
  description = "Subnet where Prometheus will be deployed"
  type        = string
}

variable "instance_type" {
  description = "Default instance type for our project"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for subnets"
  type        = string
}

variable "ecr_repo_name" {
  description = "Name of the single ECR repository"
  type        = string
}

