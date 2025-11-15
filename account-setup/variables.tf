variable "vpc_cidr" {
  description = "cidr for the vpc"
  type        = string
}

variable "private_subnet_cidr" {
  description = "cidr for Jenkins private subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone"
  type        = string
}

variable "ami" {
  description = "AMI ID for Jenkins EC2"
  type        = string
  default     = "ami-07860a2d7eb515d9a"
}

variable "jenkins_instance_type" {
  description = "ec2 instance type for the Jenkins server"
  type        = string
  default     = "c7i-flex.large"
}

variable "user_data" {
  description = "User data script for Jenkins EC2"
  type        = string
  default     = null
}

variable "env" {
  type        = string
  description = "name of the environment"
}

variable "project" {
  type        = string
  description = "project name"
}

variable "ecr_set" {
  type        = list(string)
  description = "set of ECRs for Jenkins' pushing docker images"
}
