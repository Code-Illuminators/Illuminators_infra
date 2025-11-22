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

variable "az-a" {
  type = string
}

variable "az-b" {
  type = string
}

variable "az-c" {
  type = string
}

variable "account-id" {
  type        = string
  description = "AWS Account ID"
}

