variable "vpc_cidr" {
  description = "cidr for the vpc"
  type        = string
}

variable "jenkins_pv_sb_cidr" {
  description = "cidr for Jenkins private subnet"
  type        = string
}

variable "public_subnet_cidr" {
  description = "cidr for public subnet"
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
  description = "EC2 instance type for Jenkins"
  type        = string
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
  type        = map(string)
  description = "set of ecr"
}
