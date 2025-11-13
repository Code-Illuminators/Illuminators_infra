variable "vpc_id" {
  description = "The VPC ID where Jenkins will be deployed"
  type        = string
}

variable "private_subnets_for_prometheus" {
  description = "The subnet where Prometheus will be deployed"
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

variable "ami" {
  description = "Machine Image that provides the software necessary to configure and launch an EC2 instance"
  type        = string
}

variable "common_tags" {
  type = map(string)
}

variable "instance_type" {
  description = "default instance type for our project"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for subnets"
  type        = string
}

variable "private-route-table-id" {
  description = "ID of the private route table used for Jenkins instance networking"
  type        = string
}