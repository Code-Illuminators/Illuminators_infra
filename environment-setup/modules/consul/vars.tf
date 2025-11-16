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

variable "availability-zone" {
  description = "Availability zone for subnets"
  type        = string
  default     = "us-east-1a"
}

variable "private-route-id" {
  description = "Route table id with which the private subnet should be associated"
  type        = string
}

variable "private-subnets-for-consul" {
  description = "CIDR block for consul-subnet"
  type        = string
}

variable "vpc-id" {
  description = "The VPC ID where subnet will be created"
  type        = string
}

variable "common_tags" {
  type = map(string)
  default = {
    "CreatedBy"   = "Terraform"
    "Project"     = "Birdwatching"
    "Environment" = "stage-01"
    "Repository"  = "https://github.com/Code-Illuminators/Illuminators_infra"
    "Module"      = "environment-setup"
  }
}
